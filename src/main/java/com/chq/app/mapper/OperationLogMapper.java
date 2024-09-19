package com.chq.app.mapper;

import com.chq.app.pojo.OperationLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* <p>
* 操作日志记录 Mapper 接口
* </p>
*
* @author chq
* @since 2024-09-19
*/
public interface OperationLogMapper extends BaseMapper<OperationLog> {

    List<OperationLog> getOperationLogList(OperationLog operationLog);

    OperationLog getOperationLogById(Long id);

}