package com.chq.app.service.impl;

import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.pojo.Permission;
import com.chq.app.mapper.PermissionMapper;
import com.chq.app.service.IPermissionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.util.SpringUtils;
import com.chq.app.util.UserHolder;
import org.springframework.stereotype.Service;

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
    public int deleteRoleByIds(Long[] ids) {
        LoginUser loginUser = UserHolder.getUser();
        for (Long id : ids) {
            Permission p = getPermissionById(id);
            loginUser.checkHasControl(p.getCreateBy());
        }
        return baseMapper.deleteBatchIds(Arrays.asList(ids));
    }
}
