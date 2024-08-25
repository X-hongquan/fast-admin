package com.chq.app.generator;

import jakarta.annotation.PostConstruct;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.io.*;
import java.lang.reflect.Field;
import java.net.URL;
import java.util.Set;

@Profile("dev")
@Component
public class GenerateResource {

    private static final String typeResource = "src/main/resources/generator/type.txt";

    private static final String apiResource = "src/main/resources/generator/controller.txt";

    private static final Set<String> typeSet = Set.of("pojo", "dto", "form", "vo", "controller");

    private static final String packageName = "\\src\\main\\java\\";

    private static final String appPackage = "com\\chq\\app";

    @PostConstruct
    public void create() {
        String property = System.getProperty("user.dir");
        String replace = property + packageName;
        String path = replace + appPackage;
        File file = new File(path);
        File type = new File(typeResource);
        File file1 = new File(apiResource);

        try (FileWriter typeWriter = new FileWriter(type); FileWriter apiWriter = new FileWriter(file1)) {
            transFiles(file, replace, typeWriter, apiWriter);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private static void transFiles(File file, String replace, FileWriter type, FileWriter api) throws IOException {
        File[] files = file.listFiles();
        for (File f : files) {
            if (f.isDirectory()) {
                if (typeSet.contains(f.getName())) transFiles(f, replace, type, api);
            } else {
                String replace1 = f.getAbsolutePath().replace(replace, "");
                String replace2 = replace1.replace("\\", ".");
                String className = replace2.substring(0, replace2.length() - 5);
                if (StringUtils.substringAfterLast(className, ".").contains("Controller")) {
                    api.write(className + "\n");
                } else {
                    if (!className.contains("Application")) type.write(className + "\n");
                }
            }

        }
    }


}
