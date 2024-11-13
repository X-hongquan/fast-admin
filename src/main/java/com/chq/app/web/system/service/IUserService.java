package com.chq.app.web.system.service;

import com.chq.app.common.domain.R;
import com.chq.app.dto.form.LoginForm;
import com.chq.app.web.system.pojo.User;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface IUserService extends IService<User> {

    List<User> getList(User user);

    String login(LoginForm loginForm);

    R<String> logout();

    int add(User user);

    int edit(User user);

    int del(Long[] ids);


    R changePassword(String oldPassword, String newPassword);

    R resetPassword(String newPassword, String code);

    R resetEmail(String email, String code);

    String changeAvatar(MultipartFile file);

    void sendPwdCode();

    void sendEmailCode(String email);

    User getUserById(Long id);
}
