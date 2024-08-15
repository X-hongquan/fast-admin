package com.chq.app.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.dto.RoleMenuDto;
import com.chq.app.dto.RolePermissionDto;
import com.chq.app.pojo.Role;
import com.chq.app.pojo.UserRole;
import com.chq.app.service.IRoleService;
import com.chq.app.service.IUserRoleService;
import com.chq.app.util.PageUtils;
import com.chq.app.util.UserHolder;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

import static com.chq.app.common.aspectj.DataScopeAspect.NO_CONTROL;

/**
 * <p>
 * 角色表 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@RestController
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;



    @GetMapping("/list")
    @PreAuth("system:role:query")
    public TableInfo<List<Role>> list(Role role) {
        role.getParams().put(NO_CONTROL, null);
        PageUtils.startPage();
        List<Role> list = roleService.getList(role);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth("system:role:query")
    public R getById(@PathVariable Long id) {
        Role role = roleService.getRoleById(id);
        return R.ok(role);
    }

    @PostMapping
    @PreAuth("system:role:add")
    public R<Object> add(@RequestBody Role role) {
        LambdaQueryWrapper<Role> lqw = new LambdaQueryWrapper<Role>().eq(Role::getName, role.getName());
        if (roleService.getOne(lqw) != null) {
            return R.fail("角色名" + role.getName() + "已存在");
        }
        roleService.insertRole(role);
        return R.ok();
    }

    @PutMapping
    @PreAuth("system:role:edit")
    public R<Object> edit(@RequestBody Role role) {
        Role r = roleService.getRoleById(role.getId());
        UserHolder.getUser().checkHasControl(r.getCreateBy());
        LambdaQueryWrapper<Role> lqw = new LambdaQueryWrapper<Role>().eq(Role::getName, role.getName()).ne(Role::getId, role.getId());
        if (roleService.getOne(lqw) != null) {
            return R.fail("角色名" + role.getName() + "已存在");
        }
        roleService.updateById(role);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth("system:role:remove")
    public R<Object> delete(@PathVariable Long[] ids) {
        int row = roleService.removeRoleByIds(ids);
        return R.ok(row);
    }

    @PutMapping("/assign/permission")
    @PreAuth("system:role:edit")
    public R<Object> assignPermission(@RequestBody RolePermissionDto dto) {
        Role r = roleService.getRoleById(dto.getRoleId());
        UserHolder.getUser().checkHasControl(r.getCreateBy());
        int row = roleService.updateRolePermission(dto);
        return R.ok(row);
    }

    @PutMapping("/assign/menu")
    @PreAuth("system:role:edit")
    public R<Object> assignMenu(@RequestBody RoleMenuDto dto) {
        Role r = roleService.getRoleById(dto.getRoleId());
        UserHolder.getUser().checkHasControl(r.getCreateBy());
        int row = roleService.updateRoleMenu(dto);
        return R.ok(row);
    }

}
