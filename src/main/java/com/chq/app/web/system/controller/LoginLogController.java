package com.chq.app.web.system.controller;

import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.web.system.pojo.LoginLog;
import com.chq.app.web.system.service.ILoginLogService;
import com.chq.app.common.util.PageUtils;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/loginLog")
public class LoginLogController {

    @Resource
    private ILoginLogService loginLogService;

    @GetMapping("/list")
    @PreAuth(value = "system:loginLog:query",description = "查询登录日志权限")
    public TableInfo<List<LoginLog>> list(LoginLog loginLog) {
        PageUtils.startPage();
        List<LoginLog> list = loginLogService.getList(loginLog);
        return TableInfo.ok(list);
    }


    @DeleteMapping("/{ids}")
    @PreAuth(value = "system:loginLog:remove",description = "删除登录日志权限")
    public R delete(@PathVariable Long[] ids) {
        loginLogService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }
}
