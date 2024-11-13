package com.chq.app.web.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.web.system.pojo.LoginLog;
import com.chq.app.web.system.service.ILoginLogService;
import com.chq.app.web.system.service.IStatisticsService;
import com.chq.app.websocket.CustomWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

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
