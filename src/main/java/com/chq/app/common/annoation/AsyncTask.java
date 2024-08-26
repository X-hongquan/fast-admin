package com.chq.app.common.annoation;

import com.chq.app.common.enums.ExecuteType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface AsyncTask {
    String title();
    ExecuteType executeType() default ExecuteType.ASYNC;
}
