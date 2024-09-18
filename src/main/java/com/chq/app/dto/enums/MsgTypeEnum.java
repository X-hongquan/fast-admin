package com.chq.app.dto.enums;

import com.alibaba.fastjson2.JSON;
import com.fasterxml.jackson.annotation.JsonValue;

public enum MsgTypeEnum {

    ONLINE(1),
    SYSTEM(2);

    @JsonValue
    private int type;
    MsgTypeEnum(int type) {
        this.type = type;
    }
}
