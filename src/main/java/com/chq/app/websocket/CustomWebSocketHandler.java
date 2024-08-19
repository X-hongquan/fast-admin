package com.chq.app.websocket;


import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
@Slf4j
public class CustomWebSocketHandler extends TextWebSocketHandler {


    private static final Map<String, WebSocketSession> sessionMap = new ConcurrentHashMap<>();


    /**
     * socket 建立成功事件
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        String token = (String) session.getAttributes().get("token");
        sessionMap.put(token, session);
    }

    /**
     * 接收消息事件
     */
    @SneakyThrows
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) {
        // 获得客户端传来的消息
        String payload = message.getPayload();
        System.out.println("收到消息 = " + payload);

    }

    /**
     * socket 断开连接时
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        System.out.println("IMWebSocketHandler.afterConnectionClosed");
    }

    /**
     * socket 异常连接时
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) {
        System.out.println("IMWebSocketHandler.handleTransportError");
    }

    public static void sendMsg(Long toId, String msg) throws IOException {
        String userId = String.valueOf(toId);

        if (sessionMap.containsKey(userId) && sessionMap.get(userId).isOpen()) {

            sessionMap.get(userId).sendMessage(new TextMessage(msg));
        }
    }


}
