package com.chq.app.websocket;


import com.alibaba.fastjson2.JSON;

import com.chq.app.common.domain.LoginUser;
import com.chq.app.util.JwtUtil;
import com.chq.app.util.UserHolder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import java.net.URI;
import java.util.Map;

import static com.chq.app.common.constant.RedisConstant.LOGIN_USER;


@Component
public class CustomHandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;


    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        String token = UserHolder.getUser().getToken();
        String s = stringRedisTemplate.opsForValue().get(LOGIN_USER + token);
        attributes.put("token", token);
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
}