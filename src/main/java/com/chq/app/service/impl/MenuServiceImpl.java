package com.chq.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.mapper.RoleMenuMapper;
import com.chq.app.pojo.Menu;
import com.chq.app.mapper.MenuMapper;
import com.chq.app.pojo.Role;
import com.chq.app.pojo.RoleMenu;
import com.chq.app.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.service.IRoleService;
import com.chq.app.util.SpringUtils;
import com.chq.app.util.UserHolder;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

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
        if (old.getSort().equals(fresh.getSort()) && old.getParentId().equals(fresh.getParentId())) {
            updateById(fresh);
        }
        baseMapper.updateMenuAdaptSort(fresh);
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
        return baseMapper.insert(menu);
    }


}
