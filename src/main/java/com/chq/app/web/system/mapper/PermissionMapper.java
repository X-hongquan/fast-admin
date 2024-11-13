package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.Permission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * 权限表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface PermissionMapper extends BaseMapper<Permission> {

    List<Permission> getPermissionList(Permission permission);
}
