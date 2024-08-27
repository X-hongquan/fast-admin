package com.chq.app.controller;

import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.pojo.Dept;
import com.chq.app.service.IDeptService;
import com.chq.app.util.PageUtils;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import java.util.List;



/**
 * <p>
 * 部门 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-08-27
 */
@RestController
@RequestMapping("/dept")
public class DeptController {

    @Resource
    private IDeptService deptService;


    @GetMapping("/list")
    @PreAuth("system:dept:query")
    public TableInfo<List<Dept>> list(Dept dept) {
        PageUtils.startPage();
        List<Dept> list =deptService.getList(dept);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth("system:dept:query")
    public R<Dept> get(@PathVariable Long id) {
        Dept dept = deptService.getDeptById(id);
        return R.ok(dept);
    }

    @PostMapping
    @PreAuth("system:dept:add")
    public R add(@RequestBody Dept dept) {
        deptService.addDept(dept);
        return R.ok();
    }

    @PutMapping
    @PreAuth("system:dept:edit")
    public R edit(@RequestBody Dept dept) {
        deptService.editDept(dept);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth("system:dept:remove")
    public R delete(@PathVariable Long[] ids) {
        deptService.deleteDeptByIds(ids);
        return R.ok();
    }
}
