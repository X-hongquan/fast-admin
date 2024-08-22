package com.chq.app.util;

import com.chq.app.common.enums.ExecuteType;
import com.chq.app.dto.MessageDto;
import com.chq.app.pojo.OperationLog;
import com.chq.app.service.IOperationLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


@Slf4j
@Component
public class AsyncExecutor {

    private static final int DEFAULT_THREAD_POOL_SIZE = 5;

    private static final ExecutorService executorService = Executors.newFixedThreadPool(DEFAULT_THREAD_POOL_SIZE);


    private static void executeSendEmail(Runnable runnable, MessageDto dto) {
        try {
            executorService.execute(runnable);
        } catch (Exception e) {
            log.error("发送邮件失败,主题={},内容={},接收人={}", dto.getTheme(), dto.getContent(), dto.getTo());
        }
    }

    private static void executeRecordLog(Runnable runnable, OperationLog operationLog) {
        try {
            executorService.execute(runnable);
        } catch (Exception e) {
            log.error("记录日志失败,日志内容={}", operationLog);
        }
    }


    public static <T> void execute(Runnable runnable, ExecuteType type, T t) {
        switch (type) {
            case MAIl -> {
                executeSendEmail(runnable, (MessageDto) t);
            }
            case LOG -> {
                executeRecordLog(runnable, (OperationLog) t);
            }
            default -> {
            }
        }
    }

    public static void execute(Runnable runnable) {
        executorService.execute(runnable);
    }

}
