package com.chq.app.builder;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class TableInfo {
    private String tableName;
    private String comment;
    private String dictLabel;
    private List<Column> columns=new ArrayList<>();
    private String pojoOutputPath;
    private String mapperOutputPath;
    private String serviceOutputPath;
    private String serviceImplOutputPath;
    private String controllerOutputPath;
    private String mapperXmlOutputPath;
    private String viewsOutputPath;
    private String apiOutputPath;
}
