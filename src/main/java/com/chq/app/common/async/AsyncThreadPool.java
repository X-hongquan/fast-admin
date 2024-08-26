package com.chq.app.common.async;

import com.chq.app.common.exception.ServiceException;
import com.google.common.util.concurrent.ThreadFactoryBuilder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.concurrent.*;

@Component
@Slf4j
public class AsyncThreadPool {


    private ThreadPoolExecutor executor;

    public AsyncThreadPool() {
        ThreadFactory threadFactory = new ThreadFactoryBuilder().setNameFormat("async-pool-%d").build();
        executor = new ThreadPoolExecutor(
                Runtime.getRuntime().availableProcessors(),
                Runtime.getRuntime().availableProcessors() * 5,
                60,
                TimeUnit.SECONDS,
                new ArrayBlockingQueue<>(500),
                threadFactory,
                new CustomRejectedExecutionHandler()
        );

    }


    public void execute(Runnable runnable) {
        executor.execute(runnable);
    }

    private static class CustomRejectedExecutionHandler implements RejectedExecutionHandler {

        @Override
        public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
            throw new ServiceException("异步任务线程池已满");
        }

    }


}
