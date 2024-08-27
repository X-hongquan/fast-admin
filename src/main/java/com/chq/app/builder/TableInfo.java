package com.chq.app.builder;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class TableInfo {
    private String tableName;
    private String comment;
    private List<Column> columns=new ArrayList<>();
}
