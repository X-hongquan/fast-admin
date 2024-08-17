package com.chq.app;

import okio.Path;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Nullable;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.lang.reflect.Type;
import java.net.URL;
import java.util.*;


public class Builder {
    GeneratorFilter type = new TypeGeneratorFilter();
    GeneratorFilter api = new APIGeneratorFilter();


    public byte[] builderType() {
        Class<? extends Builder> aClass = this.getClass();
        URL url = aClass.getResource(".");
        String path = url.getFile();
        File files = new File(path);
        StringBuilder sb = new StringBuilder();
        traversTypeFile(sb, files);
        return sb.toString().getBytes();

    }

    public void builderAPI(String mode, List<FileObj> objs) {
        Class<? extends Builder> aClass = this.getClass();
        URL url = aClass.getResource(".");
        String path = url.getFile();
        File files = new File(path);
        traversAPIFile(files, mode, objs);

    }

    public void traversAPIFile(File files, String mode, List<FileObj> objs) {
        File[] fileList = files.listFiles();
        for (File file : fileList) {
            if (file.isDirectory()) {
                if ((api.filterPackage(file.getName()))) {
                    traversAPIFile(file, mode, objs);
                }
            } else {
                String className = fileGetClassName(file);
                if (api.filterClassByClassName(className)) {
                    APIItem apiItem = new APIItem(className);
                    String render = apiItem.render(mode);
                    String s = StringUtils.substringAfterLast(className, ".");
                    String fileName = s.replace("Controller", "").toLowerCase(Locale.ROOT);
                    objs.add(new FileObj(render.getBytes(), fileName));

                }
            }
        }
    }

    public void traversTypeFile(StringBuilder sb, File files) {
        File[] fileList = files.listFiles();
        for (File file : fileList) {
            if (file.isDirectory()) {
                if ((type.filterPackage(file.getName()))) {
                    traversTypeFile(sb, file);
                }
            } else {
                String className = fileGetClassName(file);
                if (type.filterClassByClassName(className)) {
                    TypeItem typeItem = new TypeItem(className);
                    sb.append(typeItem.render("无意义"));
                }
            }
        }
    }


    public static String fileGetClassName(File file) {
        String absolutePath = file.getAbsolutePath();
        String[] path = absolutePath.split("classes");
        String substring = path[1].substring(1, path[1].length() - 6);
        String className = substring.replace(File.separator, ".");
        return className;
    }


    public static String javaTypeToTsType(String javaType) {
        String type = switch (javaType) {
            case "Integer" -> "number";
            case "Long", "String", "BigDecimal", "LocalDateTime" -> "string";
            case "List", "Set" -> "Array";
            case "MultipartFile" -> "FormData";
            case "HttpServletResponse" -> null;
            case null -> "void";
            default -> javaType;
        };
        return type;
    }


    class TypeGeneratorFilter implements GeneratorFilter {
        @Override
        public boolean filterField(Field field) {
            Set<String> fieldExclude = Set.of(
                    "serialVersionUID",
                    "params"
            );
            return !fieldExclude.contains(field.getName());
        }

        @Override
        public boolean filterClassByClass(Class<?> clazz) {
            return false;
        }

        @Override
        public boolean filterClassByClassName(String className) {
            String[] str = className.split("\\.");
            for (String s : str) {
                if (filterPackage(s))
                    return true;
            }
            return false;
        }


        @Override
        public boolean filterPackage(String directoryName) {
            Set<String> packageName = Set.of(
                    "common",
                    "domain",
                    "pojo",
                    "dto",
                    "vo",
                    "form"
            );
            return packageName.contains(directoryName);
        }

        @Override
        public boolean filterMethod(Method method) {
            return false;
        }


    }


    class TypeItem implements Item {
        GeneratorFilter filter = new TypeGeneratorFilter();
        Class<?> clazz;
        String headerTemplate = "export interface %s {\n";
        String headerTemplateGeneric = "export interface %s<T> {\n";
        String bodyTemplate = "    %s: %s\n";
        String footer = "}\n";
        Map<String, String> map = new LinkedHashMap<>();
        boolean isGeneric = false;

        public TypeItem(Class<?> clazz) {
            this.clazz = clazz;
        }

