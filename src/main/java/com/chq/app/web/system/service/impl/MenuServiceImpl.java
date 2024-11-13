package com.chq.app.web.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.mapper.RoleMenuMapper;
import com.chq.app.web.system.mapper.UserRoleMapper;
import com.chq.app.web.system.pojo.Menu;
import com.chq.app.web.system.mapper.MenuMapper;
import com.chq.app.web.system.pojo.Role;
import com.chq.app.web.system.pojo.RoleMenu;
import com.chq.app.web.system.pojo.User;
import com.chq.app.web.system.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.common.util.SpringUtils;
import com.chq.app.common.util.UserHolder;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * <p>
 * 菜单表 服务实现类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {


    @Resource
    private RoleMenuMapper roleMenuMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;


    @Override
    @DataScope(alias = "rm")
    public List<Menu> getList(Menu menu) {
        List<Menu> list = baseMapper.getMenuList(menu);
        return list;
    }

    @Override
    public Menu getMenuById(Long id) {
        if (id == null)
            throw new ServiceException("id不能为空");
        List<Menu> list = SpringUtils.getAopProxy(this).getList(new Menu().setId(id));
        if (list.isEmpty())
            throw new ServiceException("菜单不存在");
        return list.get(0);
    }

    @Override
    public int removeMenuByIds(Long[] ids) {
        LoginUser loginUser = UserHolder.getUser();
        for (Long id : ids) {
            Menu m = getMenuById(id);
            loginUser.checkHasControl(m.getCreateBy());
        }
        roleMenuMapper.delete(new LambdaQueryWrapper<RoleMenu>().in(RoleMenu::getMenuId, ids));
        return baseMapper.deleteBatchIds(Arrays.asList(ids));
    }

    @Override
    public void updateMenu(Menu old, Menu fresh) {

        if (!old.getParentId().equals(fresh.getParentId())) {
            fresh.setLevel(getMenuById(fresh.getParentId()).getLevel() + 1);
            baseMapper.updateMenuAdaptSort(fresh);
        } else {
            if (!old.getSort().equals(fresh.getSort())) {
                baseMapper.updateMenuAdaptSort(fresh);
            }
        }
        updateById(fresh);
    }


    @Override
    @DataScope(alias = "rm")
    public List<Menu> initMenu(Menu menu) {
        return baseMapper.getInitMenu(menu);
    }

    @Override
    public int add(Menu menu) {
        int max = baseMapper.selectMaxSortBySameParentId(menu);
        int sort = max + 1;
        menu.setSort(sort);
        Menu m = getById(menu.getParentId());
        menu.setLevel(m.getLevel() + 1);
        int row = baseMapper.insert(menu);
        LoginUser loginUser = UserHolder.getUser();
        //非管理员用户操作
        if (!loginUser.isAdmin()) {
            User user = loginUser.getUser();
            Long roleId = userRoleMapper.getMaxRoleByUserId(user.getId());
            if (roleId != null) {
                roleMenuMapper.insert(new RoleMenu().setRoleId(roleId).setMenuId(menu.getId()));
            }
        }
        return row;
    }


}
