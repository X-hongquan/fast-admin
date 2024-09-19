package com.chq.app.common.enums;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum ExecuteType {

    SYNC("sync"),

    ASYNC("async");

    private String value;

    public String getValue() {
        return value;
    }
}
