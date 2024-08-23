package com.chq.app.util;

import com.chq.app.common.enums.ExecuteType;
import com.chq.app.dto.MessageDto;
import com.chq.app.pojo.OperationLog;
import com.chq.app.service.IOperationLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


@Slf4j
@Component
public class AsyncExecutor {

    private static final int DEFAULT_THREAD_POOL_SIZE = 5;

    private static final ExecutorService executorService = Executors.newFixedThreadPool(DEFAULT_THREAD_POOL_SIZE);


    private static void executeSendEmail(MessageDto dto) {

        executorService.execute(() -> {
            try {
                JavaMailUntil.sendMail(dto);
            } catch (Exception e) {
                log.error("发送邮件失败,{}", dto);
            }
        });
    }


    private static void executeRecordLog(OperationLog operationLog) {

        executorService.execute(() -> {
            try {
                IOperationLogService bean = SpringUtils.getBean(IOperationLogService.class);
                bean.save(operationLog);
            } catch (Exception e) {
                log.error("记录日志失败,{}", operationLog);
            }
        });

    }

    public static <T> void execute(ExecuteType type, T t) {
        switch (type) {
            case MAIl -> {
                executeSendEmail((MessageDto) t);
            }
            case LOG -> {
                executeRecordLog((OperationLog) t);
            }
            default -> {
            }
        }
    }



}
