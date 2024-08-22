package com.chq.app.controller;

import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.pojo.JobInfo;
import com.chq.app.pojo.JobLog;
import com.chq.app.schedule.Trigger;
import com.chq.app.service.IJobInfoService;
import com.chq.app.service.IJobLogService;
import com.chq.app.util.PageUtils;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/job")
public class JobInfoController {

    @Resource
    private Trigger trigger;


    @Resource
    private IJobInfoService jobInfoService;


    @Resource
    private IJobLogService jobLogService;


    @GetMapping("/list")
    public TableInfo<List<JobInfo>> list(JobInfo jobInfo) {
        PageUtils.startPage();
        List<JobInfo> list = jobInfoService.getList(jobInfo);
        return TableInfo.ok(list);
    }

    @PostMapping
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
    public R<JobInfo> get(@PathVariable("id") Integer id) {
        JobInfo jobInfo = jobInfoService.getJobInfoById(id);
        return R.ok(jobInfo);
    }

    @PutMapping
    public R edit(@RequestBody JobInfo jobInfo) {
        JobInfo job = jobInfoService.getJobInfoById(jobInfo.getId());
        if (job == null) throw new ServiceException();
        jobInfoService.updateById(jobInfo);
        return R.ok();
    }

    @PutMapping("/start")
    public R start(@RequestBody JobInfo jobInfo) {
        JobInfo job = jobInfoService.getJobInfoById(jobInfo.getId());
        trigger.start(job.getJobName(), job);
        return R.ok();
    }

    @PutMapping("/stop")
    public R stop(@RequestBody JobInfo jobInfo) {
        JobInfo job = jobInfoService.getJobInfoById(jobInfo.getId());
        trigger.stop(job.getJobName(), job);
        return R.ok();
    }

    @DeleteMapping("/{ids}")
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
    public TableInfo<List<JobLog>> listLog(JobLog jobInfo) {
        PageUtils.startPage();
        List<JobLog> list = jobLogService.getList(jobInfo);
        return TableInfo.ok(list);
    }

    @GetMapping("/log/{id}")
    public R<JobLog> getLog(@PathVariable("id") Integer id) {
        JobLog log = jobLogService.getJobLogById(id);
        return R.ok(log);
    }

    @DeleteMapping("/log/{ids}")
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
