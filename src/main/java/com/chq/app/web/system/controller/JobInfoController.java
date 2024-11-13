package com.chq.app.web.system.controller;

import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.pojo.JobInfo;
import com.chq.app.web.system.pojo.JobLog;
import com.chq.app.common.schedule.Trigger;
import com.chq.app.web.system.service.IJobInfoService;
import com.chq.app.web.system.service.IJobLogService;
import com.chq.app.common.util.PageUtils;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/jobInfo")
public class JobInfoController {

    @Resource
    private Trigger trigger;


    @Resource
    private IJobInfoService jobInfoService;


    @Resource
    private IJobLogService jobLogService;


    @GetMapping("/list")
    @PreAuth(value = "system:jobInfo:query", description = "查询任务权限")
    public TableInfo<List<JobInfo>> list(JobInfo jobInfo) {
        PageUtils.startPage();
        List<JobInfo> list = jobInfoService.getList(jobInfo);
        return TableInfo.ok(list);
    }

    @PostMapping
    @PreAuth(value = "system:jobInfo:add", description = "添加任务权限")
    public R add(@RequestBody JobInfo jobInfo) {
        //LocalDateTime转成ms
        if (jobInfo.getJobType() == 1) {
            if (jobInfo.getJobNextTime() == null) {
                jobInfo.setJobNextTime(System.currentTimeMillis());
            }
            if (jobInfo.getJobRate() == null) {
                throw new ServiceException("rate不能为空");
            }
        } else if (jobInfo.getJobType() == 2) {
            if (StringUtils.isBlank(jobInfo.getJobCron())) {
                throw new ServiceException("cron不能为空");
            }
            jobInfo.setJobCron(jobInfo.getJobCron().trim());
        }
        jobInfoService.save(jobInfo);
        return R.ok();
    }

    @GetMapping("/{id}")
    @PreAuth(value = "system:jobInfo:query", description = "查询任务权限")
    public R<JobInfo> get(@PathVariable("id") Integer id) {
        JobInfo jobInfo = jobInfoService.getJobInfoById(id);
        return R.ok(jobInfo);
    }

    @PutMapping
    @PreAuth(value = "system:jobInfo:edit", description = "编辑任务权限")
    public R edit(@RequestBody JobInfo jobInfo) {
        JobInfo job = jobInfoService.getJobInfoById(jobInfo.getId());
        if (job == null) throw new ServiceException();
        jobInfoService.updateById(jobInfo);
        return R.ok();
    }

    @PutMapping("/start")
    @PreAuth(value = "system:jobInfo:edit", description = "编辑任务权限")
    public R start(@RequestBody JobInfo jobInfo) {
        JobInfo job = jobInfoService.getJobInfoById(jobInfo.getId());
        trigger.start(job.getJobName(), job);
        return R.ok();
    }

    @PutMapping("/stop")
    @PreAuth(value = "system:jobInfo:edit", description = "编辑任务权限")
    public R stop(@RequestBody JobInfo jobInfo) {
        JobInfo job = jobInfoService.getJobInfoById(jobInfo.getId());
        trigger.stop(job.getJobName(), job);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth(value = "system:jobInfo:remove", description = "删除任务权限")
    public R delete(@PathVariable Integer[] ids) {
        List<JobInfo> list = new ArrayList<>();
        List<Integer> idList = new ArrayList<>();
        for (Integer id : ids) {
            JobInfo job = jobInfoService.getJobInfoById(id);
            if (job == null)
                throw new ServiceException();
            list.add(job);
            idList.add(id);
        }
        jobInfoService.removeByIds(idList);
        for (JobInfo job : list) {
            trigger.remove(job.getJobName());

        }
        return R.ok();
    }


    @GetMapping("/log/list")
    @PreAuth(value = "system:jobLog:query", description = "查询任务日志权限")
    public TableInfo<List<JobLog>> listLog(JobLog jobInfo) {
        PageUtils.startPage();
        List<JobLog> list = jobLogService.getList(jobInfo);
        return TableInfo.ok(list);
    }

    /**
     * 根据id查询日志任务
     * @param id
     * @return
     */
    @GetMapping("/log/{id}")
    @PreAuth(value = "system:jobLog:query", description = "查询任务日志权限")
    public R<JobLog> getLog(@PathVariable("id") Integer id) {
        JobLog log = jobLogService.getJobLogById(id);
        return R.ok(log);
    }

    @DeleteMapping("/log/{ids}")
    @PreAuth(value = "system:jobLog:remove", description = "删除任务日志权限")
    public R deleteLog(@PathVariable Integer[] ids) {
        List<Integer> idList = new ArrayList<>();
        for (Integer id : ids) {
            JobLog job = jobLogService.getJobLogById(id);
            if (job == null)
                throw new ServiceException();
            idList.add(id);
        }
        jobLogService.removeByIds(idList);
        return R.ok();
    }

}
