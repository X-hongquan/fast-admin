package com.chq.app.common.async;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class AsyncThreadPool {


    private ThreadPoolExecutor executor;

    public AsyncThreadPool() {

        executor = new ThreadPoolExecutor(
                Runtime.getRuntime().availableProcessors(),
                Runtime.getRuntime().availableProcessors()*5,
                60,
                TimeUnit.SECONDS,
                new ArrayBlockingQueue<>(500),
                new CustomRejectedExecutionHandler()
        );

    }


    public void execute(Runnable runnable) {
        executor.execute(runnable);
    }

    private static class CustomRejectedExecutionHandler implements RejectedExecutionHandler {

        @Override
        public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
            log.error("线程池满载，拒绝执行任务");
        }

    }


}
