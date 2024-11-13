package com.chq.app.web.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.dto.RoleMenuDto;
import com.chq.app.dto.RolePermissionDto;
import com.chq.app.web.system.controller.UserController;
import com.chq.app.web.system.mapper.RoleMapper;
import com.chq.app.web.system.mapper.RoleMenuMapper;
import com.chq.app.web.system.mapper.RolePermissionMapper;
import com.chq.app.web.system.mapper.UserRoleMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.common.util.SpringUtils;
import com.chq.app.common.util.UserHolder;
import com.chq.app.web.system.pojo.*;
import com.chq.app.web.system.service.*;
import jakarta.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
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
    private IRolePermissionService rolePermissionService;

    @Resource
    private IMenuService menuService;

    @Resource
    private IRoleMenuService roleMenuService;

    @Resource
    private UserRoleMapper userRoleMapper;

    @Autowired
    private RolePermissionMapper rolePermissionMapper;
    @Autowired
    private RoleMenuMapper roleMenuMapper;


    @Override
    @DataScope(alias = "r", value = "id")
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
        LoginUser loginUser = UserHolder.getUser();
        User user = loginUser.getUser();
        //查询自己已有权限
        Set<Long> permissionIds = rolePermissionMapper.getPermissionIdsByUserId(user.getId());
        Long[] ids = dto.getPermissionIds();
        List<RolePermission> rps = new ArrayList<>();
        if (ids != null) {
            for (Long id : ids) {
                if (!permissionIds.contains(id) && !loginUser.isAdmin()) {
                    throw new ServiceException("权限超出范围");
                }
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
        //查询用户所拥有的菜单
        LoginUser loginUser = UserHolder.getUser();
        User user = loginUser.getUser();
        Set<Long> menuIds = roleMenuMapper.getMenuIdsByUserId(user.getId());

        Long[] ids = dto.getMenuIds();
        List<RoleMenu> rms = new ArrayList<>();
        if (ids != null) {
            for (Long id : ids) {
                if (!menuIds.contains(id) && !loginUser.isAdmin()) {
                    throw new ServiceException();
                }
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
        int row = baseMapper.insert(role);
        LoginUser loginUser = UserHolder.getUser();
        if (!loginUser.isAdmin())
            userRoleMapper.insert(new UserRole().setUserId(loginUser.getUser().getId()).setRoleId(role.getId()));
        return row;
    }
}
