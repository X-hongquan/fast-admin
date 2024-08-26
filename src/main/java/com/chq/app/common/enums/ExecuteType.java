package com.chq.app.common.enums;

public enum ExecuteType {

    SYNC("sync"),

    ASYNC("async");

    private String value;

    ExecuteType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
