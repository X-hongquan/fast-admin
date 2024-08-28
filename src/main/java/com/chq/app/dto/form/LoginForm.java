package com.chq.app.dto.form;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

@Data
public class LoginForm {
    @NotBlank
    @Length(min = 5,max = 20,message = "用户名长度必须在6-20之间")
    private String username;

    @Length(min = 6,max = 20,message = "密码长度必须在6-20之间")
    private String password;

    @NotBlank(message = "验证码不能为空")
    private String captcha;

    @NotBlank(message = "验证码不能为空")
    private String key;

}
