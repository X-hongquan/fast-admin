package com.chq.app.schedule;

import com.chq.app.pojo.JobInfo;
import com.chq.app.pojo.JobLog;

import com.chq.app.service.IJobInfoService;
import com.chq.app.service.IJobLogService;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;

@Component
@Slf4j
public class Trigger {

    private ConcurrentMap<String, JobInfo> map;
    private ExecutorService executor;

    @Autowired
    private IJobInfoService jobInfoService;

    @Autowired
    private IJobLogService jobLogService;


    private Thread trigger;

    private Thread checker;

    private long rate = 1000L;

    private int threads = 5;

    private JobTemplate target;

    private Map<String, Method> targetMethods;

    public Trigger(IJobLogService jobLogService, IJobInfoService jobInfoService) {
        this.map = new ConcurrentHashMap();
        targetMethods = new ConcurrentHashMap<>();
        executor = Executors.newFixedThreadPool(threads);
        target = new JobTemplate();
        Class<? extends JobTemplate> aClass = target.getClass();
        Method[] methods = aClass.getMethods();
        for (Method method : methods) {
            if (method.isAnnotationPresent(Job.class)) {
                Job annotation = method.getAnnotation(Job.class);
                String name = annotation.value();
                targetMethods.put(name, method);
            }
        }
    }

    private void init() {
        List<JobInfo> list = jobInfoService.getList(new JobInfo().setTriggerStatus(1));
        for (JobInfo jobInfo : list) {
            String key = jobInfo.getJobName();
            initJob(jobInfo, key);
            map.put(key, jobInfo);
        }
    }

    private void initJob(JobInfo jobInfo, String key) {
        Method method = targetMethods.get(key);
        jobInfo.setMethod(method);
        if (jobInfo.getJobType() == 2)
            jobInfo.setCron(new Cron(jobInfo.getJobCron()));
        else if (jobInfo.getJobType() == 1) {

        }
    }

    public void start(String key, JobInfo jobInfo) {
        initJob(jobInfo, key);
        map.put(key, jobInfo);
        jobInfo.setTriggerLastTime(LocalDateTime.now());
        jobInfo.setTriggerStatus(1);
        jobInfoService.updateById(jobInfo);
    }

    public void stop(String key, JobInfo jobInfo) {
        map.remove(key);
        jobInfo.setTriggerStatus(0);
        jobInfo.setTriggerLastTime(LocalDateTime.now());
        jobInfoService.updateById(jobInfo);
    }

    public void remove(String key) {
        map.remove(key);
    }

    @PostConstruct
    public void go() {
        init();
        initChecker();
        trigger = new Thread(() -> {
            run();
        }, "trigger");
        trigger.setPriority(Thread.MAX_PRIORITY);
        trigger.start();

    }

    private void initChecker() {
        checker = new Thread(() -> {
            while (true) {
                try {
                    TimeUnit.HOURS.sleep(1);
                    if (!trigger.isAlive()) {
                        trigger = new Thread(() -> {
                            run();
                        }, "trigger");
                        trigger.setPriority(Thread.MAX_PRIORITY);
                        trigger.start();
                    }
                } catch (InterruptedException e) {
                    //todo 中断检查线程
                }
            }
        });
    }

    private void run() {
        while (true) {
            try {
                for (Map.Entry<String, JobInfo> entry : map.entrySet()) {
                    JobInfo jobInfo = entry.getValue();
                    if (jobInfo.getJobType() == 1)
                        handleFixedRate(jobInfo);
                    if (jobInfo.getJobType() == 2)
                        handleCron(jobInfo);
                }
                try {
                    Thread.sleep(rate);
                } catch (InterruptedException e) {
                    //todo 线程被打断
                }
            } catch (RuntimeException e) {
                //todo trigger异常
            }
        }
    }

    private void handleCron(JobInfo jobInfo) {
        LocalDateTime now = LocalDateTime.now();
        int dayOfMonth = now.getDayOfMonth();
        String jobCron = jobInfo.getJobCron();
        if (jobCron.contains("1L") && dayOfMonth == 1) {
            jobInfo.getCron().fillDays(jobCron, 1, YearMonth.now().lengthOfMonth());
        }
        if (jobInfo.getCron().isMatch()) {
            JobLog jobLog = new JobLog();
            jobLog.setTriggerTime(now);
            jobLog.setJobId(jobInfo.getId());
            Method method = jobInfo.getMethod();
            execute(method, jobLog);
        }

    }

    private void handleFixedRate(JobInfo jobInfo) {
        long now = System.currentTimeMillis();
        Long jobNextTime = jobInfo.getJobNextTime();
        if (jobNextTime.equals(now) || now > jobNextTime) {
            long match = ((now - jobNextTime) / 1000) % jobInfo.getJobRate();
            if (match == 0L) {
                JobLog jobLog = new JobLog();
                jobLog.setJobId(jobInfo.getId());
                jobLog.setTriggerTime(LocalDateTime.now());
                Method method = jobInfo.getMethod();
                execute(method, jobLog);
            }
        }
    }

    private void execute(Method method, JobLog jobLog) {
        executor.execute(() -> {
            log.info("开始执行任务: {}", jobLog.getJobId());
            try {
                long start = System.currentTimeMillis();
                method.invoke(target);
                long end = System.currentTimeMillis();
                jobLog.setHandleTime(end - start)
                        .setHandleStatus(1)
                        .setTriggerMsg("success");
            } catch (IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
                jobLog.setHandleStatus(0)
                        .setTriggerMsg(e.getMessage());
            }
            jobLogService.save(jobLog);
        });
    }


}
