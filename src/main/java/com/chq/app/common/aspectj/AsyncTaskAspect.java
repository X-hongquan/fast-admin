package com.chq.app.common.aspectj;


import com.chq.app.common.annoation.AsyncTask;
import com.chq.app.common.async.AsyncThreadPool;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
@Slf4j
public class AsyncTaskAspect {


    @Resource
    private AsyncThreadPool asyncThreadPool;

    @Resource
    private ObjectMapper objectMapper;

    @Around("@annotation(asyncTask)")
    public void around(ProceedingJoinPoint joinPoint, AsyncTask asyncTask) throws Throwable {
        asyncThreadPool.execute(() -> {
            try {
                Object proceed = joinPoint.proceed();
            } catch (Throwable e) {
                Object[] args = joinPoint.getArgs();
                StringBuilder sb = new StringBuilder("标题=" + asyncTask.title() + ",");
                for (int i = 0; i < args.length; i++) {
                    sb.append(String.format("参数%d=%s ", i + 1, args[i]));
                }
                log.error(sb.deleteCharAt(sb.length() - 1).toString());
            }
        });


    }

}
