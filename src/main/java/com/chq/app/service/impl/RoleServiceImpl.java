package com.chq.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.dto.RoleMenuDto;
import com.chq.app.dto.RolePermissionDto;
import com.chq.app.mapper.RoleMapper;
import com.chq.app.mapper.UserRoleMapper;
import com.chq.app.pojo.*;
import com.chq.app.service.*;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.util.SpringUtils;
import com.chq.app.util.UserHolder;
import jakarta.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.*;


/**
 * <p>
 * 角色表 服务实现类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Resource
    private IPermissionService permissionService;

    @Resource
    private IRolePermissionService rolePermissionService;

    @Resource
    private IMenuService menuService;

    @Resource
    private IRoleMenuService roleMenuService;

    @Resource
    private UserRoleMapper userRoleMapper;


    @Override
    @DataScope(alias = "r", value = "id", mainAlias = "r")
    public List<Role> getList(Role role) {
        return baseMapper.getList(role);
    }

    @Override
    public Role getRoleById(Long id) {
        if (id == null)
            throw new ServiceException("id不能为空");
        List<Role> list = SpringUtils.getAopProxy(this).getList(new Role().setId(id));
        if (list.isEmpty())
            throw new ServiceException("角色不存在");
        return list.get(0);
    }

    @Override
    public int removeRoleByIds(Long[] ids) {
        LoginUser loginUser = UserHolder.getUser();
        for (Long id : ids) {
            Role r = getRoleById(id);
            loginUser.checkHasControl(r.getCreateBy());
        }
        userRoleMapper.delete(new LambdaQueryWrapper<UserRole>().in(UserRole::getRoleId, ids));
        roleMenuService.remove(new LambdaQueryWrapper<RoleMenu>().in(RoleMenu::getRoleId, ids));
        rolePermissionService.remove(new LambdaQueryWrapper<RolePermission>().in(RolePermission::getRoleId, ids));
        return baseMapper.deleteBatchIds(Arrays.asList(ids));
    }

    @Override
    @Transactional
    public int updateRolePermission(RolePermissionDto dto) {
        List<Permission> list = permissionService.getList(new Permission());
        Map<Long, Permission> permissionIds = new HashMap<>();
        for (Permission permission : list) {
            permissionIds.put(permission.getId(), permission);
        }
        Long[] ids = dto.getPermissionIds();
        List<RolePermission> rps = new ArrayList<>();
        if (ids != null) {
            for (Long id : ids) {
                if (!permissionIds.containsKey(id)) throw new ServiceException();
                rps.add(new RolePermission().setRoleId(dto.getRoleId()).setPermissionId(id));
            }
            LambdaQueryWrapper<RolePermission> lqw = new LambdaQueryWrapper<RolePermission>().eq(RolePermission::getRoleId, dto.getRoleId());
            rolePermissionService.remove(lqw);
            rolePermissionService.saveBatch(rps);
        }

        return rps.size();
    }

    @Override
    @Transactional
    public int updateRoleMenu(RoleMenuDto dto) {
        LoginUser loginUser = UserHolder.getUser();
        List<Menu> list = menuService.getList(new Menu());
        Map<Long, Menu> menuIds = new HashMap<>();
        for (Menu menu : list) {
            menuIds.put(menu.getId(), menu);
        }
        Long[] ids = dto.getMenuIds();
        List<RoleMenu> rms = new ArrayList<>();
        if (ids != null) {
            for (Long id : ids) {
                if (!menuIds.containsKey(id)) throw new ServiceException();
                rms.add(new RoleMenu().setRoleId(dto.getRoleId()).setMenuId(id));
            }
            LambdaQueryWrapper<RoleMenu> lqw = new LambdaQueryWrapper<RoleMenu>().eq(RoleMenu::getRoleId, dto.getRoleId());
            roleMenuService.remove(lqw);
            roleMenuService.saveBatch(rms);
        }
        return rms.size();
    }

    @Override
    @Transactional
    public int insertRole(Role role) {
        save(role);
        return userRoleMapper.insert(new UserRole().setUserId(UserHolder.getUser().getUser().getId()).setRoleId(role.getId()));

    }
}
