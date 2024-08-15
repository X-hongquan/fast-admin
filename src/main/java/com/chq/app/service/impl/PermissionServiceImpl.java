package com.chq.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.mapper.RolePermissionMapper;
import com.chq.app.pojo.Permission;
import com.chq.app.mapper.PermissionMapper;
import com.chq.app.pojo.RolePermission;
import com.chq.app.service.IPermissionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.util.SpringUtils;
import com.chq.app.util.UserHolder;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;

/**
 * <p>
 * 权限表 服务实现类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements IPermissionService {

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    @Override
    @DataScope(alias = "rp", mainAlias = "p")
    public List<Permission> getList(Permission permission) {
        List<Permission> list = baseMapper.getPermissionList(permission);
        return list;
    }

    @Override
    public Permission getPermissionById(Long id) {
        if (id == null)
            throw new ServiceException("id不能为空");
        List<Permission> list = SpringUtils.getAopProxy(this).getList(new Permission().setId(id));
        if (list.isEmpty())
            throw new ServiceException("权限不存在");
        return list.get(0);
    }

    @Override
    @Transactional
    public int removePermissionByIds(Long[] ids) {
        LoginUser loginUser = UserHolder.getUser();
        for (Long id : ids) {
            Permission p = getPermissionById(id);
            loginUser.checkHasControl(p.getCreateBy());
        }

        rolePermissionMapper.delete(new LambdaQueryWrapper<RolePermission>().in(RolePermission::getPermissionId, ids));
        return baseMapper.deleteBatchIds(Arrays.asList(ids));
    }
}
