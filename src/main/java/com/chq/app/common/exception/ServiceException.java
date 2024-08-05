package com.chq.app.common.exception;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ServiceException extends RuntimeException {

    private Integer code;
    private String msg;

    public ServiceException(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public ServiceException(String msg) {
        this.code = 500;
        this.msg = msg;
    }


}
