package com.chq.app.websocket;


import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.chq.app.dto.MsgDto;
import com.chq.app.dto.enums.MsgTypeEnum;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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


    @Autowired
    private ObjectMapper objectMapper;

    public static int getOnlineCount() {
        return sessionMap.size();
    }


    /**
     * socket 建立成功事件
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        String token = (String) session.getAttributes().get("token");
        log.info("连接成功", token);
        sessionMap.put(token, session);
        try {
            for (Map.Entry<String, WebSocketSession> map : sessionMap.entrySet()) {
                MsgDto msgDto = new MsgDto();
                msgDto.setId(IdWorker.getId()).setType(MsgTypeEnum.ONLINE).setData(sessionMap.size());
                String s = objectMapper.writeValueAsString(msgDto);
                sendMsg(map.getKey(),s);
            }
        } catch (IOException e) {
            log.error("发送消息失败", e);
        }
    }

    /**
     * 接收消息事件
     */
    @SneakyThrows
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) {
        // 获得客户端传来的消息
        String payload = message.getPayload();

    }

    /**
     * socket 断开连接时
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        //todo
        String token =(String) session.getAttributes().get("token");
        sessionMap.remove(token);
        try {
            for (Map.Entry<String, WebSocketSession> map : sessionMap.entrySet()) {
                MsgDto msgDto = new MsgDto();
                msgDto.setId(IdWorker.getId()).setType(MsgTypeEnum.ONLINE).setData(sessionMap.size());
                String s = objectMapper.writeValueAsString(msgDto);
                sendMsg(map.getKey(),s);
            }
        } catch (IOException e) {
            log.error("发送消息失败", e);
        }
    }

    /**
     * socket 异常连接时
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) {
         //todo
    }

    public static void sendMsg(String token, String msg) throws IOException {
        if (sessionMap.containsKey(token) && sessionMap.get(token).isOpen()) {
            sessionMap.get(token).sendMessage(new TextMessage(msg));
        }
    }


}
