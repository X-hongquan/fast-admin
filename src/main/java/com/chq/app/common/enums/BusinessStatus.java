package com.chq.app.common.enums;

/**
 * 操作状态
 *
 * @author ruoyi
 */
public enum BusinessStatus {
    /**
     * 成功
     */
    SUCCESS(1),

    /**
     * 失败
     */
    FAIL(0);


    int value;

    public int value() {
        return value;
    }

    BusinessStatus(int value) {
        this.value = value;
    }
}
