package com.chq.app.controller.handler;


import com.chq.app.common.domain.R;
import com.chq.app.common.exception.AuthException;
import com.chq.app.common.exception.ServiceException;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ServiceException.class)
    public R<String> exceptionHandler(ServiceException e) {
        return R.fail(e.getCode(), e.getMsg());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public R handleArgumentNotValid(MethodArgumentNotValidException e) {
        return R.fail(e.getBindingResult().getFieldError().getDefaultMessage());
    }

    @ExceptionHandler(RuntimeException.class)
    public R exceptionHandler(RuntimeException e, HttpServletResponse response) {
        return R.fail(e.getMessage());
    }

    @ExceptionHandler(AuthException.class)
    public void exceptionHandler(AuthException e, HttpServletResponse response) {
        e.printStackTrace();
        response.setStatus(403);
    }
}
