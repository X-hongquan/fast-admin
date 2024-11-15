package com.chq.app.web.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.pojo.JobLog;
import com.chq.app.web.system.service.IJobLogService;
import com.chq.app.web.system.mapper.JobLogMapper;

import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ASUS
 * @description 针对表【job_log(定时任务日志表)】的数据库操作Service实现
 * @createDate 2024-08-21 22:25:59
 */
@Service
public class JobLogServiceImpl extends ServiceImpl<JobLogMapper, JobLog> implements IJobLogService {


    @Override
    public List<JobLog> getList(JobLog jobLog) {
        return baseMapper.getList(jobLog);
    }

    @Override
    public JobLog getJobLogById(Integer id) {
        List<JobLog> list = getList(new JobLog().setId(id));
        if (list.size() == 0)
            throw new ServiceException("日志不存在");
        return list.get(0);
    }




}




