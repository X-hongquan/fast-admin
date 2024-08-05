package com.chq.app.service;

import com.chq.app.pojo.Permission;
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

    int deleteRoleByIds(Long[] ids);
}
