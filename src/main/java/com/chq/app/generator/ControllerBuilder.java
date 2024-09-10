package com.chq.app.generator;

import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Component
public class ControllerBuilder {


    private static final Set<String> paramNameFilter = Set.of(
            "response", "request"
    );


    public List<FileItem> buildTS() {
        List<FileItem> list = new ArrayList<>();
        InputStream resourceAsStream = ControllerBuilder.class.getClassLoader().getResourceAsStream("generator/controller.txt");
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resourceAsStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Class<?> aClass = Class.forName(line);
                if (aClass.isAnnotationPresent(RestController.class) || aClass.isAnnotationPresent(Controller.class)) {
                    StringBuilder sb1 = new StringBuilder();
                    StringBuilder body = new StringBuilder();
                    HashSet<String> importType = new HashSet<>();
                    String prefix = "";
                    sb1.append("import request from '../utils/request.ts'\n\n");
                    if (aClass.isAnnotationPresent(RequestMapping.class)) {
                        RequestMapping annotation = aClass.getAnnotation(RequestMapping.class);
                        if (annotation.value().length > 0)
                            prefix = annotation.value()[0];
                    }
                    for (Method method : aClass.getMethods()) {
                        RequestInfo requestInfo = new RequestInfo(method);
                        if (requestInfo.getMethod().isEmpty()) continue;
                        StringBuilder sb = new StringBuilder();
                        Parameter[] parameters = method.getParameters();

                        List<Parameter> li = new ArrayList<>();
                        int len = parameters.length;
                        if (len > 0) {
                            for (Parameter parameter : parameters) {
                                String paramName = parameter.getName();
                                if ("request".equals(paramName) || "response".equals(paramName)) {
                                } else {
                                    li.add(parameter);
                                }
                            }
                        }

                        String methodName = method.getName() + aClass.getSimpleName().replace("Controller", "") + "API";
                        StringBuilder psb = new StringBuilder("");
                        for (Parameter parameter : li) {
                            String name = parameter.getName();
                            String typeName = parameter.getType().getTypeName();
                            if (!typeName.startsWith("java."))
                                importType.add(StringUtils.substringAfterLast(typeName, "."));
                            psb.append(name).append(": ");
                            if (typeName.contains("[]")) {
                                String type = StringUtils.substringAfterLast(typeName, ".");
                                String replace = type.replace("[]", "");
                                String s = javaToTS(replace);
                                psb.append(s).append("[]").append(",");
                            } else {
                                String s1 = StringUtils.substringAfterLast(typeName, ".");
                                String s = javaToTS(s1);
                                psb.append(s);
                                psb.append(",");
                            }
                        }
                        if (li.size() > 0)
                            psb.deleteCharAt(psb.length() - 1);

                        StringBuilder rsb = new StringBuilder();
                        Type type = method.getGenericReturnType();
                        String typeName = type.getTypeName();
                        if (typeName.contains("<")) {
                            String p = StringUtils.substringBefore(typeName, ">");
                            String[] split = p.split("<");
                            String[] copy = new String[split.length];
                            for (int i = 0; i < split.length; i++) {
                                String s = StringUtils.substringAfterLast(split[i], ".");
                                if (!split[i].startsWith("java."))
                                    importType.add(s);
                                copy[i] = javaToTS(s);
                            }
                            rsb.append(copy[0]);
                            for (int i = 1; i < copy.length; i++) {
                                rsb.append("<").append(copy[i]);
                            }
                            for (int i = 1; i < copy.length; i++) {
                                rsb.append(">");
                            }
                        } else if ("void".equals(typeName)) {
                            rsb.append("void");
                        } else {
                            String s1 = StringUtils.substringAfterLast(typeName, ".");
                            if (!typeName.startsWith("java."))
                                importType.add(s1);
                            String s = javaToTS(s1);
                            if ("R".equals(s))
                                rsb.append("R<void>");
                            else
                                rsb.append(s);
                        }

                        String header = "export function %s(%s): Promise<%s> {\n ";
                        String format = String.format(header, methodName, psb, rsb);
                        body.append(format);
                        body.append("return request({\n")
                                .append(String.format("  url: '%s%s',\n", prefix, requestInfo.getUri()))
                                .append(String.format("  method: '%s',\n", requestInfo.getMethod()));
                        if (li.size() > 0) {
                            if ("get".equals(requestInfo.getMethod()) || "delete".equals(requestInfo.getMethod())) {
                                body.append(String.format("  params: %s\n", psb.toString().split(":")[0]));
                            } else if ("post".equals(requestInfo.getMethod()) || "put".equals(requestInfo.getMethod())) {
                                body.append(String.format("  data: %s\n", psb.toString().split(":")[0]));
                            }
                        }
                        body.append("  })\n").append("}\n\n");
                    }
                    sb1.append("import {");
                    for (String s : importType) {
                        sb1.append(s).append(",");
                    }
                    sb1.deleteCharAt(sb1.length() - 1);
                    sb1.append("} from './model.ts'").append("\n\n").append(body);
                    String replace = aClass.getSimpleName().replace("Controller", "");
                    String name = replace.substring(0, 1).toLowerCase() + replace.substring(1);
                    FileItem fileItem = new FileItem(sb1.toString(), name + ".ts");
                    list.add(fileItem);
                }

            }
        } catch (IOException e) {

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<FileItem> buildJS() {
        List<FileItem> list = new ArrayList<>();
        InputStream resourceAsStream = ControllerBuilder.class.getClassLoader().getResourceAsStream("generator/controller.txt");
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resourceAsStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Class<?> aClass = Class.forName(line);
                String prefix = "";
                if (aClass.isAnnotationPresent(RestController.class) || aClass.isAnnotationPresent(Controller.class)) {
                    if (aClass.isAnnotationPresent(RequestMapping.class)) {
                        RequestMapping annotation = aClass.getAnnotation(RequestMapping.class);
                        String[] value = annotation.value();
                        if (value.length > 0)
                            prefix = value[0];
                    }
                    StringBuilder sb1 = new StringBuilder();
                    sb1.append("import request from '@/utils/request.js'\n\n");
                    Method[] methods = aClass.getMethods();
                    for (Method method : methods) {
                        RequestInfo requestInfo = new RequestInfo(method);
                        if (requestInfo.getMethod().isEmpty()) continue;
                        StringBuilder sb = new StringBuilder();
                        sb.append("export function " + method.getName()).append(aClass.getSimpleName().replace("Controller", "") + "API").append("(");
                        Parameter[] parameters = method.getParameters();
                        String temp = "";
                        if (parameters.length > 0) {
                            for (Parameter parameter : parameters) {
                                if (!paramNameFilter.contains(parameter.getName())) {
                                    sb.append(parameter.getName()).append(",");
                                    temp = parameter.getName();
                                }
                            }
                            if (!temp.isEmpty())
                                sb.deleteCharAt(sb.length() - 1);
                        }
                        sb.append(") {\n");
                        sb.append("  return request({\n")
                                .append("  url: '" + prefix + requestInfo.getUri() + "',\n")
                                .append("  method: '" + requestInfo.getMethod() + "',\n");
                        if (parameters.length > 0 && !temp.isEmpty()) {
                            String method1 = requestInfo.getMethod();
                            if ("get".equals(method1) || "delete".equals(method1)) {
                                sb.append("  params: ").append(temp).append(",\n");
                            } else if ("post".equals(method1) || "put".equals(method1)) {
                                sb.append("  data: ").append(temp).append("\n");
                            }
                        }
                        sb.append("  })\n}\n\n");
                        sb1.append(sb);
                    }
                    list.add(new FileItem(sb1.toString(), aClass.getSimpleName() + ".js"));
                }

            }
        } catch (IOException e) {

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }


    @Data
    class RequestInfo {
        private String uri = "";
        private String method = "";


        public RequestInfo(Method method) {
            if (method.isAnnotationPresent(GetMapping.class)) {
                GetMapping annotation = method.getAnnotation(GetMapping.class);
                if (annotation.value().length > 0) uri = annotation.value()[0];
                this.method = "get";
            } else if (method.isAnnotationPresent(PostMapping.class)) {
                PostMapping annotation = method.getAnnotation(PostMapping.class);
                if (annotation.value().length > 0) uri = annotation.value()[0];
                this.method = "post";
            } else if (method.isAnnotationPresent(PutMapping.class)) {
                PutMapping annotation = method.getAnnotation(PutMapping.class);
                if (annotation.value().length > 0) uri = annotation.value()[0];
                this.method = "put";
            } else if (method.isAnnotationPresent(DeleteMapping.class)) {
                DeleteMapping annotation = method.getAnnotation(DeleteMapping.class);
                if (annotation.value().length > 0) uri = annotation.value()[0];
                this.method = "delete";
            }
        }
    }


    private static String javaToTS(String javaType) {
        return switch (javaType) {
            case "String", "BigDecimal", "LocalDateTime", "Long", "Double", "Float" -> "string";
            case "Integer" -> "number";
            case "Boolean" -> "boolean";
            default -> javaType;
        };
    }
}
