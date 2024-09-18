package com.chq.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.pojo.LoginLog;
import com.chq.app.service.ILoginLogService;
import com.chq.app.service.IStatisticsService;
import com.chq.app.websocket.CustomWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class StatisticsServiceImpl implements IStatisticsService {

    @Autowired
    private ILoginLogService loginLogService;

    @Override
    public int getOnlineCount() {
        return CustomWebSocketHandler.getOnlineCount();
    }

    @Override
    public int getLoginCount(LocalDateTime start, LocalDateTime end) {
        long count = loginLogService.count(new LambdaQueryWrapper<LoginLog>().between(LoginLog::getLoginTime, start, end));
        return (int)count;
    }
}
