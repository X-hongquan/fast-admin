package com.chq.app.controller;


import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.R;

import com.chq.app.service.IStatisticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.*;
import java.time.format.DateTimeFormatter;

@Slf4j
@RestController
@RequestMapping("/statistics")
public class StatisticsController {


    @Autowired
    private IStatisticsService statisticsService;


    /**
     * 获取今日登录次数
     *
     * @return
     */

    @GetMapping("/login/today")
    @PreAuth(value = "system:statistics:query",description = "查询统计权限")
    public R<Integer> getLoginCountByToday() {
        LocalDate now = LocalDate.now();
        LocalDateTime start = LocalDateTime.of(now, LocalTime.MIN);
        LocalDateTime end = LocalDateTime.of(now, LocalTime.MAX);
        int loginCount = statisticsService.getLoginCount(start, end);

        return R.ok(loginCount);
    }

    /**
     * 获取本月登录次数
     *
     * @return
     */
    @GetMapping("/login/month")
    @PreAuth(value = "system:statistics:query",description = "查询统计权限")
    public R<Integer> getLoginCountByMonth() {
        DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyy-MM");
        LocalDate currentDate = LocalDate.now();

        // 获取当前月份的 YearMonth 实例
        YearMonth yearMonth = YearMonth.from(currentDate);

        // 获取当前月份的第一天
        LocalDate firstDay = yearMonth.atDay(1);

        // 获取当前月份的最后一天
        LocalDate lastDay = yearMonth.atEndOfMonth();

        LocalDateTime start = LocalDateTime.of(firstDay, LocalTime.MIN);
        LocalDateTime end = LocalDateTime.of(lastDay, LocalTime.MAX);
        int loginCount = statisticsService.getLoginCount(start, end);
        return R.ok(loginCount);
    }

    /**
     * 获取今年最小值，和最大值
     *
     * @return
     */
    @GetMapping("/login/year")
    @PreAuth(value = "system:statistics:query",description = "查询统计权限")
    public R<Integer> getLoginCountByYear() {
        LocalDate currentDate = LocalDate.now();
        LocalDate firstDay = currentDate.withDayOfYear(1);
        LocalDate lastDay = currentDate.withDayOfYear(currentDate.lengthOfYear());
        LocalDateTime start = LocalDateTime.of(firstDay, LocalTime.MIN);
        LocalDateTime end = LocalDateTime.of(lastDay, LocalTime.MAX);
        int loginCount = statisticsService.getLoginCount(start, end);
        return R.ok(loginCount);
    }


}
