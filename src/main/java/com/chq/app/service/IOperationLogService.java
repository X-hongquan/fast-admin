package com.chq.app.service;

import com.chq.app.pojo.OperationLog;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 操作日志记录 服务类
 * </p>
 *
 * @author chq
 * @since 2024-08-13
 */
public interface IOperationLogService extends IService<OperationLog> {

    List<OperationLog> getList(OperationLog operationLog);
}
