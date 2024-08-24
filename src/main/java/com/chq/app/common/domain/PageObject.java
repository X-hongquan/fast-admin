package com.chq.app.common.domain;

import lombok.Data;

import java.util.Arrays;

@Data
public class PageObject {

    private Integer pageNum = 1;
    private Integer pageSize = 10;
    private String orderBy;
    private String[] columns;
    private String[] conditions;
    private String defaultSort = "asc";


    public String getOrderBy() {
        if (columns != null) {
            if (conditions == null) {
                conditions = new String[columns.length];
                Arrays.fill(conditions, defaultSort);
            } else if (conditions.length < columns.length) {
                conditions = Arrays.copyOf(conditions, columns.length);
                Arrays.fill(conditions, conditions.length, columns.length, defaultSort);
            }
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < columns.length; i++) {
                sb.append(columns[i]).append(" ").append(conditions[i]).append(",");
            }
            return sb.substring(0, sb.length() - 1);
        }
        return null;
    }
}
