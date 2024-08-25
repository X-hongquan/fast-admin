package com.chq.app.generator;

import lombok.Data;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;


@Component
public class ControllerBuilder {


    private static final Set<String> paramNameFilter = Set.of(
            "response", "request"
    );

    public List<FileItem> build() {
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
                                .append("\turl: '" + prefix + requestInfo.getUri() + "',\n")
                                .append("\tmethod: '" + requestInfo.getMethod() + "',\n");
                        if (parameters.length > 0 && !temp.isEmpty()) {
                            String method1 = requestInfo.getMethod();
                            if ("get".equals(method1) || "delete".equals(method1)) {
                                sb.append("\tparams: ").append(temp).append(",\n");
                            } else if ("post".equals(method1) || "put".equals(method1)) {
                                sb.append("\tdata: ").append(temp).append("\n");
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
                if (annotation.value().length>0) uri = annotation.value()[0];
                this.method = "get";
            } else if (method.isAnnotationPresent(PostMapping.class)) {
                PostMapping annotation = method.getAnnotation(PostMapping.class);
                if (annotation.value().length>0) uri = annotation.value()[0];
                this.method = "post";
            } else if (method.isAnnotationPresent(PutMapping.class)) {
                PutMapping annotation = method.getAnnotation(PutMapping.class);
                if (annotation.value().length>0) uri = annotation.value()[0];
                this.method = "put";
            } else if (method.isAnnotationPresent(DeleteMapping.class)) {
                DeleteMapping annotation = method.getAnnotation(DeleteMapping.class);
                if (annotation.value().length>0) uri = annotation.value()[0];
                this.method = "delete";
            }
        }
    }
}
