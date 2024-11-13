package com.chq.app.web.system.controller;


import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.metadata.style.WriteCellStyle;
import com.alibaba.excel.write.style.HorizontalCellStyleStrategy;
import com.chq.app.common.annoation.Log;
import com.chq.app.common.annoation.RepeatSubmit;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.domain.TableInfo;
import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.enums.BusinessType;
import com.chq.app.dto.form.EmailForm;
import com.chq.app.dto.form.LoginForm;
import com.chq.app.dto.form.PasswordForm;
import com.chq.app.web.system.pojo.User;
import com.chq.app.web.system.service.IRoleService;
import com.chq.app.web.system.service.IUserService;
import com.chq.app.common.util.PageUtils;
import com.chq.app.common.util.UserHolder;
import com.chq.app.common.util.excel.DataListener;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.List;


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
    @PreAuth(value = "system:user:query", description = "查询用户权限")
    public TableInfo<List<User>> list(User user) {
        PageUtils.startPage();
        List<User> list = userService.getList(user);
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth(value = "system:user:query", description = "查询用户权限")
    public R<User> get(@PathVariable Long id) {
        User user = userService.getUserById(id);
        return R.ok(user);
    }


    @PostMapping
    @PreAuth(value = "system:user:add", description = "新增用户权限")
    @Log(title = "用户管理", businessType = BusinessType.INSERT)
    @RepeatSubmit
    public R<Integer> add(@RequestBody User user) {
        int row = userService.add(user);
        return R.ok(row);
    }

    @PutMapping
    @PreAuth(value = "system:user:edit", description = "编辑用户权限")
    public R<Integer> edit(@RequestBody User user) {
        User u = userService.getUserById(user.getId());
        UserHolder.getUser().checkHasControl(u.getCreateBy());
        int row = userService.edit(user);
        return R.ok(row);
    }

    @DeleteMapping("/{ids}")
    @Log(title = "删除用户", businessType = BusinessType.DELETE)
    @PreAuth(value = "system:user:remove", description = "删除用户权限")
    public R<Integer> delete(@PathVariable Long[] ids) {
        int row = userService.del(ids);
        return R.ok(row);
    }

    @PostMapping("/login")
    public R<String> login(@Validated @RequestBody LoginForm loginForm) {
        String token = userService.login(loginForm);
        return R.ok(token);
    }


    @GetMapping("/export")
    @PreAuth(value = "system:user:export", description = "导出用户权限")
    @Log(title = "导出用户", businessType = BusinessType.EXPORT, isSaveRequestData = false)
    public void export(HttpServletResponse response) throws IOException {

        //设置头样式
        WriteCellStyle headStyle = new WriteCellStyle();
        headStyle.setFillForegroundColor(IndexedColors.BLUE.getIndex());
        HorizontalCellStyleStrategy styleStrategy = new HorizontalCellStyleStrategy();
        styleStrategy.setHeadWriteCellStyle(headStyle);
        //设置内容样式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        response.setHeader("Content-disposition", "attachment;filename=user.xlsx");
        //应用样式


        EasyExcel.write(response.getOutputStream(), User.class)
                .sheet("模板").doWrite(userService.list());
    }


    @PostMapping("/import")
    @PreAuth(value = "system:user:import", description = "导入用户权限")
    @Log(title = "导入用户", businessType = BusinessType.IMPORT, isSaveRequestData = false)
    public R upload(MultipartFile file) throws IOException {
        List<User> list = new ArrayList<>();
        try {
            EasyExcel.read(file.getInputStream(), User.class, new DataListener(list)).sheet().doRead();
        } catch (RuntimeException e) {
            throw new ServerException("业务异常");
        }
        return R.ok();
    }

    @GetMapping("/logout")
    public R<String> logout() {
        return userService.logout();
    }

    @GetMapping("/info")
    public R<LoginUser> info() {
        return R.ok(UserHolder.getUser());
    }

    @PutMapping("/info/avatar")
    public R changeAvatar(@RequestParam("file") MultipartFile file) {
        String url= userService.changeAvatar(file);
        return R.ok(url);
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
    public R resetEmail(@RequestBody EmailForm form) {
        String email = form.getNewEmail();
        String code = form.getCode();
        return userService.resetEmail(email, code);
    }
}
