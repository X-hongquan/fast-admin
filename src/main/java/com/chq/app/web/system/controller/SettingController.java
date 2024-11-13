package com.chq.app.web.system.controller;


import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.R;
import com.chq.app.web.system.pojo.Setting;
import com.chq.app.web.system.service.ISettingService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-08-05
 */
@RestController
@RequestMapping("/setting")
public class SettingController {

    @Resource
    private ISettingService settingService;

    @PutMapping
    @PreAuth(value = "system:setting:edit",description = "编辑用户模式")
    public R<Integer> updatePermissionMode(@RequestBody Setting setting) {
        int row = settingService.updatePermissionMode(setting);
        return R.ok(row);
    }


    @GetMapping
    @PreAuth(value = "system:setting:query",description = "查询设置权限")
    public R<Setting> get(Setting setting) {
        Setting byId = settingService.getById(setting.getId());
        return R.ok(byId);
    }

}
