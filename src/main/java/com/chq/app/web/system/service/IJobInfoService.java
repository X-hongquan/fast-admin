package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.JobInfo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author ASUS
* @description 针对表【job_info(定时任务信息表)】的数据库操作Service
* @createDate 2024-08-21 22:25:59
*/
public interface IJobInfoService extends IService<JobInfo> {

    List<JobInfo> getList(JobInfo jobInfo);

    JobInfo getJobInfoById(Integer id);


}
