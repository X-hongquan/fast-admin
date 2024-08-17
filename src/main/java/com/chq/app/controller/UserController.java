package com.chq.app.controller;


import com.alibaba.excel.EasyExcel;
import com.chq.app.common.annoation.Log;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.enums.BusinessType;
import com.chq.app.dto.form.EmailForm;
import com.chq.app.dto.form.LoginForm;
import com.chq.app.dto.form.PasswordForm;
import com.chq.app.pojo.Role;
import com.chq.app.pojo.User;
import com.chq.app.service.IRoleService;
import com.chq.app.service.IUserService;
import com.chq.app.util.PageUtils;
import com.chq.app.util.UserHolder;
import com.chq.app.util.excel.DataListener;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URLEncoder;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.List;

import static com.chq.app.common.aspectj.DataScopeAspect.CONTROL;

/**
 * <p>
 * 用户表 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private IUserService userService;


    @Resource
    private IRoleService roleService;

    @GetMapping("/list")
    @PreAuth("system:user:query")
    public TableInfo<List<User>> list(User user) {
        PageUtils.startPage();
        List<User> list = userService.getList(user);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth("system:user:query")
    public R<User> get(@PathVariable Long id) {
        User user = userService.getUserById(id);
        return R.ok(user);
    }


    @PostMapping
    @PreAuth("system:user:add")
    @Log(title = "新增用户", businessType = BusinessType.INSERT, excludeParamNames = {"password"})
    public R<Integer> add(@RequestBody User user) {
        int row = userService.add(user);
        return R.ok(row);
    }

    @PutMapping
    @PreAuth("system:user:edit")
    public R<Integer> edit(@RequestBody User user) {
        User u = userService.getUserById(user.getId());
        UserHolder.getUser().checkHasControl(u.getCreateBy());
        int row = userService.edit(user);
        return R.ok(row);
    }

    @DeleteMapping("/{ids}")
    @PreAuth("system:user:remove")
    public R<Integer> delete(@PathVariable Long[] ids) {
        int row = userService.del(ids);
        return R.ok(row);
    }

    @PostMapping("/login")
    public R<String> login(@RequestBody LoginForm loginForm) {
        String token = userService.login(loginForm);
        return R.ok(token);
    }


    @GetMapping("/export")
    @PreAuth("system:user:export")
    public void export(HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
        String fileName = URLEncoder.encode("测试", "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        EasyExcel.write(response.getOutputStream(), User.class).sheet("模板").doWrite(userService.list());
    }


    @PostMapping("/import")
    @PreAuth("system:user:import")
    public R upload(MultipartFile file) throws IOException {
        List<User> list = new ArrayList<>();
        try {
            EasyExcel.read(file.getInputStream(), User.class, new DataListener(list)).sheet().doRead();
        } catch (RuntimeException e) {
            throw new ServerException("业务异常");
        }
        System.out.println(list);
        return R.ok();
    }

    @PostMapping("/logout")
    public R<String> logout() {
        return userService.logout();
    }

    @GetMapping("/info")
    public R<LoginUser> info() {
        return R.ok(UserHolder.getUser());
    }

    @PutMapping("/info/avatar")
    public R changeAvatar(@RequestParam("file") MultipartFile file) {

        return userService.changeAvatar(file);

    }

    @GetMapping("/info/code/password")
    public R<String> sendPasswordCode() {
        userService.sendPwdCode();
        return R.ok();
    }

    @GetMapping("/info/code/{email}")
    public R<String> sendEmailCode(@PathVariable String email) {
        userService.sendEmailCode(email);
        return R.ok();
    }


    @PutMapping("/info/password")
    public R changePassword(@RequestBody PasswordForm passwordForm) {
        String oldPassword = passwordForm.getOldPassword();
        String newPassword = passwordForm.getNewPassword();
        return userService.changePassword(oldPassword, newPassword);
    }


    @PutMapping("/info/password/reset")
    public R resetPassword(@RequestBody PasswordForm passwordForm) {
        String newPassword = passwordForm.getNewPassword();
        String code = passwordForm.getCode();
        return userService.resetPassword(newPassword, code);
    }

    @PutMapping("/info/email/reset")
    public R restEmail(@RequestBody EmailForm form) {
        String email = form.getNewEmail();
        String code = form.getCode();
        return userService.resetEmail(email, code);
    }
}
