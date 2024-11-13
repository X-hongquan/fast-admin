package com.chq.app.common.aspectj;

import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.exception.AuthException;
import com.chq.app.common.util.UserHolder;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class PreAuthAspect {


    @Before("@annotation(preAuth)")
    public void beforeMethod(JoinPoint joinPoint, PreAuth preAuth) {
        boolean admin = UserHolder.getUser().isAdmin();
        if (admin) return;
        boolean contains = UserHolder.getUser().getPermissions().contains(preAuth.value());
        if (!contains) {
            throw new AuthException();
        }
    }
}
