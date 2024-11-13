package com.chq.app.web.system.controller;

import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.util.PageUtils;
import com.chq.app.web.system.pojo.Dept;
import com.chq.app.web.system.service.IDeptService;

import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;



/**
 * <p>
 * 部门 前端控制器
 * </p>
 *
 * @author 神
 * @since 2024-09-29
 */
@RestController
@RequestMapping("/dept")
public class DeptController {

    @Resource
    private IDeptService deptService;


    @GetMapping("/list")
    @PreAuth(value="system:dept:query", description = "查询部门权限")
    public TableInfo<List<Dept>> list(Dept dept) {
        PageUtils.startPage();
        List<Dept> list =deptService.getList(dept);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth(value="system:dept:query", description = "查询部门权限")
    public R<Dept> get(@PathVariable Long id) {
        Dept dept = deptService.getDeptById(id);
        return R.ok(dept);
    }

    @PostMapping
    @PreAuth(value="system:dept:add", description = "新增部门权限")
    public R add(@RequestBody Dept dept) {
        deptService.addDept(dept);
        return R.ok();
    }

    @PutMapping
    @PreAuth(value="system:dept:edit", description = "编辑部门权限")
    public R edit(@RequestBody Dept dept) {
        deptService.editDept(dept);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth(value="system:dept:remove", description = "删除部门权限")
    public R delete(@PathVariable Long[] ids) {
        deptService.deleteDeptByIds(ids);
        return R.ok();
    }


    /**
     * 上传接口
     */
    @PostMapping("/upload")
    @PreAuth(value="system:dept:add", description = "删除部门权限")
    public R upload(@RequestParam("file") MultipartFile file) {
        String url=deptService.upload(file);
        return R.ok(url);
    }
}
