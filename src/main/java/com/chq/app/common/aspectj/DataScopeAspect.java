package com.chq.app.common.aspectj;

import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.BaseEntity;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.enums.PermissionModeEnum;
import com.chq.app.pojo.Role;
import com.chq.app.util.UserHolder;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.bouncycastle.math.raw.Mod;
import org.simpleframework.xml.stream.Mode;
import org.springframework.stereotype.Component;


import java.util.Set;

@Aspect
@Component
public class DataScopeAspect {


    public static final String DATA_SCOPE = "dataScope";

    public static final String CONTROL = "control";

    public static final String NO_CONTROL = "noControl";

    public static final String DATA_SCOPE_SELF = "2";

    public static final String DATA_SCOPE_ALL = "1";

    private PermissionModeEnum mode;

    public void setMode(PermissionModeEnum mode) {
        this.mode = mode;
    }


    @Before("@annotation(dataScope)")
    public void beforeMethod(JoinPoint joinPoint, DataScope dataScope) {
        BaseEntity entity = clearDataScope(joinPoint);
        if (entity == null) return;
        handleDataScope(dataScope, entity);
    }

    private void handleDataScope(DataScope dataScope, BaseEntity entity) {
        LoginUser loginUser = UserHolder.getUser();
        if (loginUser.isAdmin()) return;
        Set<Role> roles = loginUser.getRoles();
        StringBuilder sb = new StringBuilder("(");
        for (Role role : roles) {
            sb.append(role.getId()).append(",");
        }
        sb.deleteCharAt(sb.length() - 1).append(")");
        String sql = null;
        sql = String.format("and  %s.%s in %s",
                dataScope.alias(), dataScope.value(), sb);


        entity.getParams().put(DATA_SCOPE, sql);

    }

    private static BaseEntity clearDataScope(JoinPoint joinPoint) {
        Object arg = joinPoint.getArgs()[0];
        if (arg != null && arg instanceof BaseEntity) {
            BaseEntity baseEntity = (BaseEntity) arg;
            baseEntity.getParams().put(DATA_SCOPE, "");
            return baseEntity;
        }
        return null;
    }
}
