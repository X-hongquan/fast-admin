package com.chq.app.generator;

import com.chq.app.common.exception.ServiceException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.Set;

@Component
public class TypeBuilder {

    private static final Set<String> defaultFiledFilter = Set.of(
            "serialVersionUID"
    );


    private static final Set<String> filedFilter = Set.of(
            "roleId", "params", "serialVersionUID"
    );


    public StringBuilder buildTS() {
        StringBuilder sb1 = new StringBuilder();
        InputStream resourceAsStream = TypeBuilder.class.getClassLoader().getResourceAsStream("generator/type.txt");
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resourceAsStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Class<?> aClass = Class.forName(line);
                String simpleName = aClass.getSimpleName();
                String superName = aClass.getSuperclass().getSimpleName();
                StringBuilder sb;
                if ("Object".equals(superName)) {
                    if (aClass.getTypeParameters().length > 0)
                        sb = new StringBuilder("export interface " + simpleName + "<T>" + " {\n");
                    else
                        sb = new StringBuilder("export interface " + simpleName + " {\n");
                } else
                    sb = new StringBuilder("export interface " + simpleName + " extends " + superName + " {\n");
                Field[] declaredFields = aClass.getDeclaredFields();
                for (Field declaredField : declaredFields) {
                    if (!defaultFiledFilter.contains(declaredField.getName())) {
                        String name = declaredField.getType().getName();
                        String typeName = declaredField.getGenericType().getTypeName();
                        if (name.equals(typeName)) {
                            String javaName = StringUtils.substringAfterLast(name, ".");
                            String tsType = javaToTS(javaName);
                            sb.append("  " + declaredField.getName() + ": " + tsType + "\n");
                        } else {
                            System.out.println("typeName = " + typeName);
                            if (typeName.contains("<")) {
                                String s1 = StringUtils.substringBefore(typeName, ">");
                                String[] split = s1.split("<");
                                String[] copy = new String[split.length];
                                for (int i = 0; i < split.length; i++) {
                                    copy[i] = StringUtils.substringAfterLast(split[i], ".");
                                }
                                if (copy.length == 2) {
                                    if ("Set".equals(copy[0]) || "List".equals(copy[0])) {
                                        String s = javaToTS(copy[1]);
                                        sb.append("  " + declaredField.getName() + ": " + s + "[]\n");
                                    }
                                }
                            } else if (typeName.contains("[]")) {
                                String s1 = StringUtils.substringAfterLast(typeName, ".");
                                String replace = s1.replace("[]", "");
                                String s = javaToTS(replace);
                                sb.append("  " + declaredField.getName() + ": " + s + "[]\n");
                            } else if ("T".equals(typeName)) {
                                sb.append("  " + declaredField.getName() + ": T\n");
                            } else {
                                sb.append("  " + declaredField.getName() + ": any\n");
                            }
                        }
                    }
                }
                sb.append("}\n\n");
                sb1.append(sb);
            }

        } catch (IOException e) {
            System.out.println("出异常了");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return sb1;
    }


    public StringBuilder buildJS() {
        StringBuilder sb1 = new StringBuilder();
        InputStream resourceAsStream = TypeBuilder.class.getClassLoader().getResourceAsStream("generator/type.txt");
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resourceAsStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Class<?> aClass = Class.forName(line);
                String simpleName = aClass.getSimpleName();
                StringBuilder sb = new StringBuilder("const " + simpleName + " = reactive({\n");
                Field[] declaredFields = aClass.getDeclaredFields();
                for (Field declaredField : declaredFields) {
                    if (!defaultFiledFilter.contains(declaredField.getName()))
                        sb.append("  " + declaredField.getName() + ": undefined,\n");
                }
                transSuperJS(aClass, sb);
                sb.deleteCharAt(sb.length() - 2).append("})\n\n");
                sb1.append(sb);
            }
        } catch (IOException e) {

        } catch (ClassNotFoundException e) {
            throw new ServiceException("服务异常");
        }
        return sb1;
    }

    private static void transSuperJS(Class<?> aClass, StringBuilder sb) {
        Class<?> superclass1 = aClass.getSuperclass();
        if (superclass1 != null) {
            if (!"Object".equals(superclass1.getSimpleName())) {
                Class<?> superclass = aClass.getSuperclass();
                Field[] declaredFields1 = superclass.getDeclaredFields();
                for (Field declaredField : declaredFields1) {
                    if (!filedFilter.contains(declaredField.getName()))
                        sb.append("  " + declaredField.getName() + ": undefined,\n");
                }
            }
            transSuperJS(superclass1, sb);
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
