package com.chq.app.service;

import com.chq.app.dto.RoleMenuDto;
import com.chq.app.dto.RolePermissionDto;
import com.chq.app.pojo.Role;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chq.app.pojo.UserRole;

import java.util.List;

/**
 * <p>
 * 角色表 服务类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface IRoleService extends IService<Role> {

    List<Role> getList(Role role);

    Role getRoleById(Long id);

    int removeRoleByIds(Long[] ids);

    int updateRolePermission(RolePermissionDto dto);

    int updateRoleMenu(RoleMenuDto dto);
}
