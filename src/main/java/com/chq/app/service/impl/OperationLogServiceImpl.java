package com.chq.app.service.impl;

import com.chq.app.common.annoation.AsyncTask;
import com.chq.app.pojo.OperationLog;
import com.chq.app.mapper.OperationLogMapper;
import com.chq.app.service.IOperationLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 操作日志记录 服务实现类
 * </p>
 *
 * @author chq
 * @since 2024-08-13
 */
@Service
public class OperationLogServiceImpl extends ServiceImpl<OperationLogMapper, OperationLog> implements IOperationLogService {

    @Override
    public List<OperationLog> getList(OperationLog operationLog) {
        return baseMapper.getOperationList(operationLog);
    }

    @AsyncTask(title = "记录操作日志")
    @Override
    public void asyncRecordLog(OperationLog operationLog) {
        baseMapper.insert(operationLog);
    }


}
