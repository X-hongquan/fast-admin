package com.chq.app.common.enums;

import lombok.AllArgsConstructor;

/**
 * 操作人类别
 */
@AllArgsConstructor
public enum OperatorType {

    /**
     * 后台用户
     */
    MANAGE(1),
    /**
     * 其它
     */
    OTHER(2),

    /**
     * 手机端用户
     */
    MOBILE(3);

    int value;

    public int value() {
        return value;
    }
}
