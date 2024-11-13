package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.JobLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author ASUS
* @description 针对表【job_log(定时任务日志表)】的数据库操作Mapper
* @createDate 2024-08-21 22:25:59
* @Entity com.chq.app.pojo.JobLog
*/
public interface JobLogMapper extends BaseMapper<JobLog> {

    List<JobLog> getList(JobLog jobLog);
}




