package com.chq.app.common.exception;

public class AuthException extends RuntimeException {
    private Integer code;
    private String msg;


    public AuthException(Integer code, String msg) {

        this.code = code;
        this.msg = msg;
    }

    public AuthException(String msg) {
        this.code = 403;
        this.msg = msg;
    }


    public AuthException() {
        this.code = 403;
        this.msg = "权限不足";
    }


}
