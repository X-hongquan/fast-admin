package com.chq.app.websocket;


import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Resource
    private CustomWebSocketHandler customWebSocketHandler;

    @Resource
    private CustomHandshakeInterceptor customHandshakeInterceptor;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(customWebSocketHandler, "/ws")//添加自定义处理器
                .addInterceptors(customHandshakeInterceptor)//添加自定义WebSocket拦截器
                //设置跨域
             .setAllowedOrigins("*");
    }
}