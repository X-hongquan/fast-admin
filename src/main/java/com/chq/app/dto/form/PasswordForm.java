package com.chq.app.dto.form;

import lombok.Data;

@Data
public class PasswordForm {

    private String oldPassword;

    private String newPassword;
    

    private String code;
}
