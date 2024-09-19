package com.chq.app.service.impl;



import com.chq.app.pojo.OperationLog;
import com.chq.app.mapper.OperationLogMapper;
import com.chq.app.service.IOperationLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * operation_log 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-09-19
 */
@Service
public class OperationLogServiceImpl extends ServiceImpl<OperationLogMapper, OperationLog> implements IOperationLogService {

  

    @Override
    public List<OperationLog> getList(OperationLog operationLog) {
        List<OperationLog> list = baseMapper.getOperationLogList(operationLog);
        return list;
    }

    @Override
    public OperationLog getOperationLogById(Long id) {
        return baseMapper.getOperationLogById(id);
    }

    @Override
    public void addOperationLog(OperationLog operationLog) {
        baseMapper.insert(operationLog);
    }

    @Override
    public void editOperationLog(OperationLog operationLog) {
        baseMapper.updateById(operationLog);
    }

    @Override
    public void deleteOperationLogByIds(Long[] ids) {
        baseMapper.deleteBatchIds(Arrays.asList(ids));
    }
}
