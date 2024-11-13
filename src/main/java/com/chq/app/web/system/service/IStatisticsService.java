package com.chq.app.web.system.service;


import java.time.LocalDateTime;

public interface IStatisticsService {


    /**
     * 查询在线人数
     *
     * @return 在线人数数量
     */
    int getOnlineCount();


    /**
     * 查询登录次数
     *
     * @return 查询登录次数
     */
    int getLoginCount(LocalDateTime start, LocalDateTime end);




}
