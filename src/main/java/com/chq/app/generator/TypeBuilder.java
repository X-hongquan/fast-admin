package com.chq.app.generator;

import com.chq.app.common.exception.ServiceException;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.util.Set;

@Component
public class TypeBuilder {

    private static final Set<String> defaultFiledFilter = Set.of(
            "serialVersionUID"
    );


    private static final Set<String> filedFilter = Set.of(
            "roleId", "params", "serialVersionUID"
    );


    public StringBuilder build() {
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
                        sb.append("\t" + declaredField.getName() + ": undefined,\n");
                }
                transSuper(aClass, sb);
                sb.deleteCharAt(sb.length() - 2).append("})\n\n");
                sb1.append(sb);
            }
        } catch (IOException e) {

        } catch (ClassNotFoundException e) {
            throw new ServiceException("服务异常");
        }
        return sb1;

    }

    private static void transSuper(Class<?> aClass, StringBuilder sb) {
        Class<?> superclass1 = aClass.getSuperclass();
        if (superclass1 != null) {
            if (!"Object".equals(superclass1.getSimpleName())) {
                Class<?> superclass = aClass.getSuperclass();
                Field[] declaredFields1 = superclass.getDeclaredFields();
                for (Field declaredField : declaredFields1) {
                    if (!filedFilter.contains(declaredField.getName()))
                        sb.append("\t" + declaredField.getName() + ": undefined,\n");
                }
            }
            transSuper(superclass1, sb);
        }
    }


}
