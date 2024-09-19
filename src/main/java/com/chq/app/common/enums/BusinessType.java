package com.chq.app.common.enums;

import lombok.AllArgsConstructor;

/**
 * 业务操作类型
 */
@AllArgsConstructor
public enum BusinessType {
    /**
     * 其它
     */
    OTHER(1),

    /**
     * 新增
     */
    INSERT(2),

    /**
     * 修改
     */
    UPDATE(3),

    /**
     * 删除
     */
    DELETE(4),

    /**
     * 授权
     */
    GRANT(5),

    /**
     * 导出
     */
    EXPORT(6),

    /**
     * 导入
     */
    IMPORT(7),

    /**
     * 强退
     */
    FORCE(8);

    int value;

    public int value() {
        return value;
    }


}
