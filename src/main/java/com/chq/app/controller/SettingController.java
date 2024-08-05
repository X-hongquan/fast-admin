package com.chq.app.controller;


import com.chq.app.common.domain.R;
import com.chq.app.service.ISettingService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

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

    @PutMapping("/permissionMode")
    public R<Object> updatePermissionMode(Integer permissionMode) {
        int row=settingService.updatePermissionMode(permissionMode);
        return R.ok(row);
    }

}
