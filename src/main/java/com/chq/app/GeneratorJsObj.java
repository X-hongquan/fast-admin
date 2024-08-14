package com.chq.app;

import org.apache.commons.lang3.StringUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Field;
import java.net.URL;
import java.nio.file.Path;

public class GeneratorJsObj {
    public static void main(String[] args) throws ClassNotFoundException, IOException {
        Class<GeneratorJsObj> generatorJsObjClass = GeneratorJsObj.class;
        URL url = generatorJsObjClass.getResource(".");
        File file = new File(url.getPath());

        File file1 = new File(System.getProperty("user.dir") + "\\dto.js");
        System.out.println(file1.getAbsolutePath());
        FileWriter fileWriter = new FileWriter(file1);
        traverseDirectory(file,fileWriter);
        fileWriter.close();
    }
    public static void traverseDirectory(File directory,FileWriter fileWriter) throws ClassNotFoundException, IOException {
        // 获取目录下的所有文件和子目录
        File[] files = directory.listFiles();

        if (files != null) {
            for (File file : files) {
                if (file.isDirectory() ) {
                    if (match(file.getName()))
                    traverseDirectory(file,fileWriter);
                } else {
                    // 如果是文件，打印文件路径
                    String absolutePath = file.getAbsolutePath();
                    String[] classes = absolutePath.split("classes");
                    int lastIndex = classes[1].lastIndexOf(".");
                    String substring = classes[1].substring(1, lastIndex);
                    String replace = substring.replace(File.separator, ".");
                    Class<?> aClass = Class.forName(replace);
                    Field[] declaredFields = aClass.getDeclaredFields();
                    StringBuilder sb = new StringBuilder("const " + StringUtils.substringAfterLast(replace, ".") + " = reactive({\n");
                    for (Field declaredField : declaredFields) {
                        if (declaredField.getName().equals("serialVersionUID"))
                            continue;
                      sb.append("\t"+declaredField.getName() + ": undefined,\n");
                    }
                    sb.append("})\n\n");

                    fileWriter.write(sb.toString());
                }
            }
        }
    }

    public static boolean match(String fileName) {
        if (fileName.equals("dto")||fileName.equals("pojo")||fileName.equals("form")||fileName.equals("vo"))
            return true;
         return false;
    }
}
