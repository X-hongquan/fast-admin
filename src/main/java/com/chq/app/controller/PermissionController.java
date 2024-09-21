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
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.*;



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



    @GetMapping("/list")
    @PreAuth(value = "system:permission:query", description = "查询权限权限")
    public TableInfo<List<Permission>> list(Permission permission) {
        PageUtils.startPage();
        List<Permission> list = permissionService.getList(permission);
        return TableInfo.ok(list);
    }

    /**
     * 根据角色id查询权限
     * 并进行分组
     * @param permission
     * @return
     */
    @GetMapping("/groupByRoleId")
    @PreAuth(value = "system:permission:query", description = "查询权限权限")
    public R<Map<String, List<Permission>>> listGroup(Permission permission) {
        List<Permission> list = permissionService.getList(permission);
        Map<String, List<Permission>> map = new HashMap();
        for (Permission p : list) {
            String code = p.getCode();
            String key = StringUtils.substringBeforeLast(code, ":");
            List<Permission> arr = map.getOrDefault(key, new ArrayList<Permission>());
            arr.add(p);
            map.put(key, arr);
        }
        return R.ok(map);
    }


    @GetMapping("/{id}")
    @PreAuth(value = "system:permission:query", description = "查询权限权限")
    public Permission get(@PathVariable Long id) {
        return permissionService.getPermissionById(id);
    }

    @PostMapping
    @PreAuth(value = "system:permission:add", description = "新增权限权限")
    public R add(@RequestBody Permission permission) {
        LambdaQueryWrapper<Permission> lqw = new LambdaQueryWrapper<Permission>().eq(Permission::getCode, permission.getCode());
        if (permissionService.getOne(lqw) != null) {
            return R.fail("权限码" + permission.getCode() + "已存在");
        }
        permissionService.save(permission);
        return R.ok();
    }

    @PutMapping
    @PreAuth(value = "system:permission:edit", description = "编辑权限权限")
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
    @PreAuth(value = "system:permission:remove", description = "删除权限权限")
    public R<Integer> delete(@PathVariable Long[] ids) {
        int row = permissionService.removePermissionByIds(ids);
        return R.ok(row);
    }
}
