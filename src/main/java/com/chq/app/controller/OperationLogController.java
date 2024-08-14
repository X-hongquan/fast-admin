package com.chq.app.controller;


import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.pojo.OperationLog;
import com.chq.app.service.IOperationLogService;
import com.chq.app.util.PageUtils;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 * 操作日志记录 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-08-13
 */
@RestController
@RequestMapping("/log")
public class OperationLogController {

    @Resource
    private IOperationLogService operationLogService;

    @GetMapping("/list")
    @PreAuth("system:log:query")
    public TableInfo<List<OperationLog>> list(OperationLog operationLog) {
        PageUtils.startPage();
        List<OperationLog> list=operationLogService.getList(operationLog);
        return TableInfo.ok(list);

    }

}
