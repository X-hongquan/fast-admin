package com.chq.app.builder;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class FreeMarkerBuilder {

    public static String convertToClassName(String roleName) {
        return Stream.of(roleName.split("_"))
                .map(part -> part.substring(0, 1).toUpperCase() + part.substring(1).toLowerCase())
                .collect(Collectors.joining());
    }

    public static String conventParamsName(String className) {
        String paramsName = className.substring(0, 1).toLowerCase() + className.substring(1);
        return paramsName;
    }

    public static void build(TableInfo tableInfo, Config config) {

        try {
            // 创建一个FreeMarker实例
            Configuration cfg = new Configuration(Configuration.VERSION_2_3_33);
            // 设置模板文件的路径
            cfg.setClassForTemplateLoading(FreeMarkerBuilder.class, "/templates");

            // 获取模板对象
            Template pojo = cfg.getTemplate("pojo.ftl");
            Template mapper = cfg.getTemplate("mapper.ftl");
            Template xml = cfg.getTemplate("mapperXml.ftl");
            Template service = cfg.getTemplate("service.ftl");
            Template impl = cfg.getTemplate("serviceImpl.ftl");
            Template controller = cfg.getTemplate("controller.ftl");
            Template api = cfg.getTemplate("api.ftl");
            Template pages = cfg.getTemplate("pages.ftl");


            // 创建数据模型
            Map<String, Object> dataModel = new HashMap<>();
            dataModel.put("tableInfo", tableInfo);
            dataModel.put("packageName", config.getPackageName());
            dataModel.put("author", config.getAuthor());
            dataModel.put("columns", tableInfo.getColumns());
            dataModel.put("paramsName", conventParamsName(convertToClassName(tableInfo.getTableName())));
            dataModel.put("date", DateTimeFormatter.ofPattern("yyyy-MM-dd").format(LocalDateTime.now()));
            dataModel.put("className", convertToClassName(tableInfo.getTableName()));
            dataModel.put("jin", "#");

            String s = convertToClassName(tableInfo.getTableName());
            String s1 = conventParamsName(s);
            // 输出路径
            String absPath = config.getAbsPath();
            File pojoFile = new File(absPath + File.separator + "pojo\\" + s + ".java");
            File mapperFile = new File(absPath + File.separator + "mapper\\" + s + "Mapper.java");
            File xmlFile = new File("D:\\IdeaProject\\fast-admin\\src\\main\\resources\\mapper\\" + s + "Mapper.xml");
            File serviceFile = new File(absPath + File.separator + "service\\" + "I" + s + "Service.java");
            File implFile = new File(absPath + File.separator + "service\\impl\\" + s + "ServiceImpl.java");
            File controllerFile = new File(absPath + File.separator + "controller\\" + s + "Controller.java");

            String frontPath = config.getFrontAbsPath();
            File apiFile = new File(frontPath + "api\\" + s1 + ".js");
            String vuePackage = frontPath + "views\\system\\" + s1 ;
            File file = new File(vuePackage);
            if (!file.exists()) {
                file.mkdir();
            }
            File vueFile = new File(vuePackage+"\\index.vue");


            // 将模板和数据模型合并生成HTML文件
            try (FileWriter fileWriter = new FileWriter(pojoFile)) {
                pojo.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(mapperFile)) {
                mapper.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(xmlFile)) {
                xml.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(serviceFile)) {
                service.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(implFile)) {
                impl.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(controllerFile)) {
                controller.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(apiFile)) {
                api.process(dataModel, fileWriter);
            }
            try (FileWriter fileWriter = new FileWriter(vueFile)) {
                pages.process(dataModel, fileWriter);
            }
            System.out.println("HTML file generated successfully.");
        } catch (IOException | TemplateException e) {
            e.printStackTrace();
        }
    }
}