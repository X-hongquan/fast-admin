package com.chq.app.web.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.pojo.JobInfo;
import com.chq.app.web.system.service.IJobInfoService;
import com.chq.app.web.system.mapper.JobInfoMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ASUS
 * @description 针对表【job_info(定时任务信息表)】的数据库操作Service实现
 * @createDate 2024-08-21 22:25:59
 */
@Service
public class JobInfoServiceImpl extends ServiceImpl<JobInfoMapper, JobInfo> implements IJobInfoService {

    @Override
    public List<JobInfo> getList(JobInfo jobInfo) {
        return baseMapper.getList(jobInfo);
    }

    @Override
    public JobInfo getJobInfoById(Integer id) {
        JobInfo jobInfo = getList(new JobInfo().setId(id)).get(0);
        if (jobInfo == null)
            throw new ServiceException("未找到该任务");
        return jobInfo;
    }
}




