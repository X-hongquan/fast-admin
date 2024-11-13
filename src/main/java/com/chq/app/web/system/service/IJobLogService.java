package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.JobLog;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author ASUS
* @description 针对表【job_log(定时任务日志表)】的数据库操作Service
* @createDate 2024-08-21 22:25:59
*/
public interface IJobLogService extends IService<JobLog> {


    List<JobLog> getList(JobLog jobInfo);

    JobLog getJobLogById(Integer id);
}
