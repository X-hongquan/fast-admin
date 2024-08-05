package com.chq.app.common.domain;

import lombok.Data;

@Data
public class PageObject {

    private Integer pageNum = 1;
    private Integer pageSize = 10;
    private String column;
    private String condition = "asc";


    public String getOrderBy() {
        if (column == null) return null;
        if (condition == null) return column;
        return column + " " + condition;
    }
}