        public TypeItem(String className) {
            try {
                this.clazz = Class.forName(className);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }


        @Override
        public String render(@Nullable String s) {
            StringBuilder sb = new StringBuilder();
            buildBody(clazz);
            String header = "";
            if (isGeneric)
                header = String.format(headerTemplateGeneric, clazz.getSimpleName());
            else
                header = String.format(headerTemplate, clazz.getSimpleName());
            sb.append(header);
            map.forEach((k, v) -> sb.append(String.format(bodyTemplate, k, v)));
            sb.append(footer);
            return sb.toString();
        }

        @Override
        public void buildBody(Class<?> clazz) {
            Field[] declaredFields = clazz.getDeclaredFields();
            for (Field declaredField : declaredFields) {
                if (filter.filterField(declaredField)) {
                    Type genericType = declaredField.getGenericType();
                    String name = declaredField.getType().getName();
                    String typeName = genericType.getTypeName();
                    if ("T".equals(typeName)) {
                        map.put(declaredField.getName(), "T");
                        isGeneric = true;
                    } else if (name.equals(typeName)) {
                        map.put(declaredField.getName(), javaTypeToTsType(StringUtils.substringAfterLast(name, ".")));
                    } else {
                        String val;
                        if (typeName.endsWith("[]")) {
                            String s = StringUtils.substringAfterLast(typeName, ".");
                            val = String.format("Array<%s>", javaTypeToTsType(s.substring(0, s.length() - 2)));
                        } else {
                            StringBuilder prefix = new StringBuilder();
                            StringBuilder suffix = new StringBuilder();
                            int length = typeName.indexOf(">");
                            String leftClassName = typeName.substring(0, length);
                            String[] classNameArr = leftClassName.split("<");
                            for (int i = 0; i < classNameArr.length; i++) {
                                classNameArr[i] = StringUtils.substringAfterLast(classNameArr[i], ".");
                            }
                            String[] tsTypeArr = new String[classNameArr.length];

                            for (int i = 0; i < classNameArr.length; i++) {
                                tsTypeArr[i] = javaTypeToTsType(classNameArr[i]);
                                if (i != classNameArr.length - 1) {
                                    prefix.append("%s<");
                                    suffix.append(">");
                                } else {
                                    prefix.append("%s");
                                }
                            }
                            String format = prefix.append(suffix).toString();
                            val = String.format(format, tsTypeArr);
                        }
                        map.put(declaredField.getName(), val);
                    }
                }
            }
            if (!clazz.getSuperclass().getSimpleName().equals("Object")) {
                buildBody(clazz.getSuperclass());
            }
        }
    }

    class APIGeneratorFilter implements GeneratorFilter {

        private String method;
        private String uri;
        private String paramsKey;

        public String getMethod() {
            String _method = method;
            method = null;
            return _method;
        }

        public String getUri() {
            String _uri = uri;
            uri = null;
            return _uri;
        }

        public String getParamsKey() {
            String _paramsKey = paramsKey;
            paramsKey = null;
            return _paramsKey;
        }

        @Override
        public boolean filterField(Field field) {
            return false;
        }

        @Override
        public boolean filterClassByClass(Class<?> clazz) {
            return clazz.isAnnotationPresent(Controller.class) || clazz.isAnnotationPresent(RestController.class);
        }

        @Override
        public boolean filterClassByClassName(String className) {
            String[] split = className.split("\\.");
            for (String s : split) {
                if (filterPackage(s))
                    return true;
            }
            return false;
        }

        @Override
        public boolean filterPackage(String directoryName) {
            Set<String> packageName = Set.of(
                    "controller"
            );
            return packageName.contains(directoryName);
        }

        @Override
        public boolean filterMethod(Method method) {
            boolean flag = false;
            if (method.isAnnotationPresent(GetMapping.class)) {
                this.method = "get";
                if (method.getAnnotation(GetMapping.class).value().length > 0)
                    this.uri = method.getAnnotation(GetMapping.class).value()[0];
                flag = true;
                paramsKey = "params";
            } else if (method.isAnnotationPresent(PostMapping.class)) {
                this.method = "post";
                if (method.getAnnotation(PostMapping.class).value().length > 0)
                    this.uri = method.getAnnotation(PostMapping.class).value()[0];
                flag = true;
                paramsKey = "data";
            } else if (method.isAnnotationPresent(PutMapping.class)) {
                this.method = "put";
                if (method.getAnnotation(PutMapping.class).value().length > 0)
                    this.uri = method.getAnnotation(PutMapping.class).value()[0];
                flag = true;
                paramsKey = "data";
            } else if (method.isAnnotationPresent(DeleteMapping.class)) {
                this.method = "delete";
                if (method.getAnnotation(DeleteMapping.class).value().length > 0)
                    this.uri = method.getAnnotation(DeleteMapping.class).value()[0];
                flag = true;
                paramsKey = "params";
            }
            return flag;
        }
    }

    class APIItem implements Item {


        APIGeneratorFilter filter = new APIGeneratorFilter();
        Class<?> clazz;
        Set<Request> requests = new LinkedHashSet<>();
        String prefix = "";
        String entityName = "";
        Set<String> types = new LinkedHashSet<>();
        String importTemplate = "import request from '../utils/request'\n\n\n";


        public APIItem(Class<?> clazz) {
            this.clazz = clazz;
        }

