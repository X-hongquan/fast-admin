package com.chq.app.common.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class R<T> {
    private Integer code;
    private String msg;
    private T data;


    public static <T> R<T> ok(T data) {
        return new R<>(200, null, data);
    }

    public static <T> R<T> ok() {
        return new R<>(200, null, null);
    }

    public static <T> R<T> fail() {
        return new R<>(500, "服务器异常", null);
    }

    public static <T> R<T> fail(String msg) {
        return new R<>(500, msg, null);
    }
    public static <T> R<T> fail(Integer code,String msg) {
        return new R<>(code, msg, null);
    }


}
