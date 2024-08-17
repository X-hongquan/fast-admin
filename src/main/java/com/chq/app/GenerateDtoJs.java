package com.chq.app;

import com.baomidou.mybatisplus.annotation.TableField;

import java.io.File;
import java.io.FileWriter;
import java.lang.reflect.Field;
import java.net.URL;
import java.util.Set;

public class GenerateDtoJs {
    public static void main(String[] args) {
        Class<GenerateDtoJs> generateDtoJsClass = GenerateDtoJs.class;
        URL url = generateDtoJsClass.getResource(".");
        String path = url.getFile();
        File file = new File(path);
        StringBuilder sb = new StringBuilder();
        fileSee(sb, file);
        try(FileWriter fw=new FileWriter("D:\\IdeaProject\\hq-admin\\dto.js")) {
            fw.write(sb.toString());
        }catch (Exception e) {

        }
    }

    public static void fileSee(StringBuilder sb, File files) {
        File[] fileList = files.listFiles();
        for (File file : fileList) {
            if (file.isDirectory()) {
                if (filterPackage(file.getName()))
                    fileSee(sb, file);
            } else {
                String absolutePath = file.getAbsolutePath();
                String[] split = absolutePath.split("classes");
                String substring = split[1].substring(1, split[1].length() - 6);
                String replace = substring.replace(File.separator, ".");
                if (filterClass(replace)) {
                    try {

                        Class<?> aClass = Class.forName(replace);
                        String simpleName = aClass.getSimpleName();
                        String format = "const %s = reactive({\n";
                        sb.append(String.format(format, simpleName));
                        buildBody(sb, aClass);
                        sb.deleteCharAt(sb.length()-2);
                        sb.append("})\n\n");
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }
                }

            }
        }
    }

    private static void buildBody(StringBuilder sb, Class<?> aClass) {
        Field[] fields = aClass.getDeclaredFields();
        for (Field field : fields) {
            if (filterField(field)) {
                String name = field.getName();
                sb.append(String.format("    %s: undefined,\n", name));
            }
        }
        if (!"Object".equals(aClass.getSuperclass().getSimpleName())) {
            buildBody(sb, aClass.getSuperclass());
        }
    }

    public static boolean filterField(Field field) {
        String name = field.getName();
        if (name.equals("serialVersionUID") || name.equals("roleId") || name.equals("params"))
            return false;
        return true;
    }

    public static boolean filterClass(String allClassName) {
        String[] split = allClassName.split("\\.");
        for (String s : split) {
            if (filterPackage(s))
                return true;
        }
        return false;
    }

    public static boolean filterPackage(String name) {
        Set<String> common = Set.of(
                "pojo",
                "dto",
                "vo",
                "form"
        );
        return common.contains(name);
    }

    public static void fileSee(File files, String packageName) {
    }
}
