package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.Permission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 权限表 服务类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface IPermissionService extends IService<Permission> {

    List<Permission> getList(Permission permission);

    Permission getPermissionById(Long id);


    int removePermissionByIds(Long[] ids);

    void add(Permission permission);
}
