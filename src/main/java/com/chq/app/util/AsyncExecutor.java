package com.chq.app.util;

import com.chq.app.dto.MessageDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


@Slf4j
@Component
public class AsyncExecutor {

    private static final int DEFAULT_THREAD_POOL_SIZE = 5;

    private static final ExecutorService executorService = Executors.newFixedThreadPool(DEFAULT_THREAD_POOL_SIZE);

    public static void executeSendEmail(Runnable runnable, MessageDto dto) {
        try {
            executorService.execute(runnable);
        } catch (Exception e) {
            log.error("发送邮件失败,主题={},内容={},接收人={}", dto.getTheme(), dto.getContent(), dto.getTo());
        }
    }
}
