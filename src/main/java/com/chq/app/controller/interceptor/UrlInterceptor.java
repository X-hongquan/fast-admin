package com.chq.app.controller.interceptor;

public interface UrlInterceptor {

    String[] LOGIN_NO_INTERCEPT = {
            "/user/hello",
            "/user/text",
            "/user/login",
            "/swagger-ui/**",
            "/v3/**",
            "/test/**",
            "/captcha/**"
    };
}
