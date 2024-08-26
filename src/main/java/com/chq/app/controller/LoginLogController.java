package com.chq.app.controller;

import com.chq.app.common.domain.TableInfo;
import com.chq.app.pojo.LoginLog;
import com.chq.app.service.ILoginLogService;
import com.chq.app.util.PageUtils;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/loginLog")
public class LoginLogController {

    @Resource
    private ILoginLogService loginLogService;
    @GetMapping("/list")
    public TableInfo<List<LoginLog>> list() {
        PageUtils.startPage();
        List<LoginLog> list = loginLogService.list();
        return TableInfo.ok(list);

    }
}