        public APIItem(String className) {
            try {
                this.clazz = Class.forName(className);
                String simpleName = clazz.getSimpleName();
                entityName = simpleName.replace("Controller", "");
                if (clazz.isAnnotationPresent(RequestMapping.class)) {
                    if (clazz.getAnnotation(RequestMapping.class).value().length > 0) {
                        prefix = clazz.getAnnotation(RequestMapping.class).value()[0];
                    }
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

        class Request {
            String method;
            String methodName;
            String uri;
            String dataKey;
            String paramsName;
            String paramsType;
            String returnType;
            String template;

            String paramsJSTemplate = "export function %s(%s) {\n" +
                    "    return request({\n" +
                    "        url: '%s',\n" +
                    "        method: '%s',\n" +
                    "        %s: %s\n" +
                    "    })\n" +
                    "}\n\n";

            String noParamsJsTemplate = "export function %s() {\n" +
                    "    return request({\n" +
                    "        url: '%s',\n" +
                    "        method: '%s'\n" +
                    "    })\n" +
                    "}\n\n";

            String paramsTemplate = "export function %s(%s: %s): Promise<%s> {\n" +
                    "    return request({\n" +
                    "        url: '%s',\n" +
                    "        method: '%s',\n" +
                    "        %s: %s\n" +
                    "    })\n" +
                    "}\n\n";
            String noParamsTemplate = "export function %s(): Promise<%s> {\n" +
                    "    return request({\n" +
                    "        url: '%s',\n" +
                    "        method: '%s'\n" +
                    "    })\n" +
                    "}\n\n";
        }

        @Override
        public void buildBody(Class<?> clazz) {
            Method[] methods = clazz.getMethods();
            for (Method method : methods) {
                if (filter.filterMethod(method)) {
                    Request request = new Request();
                    request.methodName = method.getName() + entityName + "API";
                    request.method = filter.getMethod();
                    request.uri = filter.getUri();
                    request.dataKey = filter.getParamsKey();
                    Parameter[] parameters = method.getParameters();
                    if (parameters.length == 0)
                        request.template = request.noParamsTemplate;
                    else {
                        request.template = request.paramsTemplate;
                        for (Parameter parameter : parameters) {
                            String typeName = parameter.getType().getTypeName();
                            request.paramsName = parameter.getName();
                            String s = StringUtils.substringAfterLast(typeName, ".");
                            if (typeName.startsWith("com.chq.app"))
                                types.add(StringUtils.substringAfterLast(typeName, "."));
                            if (s.endsWith("[]")) {
                                String format = "%s[]";
                                request.paramsType = String.format(format, javaTypeToTsType(s.substring(0, s.length() - 2)));

                            } else {
                                request.paramsType = javaTypeToTsType(s);
                            }
                        }
                    }
                    Type type1 = method.getGenericReturnType();
                    String typeName = type1.getTypeName();
                    if (typeName.contains("<")) {
                        int j = typeName.indexOf(">");
                        String leftClassName = typeName.substring(0, j);
                        String[] className = leftClassName.split("<");
                        StringBuilder prefix = new StringBuilder();
                        StringBuilder suffix = new StringBuilder();
                        for (int i = 0; i < className.length; i++) {
                            if (className[i].startsWith("com.chq.app")) {
                                types.add(StringUtils.substringAfterLast(className[i], "."));
                            }
                            className[i] = javaTypeToTsType(StringUtils.substringAfterLast(className[i], "."));
                        }
                        for (int i = 0; i < className.length; i++) {
                            if (i == className.length - 1) {
                                prefix.append("%s");
                            } else {
                                prefix.append("%s<");
                                suffix.append(">");
                            }
                        }
                        prefix.append(suffix);
                        String format = String.format(prefix.toString(), className);
                        request.returnType = format;
                    } else {
                        if (typeName.equals("void")) {
                            request.returnType = "void";
                        } else {
                            String s = StringUtils.substringAfterLast(typeName, ".");
                            if ("R".equals(s)) {
                                request.returnType = "R<void>";
                            } else {
                                request.returnType = javaTypeToTsType(s);
                            }
                        }

                    }
                    requests.add(request);
                }


            }

        }

        @Override
        public String render(@Nullable String s) {
            buildBody(clazz);
            StringBuilder sb = new StringBuilder(importTemplate);
            if (!"js".equals(s)) {
                StringBuilder importType = new StringBuilder("import {");
                for (String type : types) {
                    importType.append(type + ",");
                }
                importType.deleteCharAt(importType.length() - 1);
                importType.append("} from './model'\n\n");
                sb.append(importType);
            }
            for (Request request : requests) {
                if (request.paramsType != null) {
                    if ("js".equals(s)) {
                        String format = String.format(request.paramsJSTemplate, request.methodName, request.
                                        paramsName, request.uri == null ? prefix : prefix + request.uri
                                , request.method, request.dataKey, request.paramsName
                        );
                        sb.append(format);
                    } else {
                        String format = String.format(request.paramsTemplate,
                                request.methodName, request.paramsName, request.paramsType,
                                request.returnType, request.uri == null ? prefix : prefix + request.uri,
                                request.method, request.dataKey, request.paramsName);
                        sb.append(format);
                    }
                } else {
                    if ("js".equals(s)) {
                        sb.append(String.format(request.noParamsJsTemplate, request.methodName,
                                request.uri == null ? prefix : prefix + request.uri,
                                request.method));
                    } else {
                        sb.append(String.format(request.noParamsTemplate,
                                request.methodName, request.returnType,
                                request.uri == null ? prefix : prefix + request.uri,
                                request.method));
                    }
                }
            }

            return sb.toString();
        }
    }


}






