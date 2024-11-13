package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.RolePermission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.Set;

/**
 * <p>
 * 角色权限表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface RolePermissionMapper extends BaseMapper<RolePermission> {

    Set<Long> getPermissionIdsByUserId(Long userId);
}
