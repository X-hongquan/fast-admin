package com.chq.app.common.constant;


public interface RedisConstant {
    String LOGIN_USER = "login:user:";

    Long ONLINE_TIME = 30 * 60L;

    String CODE_PASSWORD = "code:password:";

    String CODE_EMAIL = "code:email:";

    Long CODE_TIME = 5 * 60L;

    Long RESEND_TIME = 4 * 60L;

    int CODE_NUM = 6;
}

