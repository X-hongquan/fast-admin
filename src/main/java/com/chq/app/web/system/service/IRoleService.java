package com.chq.app.web.system.service;

import com.chq.app.dto.RoleMenuDto;
import com.chq.app.dto.RolePermissionDto;
import com.chq.app.web.system.pojo.Role;
import com.baomidou.mybatisplus.extension.service.IService;

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

    int insertRole(Role role);
}
