package com.chq.app.controller;

import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.pojo.LoginLog;
import com.chq.app.service.ILoginLogService;
import com.chq.app.util.PageUtils;
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
    public TableInfo<List<LoginLog>> list(LoginLog loginLog) {
        PageUtils.startPage();
        List<LoginLog> list = loginLogService.getList(loginLog);
        return TableInfo.ok(list);
    }


    @DeleteMapping("/{ids}")
    public R delete(@PathVariable Long[] ids) {
        loginLogService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }
}
