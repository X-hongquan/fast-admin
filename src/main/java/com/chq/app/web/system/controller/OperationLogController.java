package com.chq.app.web.system.controller;

import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.web.system.pojo.OperationLog;
import com.chq.app.web.system.service.IOperationLogService;
import com.chq.app.common.util.PageUtils;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import java.util.List;



/**
 * <p>
 * 操作日志记录 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-09-19
 */
@RestController
@RequestMapping("/operationLog")
public class OperationLogController {

    @Resource
    private IOperationLogService operationLogService;


    @GetMapping("/list")
    @PreAuth(value = "system:operationLog:query", description = "查询操作日志权限")
    public TableInfo<List<OperationLog>> list(OperationLog operationLog) {
        PageUtils.startPage();
        List<OperationLog> list =operationLogService.getList(operationLog);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth(value = "system:operationLog:query", description = "查询操作日志权限")
    public R<OperationLog> get(@PathVariable Long id) {
        OperationLog operationLog = operationLogService.getOperationLogById(id);
        return R.ok(operationLog);
    }

    @PostMapping
    @PreAuth(value="system:operationLog:add",description = "新增操作日志权限")
    public R add(@RequestBody OperationLog operationLog) {
        operationLogService.addOperationLog(operationLog);
        return R.ok();
    }

    @PutMapping
    @PreAuth(value = "system:operationLog:edit", description = "编辑操作日志权限")
    public R edit(@RequestBody OperationLog operationLog) {
        operationLogService.editOperationLog(operationLog);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth(value = "system:operationLog:remove", description = "删除操作日志权限")
    public R delete(@PathVariable Long[] ids) {
        operationLogService.deleteOperationLogByIds(ids);
        return R.ok();
    }
}
