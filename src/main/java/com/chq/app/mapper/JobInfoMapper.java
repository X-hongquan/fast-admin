package com.chq.app.mapper;

import com.chq.app.pojo.JobInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author ASUS
* @description 针对表【job_info(定时任务信息表)】的数据库操作Mapper
* @createDate 2024-08-21 22:25:59
* @Entity com.chq.app.pojo.JobInfo
*/
public interface JobInfoMapper extends BaseMapper<JobInfo> {

    List<JobInfo> getList(JobInfo jobInfo);
}




