package com.chq.app.dto.enums;

import com.alibaba.fastjson2.JSON;
import com.fasterxml.jackson.annotation.JsonValue;

public enum MsgTypeEnum {

    /**
     * 统计在线人数
     */
    ONLINE(1),
    /**
     * 系统提示，需要调用通知
     */
    SYSTEM(2);

    @JsonValue
    private int type;
    MsgTypeEnum(int type) {
        this.type = type;
    }
}
