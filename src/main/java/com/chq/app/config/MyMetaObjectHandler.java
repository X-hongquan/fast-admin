package com.chq.app.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.chq.app.util.UserHolder;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {


        this.strictInsertFill(metaObject, "createTime", () -> LocalDateTime.now(), LocalDateTime.class);
        this.strictInsertFill(metaObject, "updateTime", () -> LocalDateTime.now(), LocalDateTime.class);
        this.strictInsertFill(metaObject, "createBy", () -> UserHolder.getUser().getUser().getUsername(), String.class);
        this.strictInsertFill(metaObject, "updateBy", () -> UserHolder.getUser().getUser().getUsername(), String.class);
        // 起始版本 3.3.0(推荐使用)
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "updateBy", () -> UserHolder.getUser().getUser().getUsername(), String.class);
        this.strictUpdateFill(metaObject, "updateTime", () -> LocalDateTime.now(), LocalDateTime.class); // 起始版本 3.3.0(推荐)

    }
}