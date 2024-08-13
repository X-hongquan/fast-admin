package com.chq.app.controller;


import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.R;
import com.chq.app.pojo.Setting;
import com.chq.app.service.ISettingService;
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
    @PreAuth("system:admin:edit")
    public R<Object> updatePermissionMode(@RequestBody Setting setting) {
        int row = settingService.updatePermissionMode(setting);
        return R.ok(row);
    }


    @GetMapping
    @PreAuth("system:admin:query")
    public R<Setting> getSetting(Setting setting) {
        Setting byId = settingService.getById(setting.getId());
        return R.ok(byId);
    }

}
