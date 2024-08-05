package com.chq.app.controller.interceptor;

import com.alibaba.fastjson2.JSON;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.util.JwtUtil;
import com.chq.app.util.UserHolder;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;

import static com.chq.app.common.constant.RedisConstant.LOGIN_USER;

@Slf4j
public class LoginInterceptor implements HandlerInterceptor {


    private StringRedisTemplate stringRedisTemplate;

    public LoginInterceptor(StringRedisTemplate stringRedisTemplate) {
        this.stringRedisTemplate = stringRedisTemplate;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String header = request.getHeader("Authorization");
        if (header == null || header.isBlank()) {
            return true;
        }
        String token = null;
        try {
            token = JwtUtil.parser(header);
        } catch (Exception e) {
            return true;
        }
        String s = stringRedisTemplate.opsForValue().get(LOGIN_USER + token);
        if (s == null || s.isBlank()) {
            return true;
        }
        LoginUser loginUser = JSON.parseObject(s, LoginUser.class);
        loginUser.setToken(token);
        UserHolder.saveUser(loginUser);
        return true;
    }


    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        UserHolder.removeUser();
    }
}
