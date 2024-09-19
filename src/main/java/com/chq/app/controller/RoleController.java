package com.chq.app.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.annoation.Log;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.enums.BusinessType;
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
    @PreAuth(value = "system:role:query", description = "查询角色权限")
    public TableInfo<List<Role>> list(Role role) {
        PageUtils.startPage();
        List<Role> list = roleService.getList(role);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth(value = "system:role:query", description = "查询角色权限")
    public R get(@PathVariable Long id) {
        Role role = roleService.getRoleById(id);
        return R.ok(role);
    }

    @PostMapping
    @PreAuth(value = "system:role:add", description = "新增角色权限")
    public R add(@RequestBody Role role) {
        LambdaQueryWrapper<Role> lqw = new LambdaQueryWrapper<Role>().eq(Role::getName, role.getName());
        if (roleService.getOne(lqw) != null) {
            return R.fail("角色名" + role.getName() + "已存在");
        }
        roleService.insertRole(role);
        return R.ok();
    }

    @PutMapping
    @PreAuth(value = "system:role:edit", description = "编辑角色权限")
    public R edit(@RequestBody Role role) {
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
    @PreAuth(value = "system:role:remove", description = "删除角色权限")
    public R<Integer> delete(@PathVariable Long[] ids) {
        int row = roleService.removeRoleByIds(ids);
        return R.ok(row);
    }

    @PutMapping("/assign/permission")
    @PreAuth(value = "system:role:assign", description = "分配角色权限")
    @Log(title = "分配角色菜单操作", businessType = BusinessType.GRANT)
    public R<Integer> assignPermission(@RequestBody RolePermissionDto dto) {
        Role r = roleService.getRoleById(dto.getRoleId());
        UserHolder.getUser().checkHasControl(r.getCreateBy());
        int row = roleService.updateRolePermission(dto);
        return R.ok(row);
    }

    @PutMapping("/assign/menu")
    @PreAuth(value = "system:role:assign", description = "分配角色权限")
    @Log(title = "分配角色菜单操作", businessType = BusinessType.GRANT)
    public R<Integer> assignMenu(@RequestBody RoleMenuDto dto) {
        Role r = roleService.getRoleById(dto.getRoleId());
        UserHolder.getUser().checkHasControl(r.getCreateBy());
        int row = roleService.updateRoleMenu(dto);
        return R.ok(row);
    }

}
