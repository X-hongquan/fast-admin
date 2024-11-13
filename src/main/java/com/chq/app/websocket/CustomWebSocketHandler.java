package com.chq.app.websocket;


import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.chq.app.common.util.SpringUtils;
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
import java.util.List;
import java.util.Map;
import java.util.Set;
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
                sendMsg(map.getKey(), s);
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
        String token = (String) session.getAttributes().get("token");
        sessionMap.remove(token);
        try {
            for (Map.Entry<String, WebSocketSession> map : sessionMap.entrySet()) {
                MsgDto msgDto = new MsgDto();
                msgDto.setId(IdWorker.getId()).setType(MsgTypeEnum.ONLINE).setData(sessionMap.size());
                String s = objectMapper.writeValueAsString(msgDto);
                sendMsg(map.getKey(), s);
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

    public static void sendMsg(String token, String msg)  {
        if (sessionMap.containsKey(token) && sessionMap.get(token).isOpen()) {
            try {
                sessionMap.get(token).sendMessage(new TextMessage(msg));
            } catch (IOException e) {
                log.error("发送消息失败", e);
            }
        }
    }

    /**
     * 删除连接
     */
    public static void remove(String token) {
        if (sessionMap.containsKey(token)) {
            WebSocketSession socket = sessionMap.get(token);
            try {
                MsgDto msgDto = new MsgDto();
                msgDto.setId(IdWorker.getId()).setType(MsgTypeEnum.SYSTEM).setData("你被强行下线,请联系管理员");
                ObjectMapper objectMapper = SpringUtils.getBean(ObjectMapper.class);
                String jsonString = objectMapper.writeValueAsString(msgDto);
                socket.sendMessage(new TextMessage(jsonString));
                socket.close();
                sessionMap.remove(token);
            } catch (IOException e) {
                log.error("关闭连接失败", e);
            }
        }
    }

    /**
     * @return List<String> 登录用户token集合
     */
    public static Set<String> getSessionTokenList() {
        Set<String> keys= sessionMap.keySet();
        return keys;
    }

    public static void sendOnlineCount() {
        for (Map.Entry<String, WebSocketSession> map : sessionMap.entrySet()) {
            MsgDto msgDto = new MsgDto();
            msgDto.setId(IdWorker.getId()).setType(MsgTypeEnum.ONLINE).setData(sessionMap.size());
            String s = JSON.toJSONString(msgDto);
            sendMsg(map.getKey(), s);
        }
    }


}
