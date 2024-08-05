package com.chq.app.controller.interceptor;


import com.chq.app.common.domain.LoginUser;

import com.chq.app.util.UserHolder;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.concurrent.TimeUnit;

import static com.chq.app.common.constant.RedisConstant.LOGIN_USER;
import static com.chq.app.common.constant.RedisConstant.ONLINE_TIME;

public class RefreshInterceptor implements HandlerInterceptor {


    private StringRedisTemplate stringRedisTemplate;

    public RefreshInterceptor(StringRedisTemplate stringRedisTemplate) {
        this.stringRedisTemplate = stringRedisTemplate;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        LoginUser u = UserHolder.getUser();
        if (u == null) {
            response.setStatus(401);
            return false;
        }
        stringRedisTemplate.expire(LOGIN_USER + u.getToken(), ONLINE_TIME, TimeUnit.SECONDS);
        return true;
    }


}
