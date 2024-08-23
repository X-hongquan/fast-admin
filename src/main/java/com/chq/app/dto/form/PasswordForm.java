package com.chq.app.dto.form;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

@Data
public class PasswordForm {

    @Length(min = 6,max = 20,message = "密码长度必须在6-20之间")
    private String oldPassword;

    @Length(min = 6,max = 20,message = "密码长度必须在6-20之间")
    private String newPassword;

    @NotBlank(message = "验证码不能为空")
    private String code;
}
