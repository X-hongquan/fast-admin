package com.chq.app.common.constant;


public interface RedisConstant {
    String LOGIN_USER = "login:user:";

    Long ONLINE_TIME = 30 * 60L;

    String CODE_PASSWORD = "code:password:";

    String CODE_EMAIL = "code:email:";

    /**
     * 邮箱验证码时间
     */
    Long CODE_TIME = 5 * 60L;

    /**
     * 可以重新发送邮箱验证码时间
     */
    Long RESEND_TIME = 4 * 60L;

    /**
     * 邮箱验证码长度
     */
    int CODE_NUM = 6;

    /**
     * 验证码时间
     */
    Long CAPTCHA_TIME = 2 * 60L;


}

