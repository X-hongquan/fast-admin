package com.chq.app.common.enums;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ExecuteType {

    MAIl("mail", "邮件"),
    LOG("log", "日志");

    private String code;
    private String desc;
}
