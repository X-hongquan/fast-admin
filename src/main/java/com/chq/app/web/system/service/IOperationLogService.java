package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.OperationLog;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* <p>
* 操作日志记录 服务类
* </p>
*
* @author chq
* @since 2024-09-19
*/
public interface IOperationLogService extends IService<OperationLog> {

    List<OperationLog> getList(OperationLog operationLog);

    OperationLog getOperationLogById(Long id);

    void addOperationLog(OperationLog operationLog);

    void editOperationLog(OperationLog operationLog);

    void deleteOperationLogByIds(Long[] ids);
}
