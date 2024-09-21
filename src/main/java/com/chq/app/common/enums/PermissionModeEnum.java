package com.chq.app.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;
import lombok.Getter;


@AllArgsConstructor
public enum PermissionModeEnum {


    ALL(0, "公开"),

    SELF(1, "私有");

    @EnumValue
    @JsonValue
    private int value;

    public int value() {
        return value;
    }

    private String description;


}
