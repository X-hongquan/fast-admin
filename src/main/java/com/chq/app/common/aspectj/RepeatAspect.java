package com.chq.app.common.aspectj;


import com.alibaba.fastjson2.JSON;

import com.chq.app.common.annoation.RepeatSubmit;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.common.util.UserHolder;
import com.chq.app.common.util.WebUtils;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Aspect
@Component
public class RepeatAspect {

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Before("@annotation(repeatSubmit)")
    public void beforeMethod(JoinPoint joinPoint, RepeatSubmit repeatSubmit) {
        MethodSignature method= (MethodSignature) joinPoint.getSignature();
        Object[] args = joinPoint.getArgs();
        isRepeatSubmit(repeatSubmit,args[0]);
    }

    private void isRepeatSubmit(RepeatSubmit annotation,Object arg) {
        HttpServletRequest request = WebUtils.getRequest();
        String token = UserHolder.getUser().getToken();
        String uri = request.getRequestURI();
        String key = token + uri;
        String preParams = stringRedisTemplate.opsForValue().get(key);
        String nowParams = JSON.toJSONString(arg);
        boolean f = false;
        if (nowParams.equals(preParams))
            f = true;
        stringRedisTemplate.opsForValue().set(key, nowParams, annotation.interval(), TimeUnit.MILLISECONDS);
        if (f) {
            throw new ServiceException(annotation.message());
        }
    }
}
