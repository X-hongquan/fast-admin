package com.chq.app.service;

import com.chq.app.pojo.Setting;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chq
 * @since 2024-08-05
 */
public interface ISettingService extends IService<Setting> {

    int updatePermissionMode(Integer permissionMode);
}
