package com.chq.app.controller;


import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.pojo.Menu;
import com.chq.app.service.IMenuService;
import com.chq.app.service.IRoleService;
import com.chq.app.util.UserHolder;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import static com.chq.app.common.aspectj.DataScopeAspect.CONTROL;

/**
 * <p>
 * 菜单表 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@RestController
@RequestMapping("/menu")
public class MenuController {


    @Resource
    private IMenuService menuService;


    @Resource
    private IRoleService roleService;

    @GetMapping("/init")
    public R<List<Menu>> init(Menu menu) {
        menu.setRoleId(null);
        List<Menu> list = menuService.initMenu(menu);
        return R.ok(list);
    }

    @GetMapping("/list")
    public R<List<Menu>> list(Menu menu) {
        List<Menu> list = menuService.getList(menu);
        return R.ok(list);
    }


    @GetMapping("/{id}")
    @PreAuth("system:menu:query")
    public R<Menu> get(@PathVariable Long id) {
        Menu menu = menuService.getMenuById(id);
        return R.ok(menu);
    }

    @PostMapping
    @PreAuth("system:menu:add")
    public R add(@RequestBody Menu menu) {
        int row = menuService.add(menu);
        return R.ok(row);
    }

    @PutMapping
    @PreAuth("system:menu:edit")
    public R edit(@RequestBody Menu menu) {
        Menu m = menuService.getMenuById(menu.getId());
        UserHolder.getUser().checkHasControl(m.getCreateBy());
        menuService.updateById(menu);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth("system:menu:remove")
    public R<Integer> delete(@PathVariable Long[] ids) {
        int row = menuService.removeMenuByIds(ids);
        return R.ok(row);
    }
}
