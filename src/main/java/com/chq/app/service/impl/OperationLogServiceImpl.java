package com.chq.app.service.impl;

import com.chq.app.pojo.OperationLog;
import com.chq.app.mapper.OperationLogMapper;
import com.chq.app.service.IOperationLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

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

}
