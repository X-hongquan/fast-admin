package com.chq.app.service.impl;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.chq.app.common.aspectj.DataScopeAspect;
import com.chq.app.common.enums.PermissionModeEnum;
import com.chq.app.common.exception.AuthException;
import com.chq.app.pojo.Setting;
import com.chq.app.mapper.SettingMapper;
import com.chq.app.service.ISettingService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author chq
 * @since 2024-08-05
 */
@Service
public class SettingServiceImpl extends ServiceImpl<SettingMapper, Setting> implements ISettingService {

    @Resource
    private DataScopeAspect dataScopeAspect;


    @PostConstruct
    public void initSetting() {
        Setting setting = baseMapper.selectById(1);
        dataScopeAspect.setPermissionModeEnum(setting.getPermissionMode());
    }

    @Override
    public int updatePermissionMode(Setting setting) {
        if (setting.getPermissionMode() == null) throw new AuthException();
        if (setting.getPermissionMode() == PermissionModeEnum.SELF) {
            updateById(setting);
            dataScopeAspect.setPermissionModeEnum(setting.getPermissionMode());
        } else if (setting.getPermissionMode() == PermissionModeEnum.ALL) {
            updateById(setting);
            dataScopeAspect.setPermissionModeEnum(setting.getPermissionMode());
        }
        return 1;
    }
}
