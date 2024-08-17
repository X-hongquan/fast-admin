package com.chq.app.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.pojo.Permission;
import com.chq.app.service.IPermissionService;
import com.chq.app.service.IRoleService;
import com.chq.app.util.PageUtils;
import com.chq.app.util.UserHolder;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

import static com.chq.app.common.aspectj.DataScopeAspect.CONTROL;

/**
 * <p>
 * 权限表 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@RestController
@RequestMapping("/permission")
public class PermissionController {


    @Resource
    private IPermissionService permissionService;

    @Resource
    private IRoleService roleService;


    @GetMapping("/list")
    @PreAuth("system:permission:query")
    public TableInfo<List<Permission>> list(Permission permission) {
        PageUtils.startPage();
        List<Permission> list = permissionService.getList(permission);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth("system:permission:query")
    public Permission get(@PathVariable Long id) {
        return permissionService.getPermissionById(id);
    }

    @PostMapping
    @PreAuth("system:permission:add")
    public R add(@RequestBody Permission permission) {
        LambdaQueryWrapper<Permission> lqw = new LambdaQueryWrapper<Permission>().eq(Permission::getCode, permission.getCode());
        if (permissionService.getOne(lqw) != null) {
            return R.fail("权限码" + permission.getCode() + "已存在");
        }
        permissionService.save(permission);
        return R.ok();
    }

    @PutMapping
    @PreAuth("system:permission:edit")
    public R edit(@RequestBody Permission permission) {
        Permission p = permissionService.getPermissionById(permission.getId());
        UserHolder.getUser().checkHasControl(p.getCreateBy());
        LambdaQueryWrapper<Permission> lqw = new LambdaQueryWrapper<Permission>().eq(Permission::getCode, permission.getCode()).ne(Permission::getId, permission.getId());
        if (permissionService.getOne(lqw) != null) {
            return R.fail("权限码" + permission.getCode() + "已存在");
        }
        permissionService.updateById(permission);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth("system:permission:remove")
    public R<Integer> delete(@PathVariable Long[] ids) {
        int row = permissionService.removePermissionByIds(ids);
        return R.ok(row);
    }
}
