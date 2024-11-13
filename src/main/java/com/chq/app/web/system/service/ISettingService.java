package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.Setting;
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

    int updatePermissionMode(Setting setting);
}
