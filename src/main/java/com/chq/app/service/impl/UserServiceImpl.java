package com.chq.app.service.impl;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.chq.app.common.annoation.DataScope;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;

import com.chq.app.common.filter.JSONFilter;
import com.chq.app.config.MinioConfig;
import com.chq.app.dto.MessageDto;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.dto.form.LoginForm;
import com.chq.app.mapper.UserMapper;
import com.chq.app.pojo.*;
import com.chq.app.service.*;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.util.*;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import static com.chq.app.common.constant.RedisConstant.*;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Resource
    private PasswordEncoder passwordEncoder;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private IUserRoleService userRoleService;

    @Resource
    private MinioClient minioClient;

    @Resource
    private MinioConfig minioConfig;

    @Resource
    private IRoleService roleService;

    @Resource
    private JavaMailUntil javaMailUntil;


    @Resource
    private ILoginLogService loginLogService;


    @Override
    @DataScope(alias = "ur")
    public List<User> getList(User user) {
        List<User> userList = baseMapper.getUserList(user);
        for (User u : userList) {
            Set<Role> roles = baseMapper.getRoleIdsByUserId(u.getId());
            u.setRoles(roles);
        }
        return userList;
    }

    @Override
    public String login(LoginForm loginForm) {
        String s = stringRedisTemplate.opsForValue().get(loginForm.getKey());
        if (!loginForm.getCaptcha().equalsIgnoreCase(s))
            throw new ServiceException("验证码错误");
        User u = getOne(new LambdaQueryWrapper<User>().eq(User::getUsername, loginForm.getUsername()));
        if (u == null) {
            throw new ServiceException("用户名或密码错误");
        }
        if (!passwordEncoder.matches(loginForm.getPassword(), u.getPassword())) {
            throw new ServiceException("用户名或密码错误");
        }
        LoginUser loginUser = new LoginUser();
        loginUser.setUser(u);
        Set<Role> roles = baseMapper.getRoleIdsByUserId(u.getId());
        loginUser.setRoles(roles);
        if (!roles.isEmpty()) {
            Set<Long> roleIds = roles.stream().map(item -> item.getId()).collect(Collectors.toSet());
            Set<String> permissions = getBaseMapper().getPermissionsByRoleIds(roleIds);
            loginUser.setPermissions(permissions);
        }

        String uuid = IdWorker.get32UUID();
        String jwt = JwtUtil.createJwt(uuid);
        stringRedisTemplate.opsForValue().set(LOGIN_USER + uuid, JSON.toJSONString(loginUser, JSONFilter.excludePropertyPreFilter()), ONLINE_TIME, TimeUnit.SECONDS);
        loginLogService.recordLoginLog(u, uuid, WebUtils.getIp());
        return jwt;

    }


    @Override
    public R<String> logout() {
        LoginUser user = UserHolder.getUser();
        String token = user.getToken();
        stringRedisTemplate.delete(LOGIN_USER + token);
        return R.ok();
    }

    @Override
    @Transactional
    public int add(User user) {
        String encode = passwordEncoder.encode(user.getPassword());
        user.setPassword(encode);
        int row = baseMapper.insert(user);
        Set<Role> roles = user.getRoles();
        List<UserRole> list = new ArrayList<>();
        if (!roles.isEmpty()) {
            for (Role role : roles) {
                Role r = roleService.getRoleById(role.getId());
                UserHolder.getUser().checkHasControl(r.getCreateBy());
                UserRole userRole = new UserRole();
                userRole.setUserId(user.getId());
                userRole.setRoleId(role.getId());
                list.add(userRole);
            }
            userRoleService.saveBatch(list);
        }
        return row;
    }

    @Override
    public int edit(User user) {
        int row = baseMapper.updateById(user);
        userRoleService.remove(new LambdaQueryWrapper<UserRole>().eq(UserRole::getUserId, user.getId()));
        Set<Role> roles = user.getRoles();
        List<UserRole> list = new ArrayList<>();
        if (!roles.isEmpty()) {
            for (Role role : roles) {
                Role r = roleService.getRoleById(role.getId());
                UserHolder.getUser().checkHasControl(r.getCreateBy());
                UserRole userRole = new UserRole();
                userRole.setUserId(user.getId());
                userRole.setRoleId(role.getId());
                list.add(userRole);
            }
        }
        userRoleService.saveBatch(list);
        return row;
    }

    @Override
    @Transactional
    public int del(Long[] ids) {
        LoginUser loginUser = UserHolder.getUser();
        UserServiceImpl proxy = SpringUtils.getAopProxy(this);
        for (Long id : ids) {
            User u = proxy.getUserById(id);
            loginUser.checkHasControl(u.getCreateBy());
        }
        int row = baseMapper.deleteBatchIds(Arrays.asList(ids));
        userRoleService.remove(new LambdaQueryWrapper<UserRole>().in(UserRole::getUserId, ids));
        return row;

    }


    private void sendCode(MessageDto dto) {
        javaMailUntil.sendMail(dto);
    }

    public void sendEmailCode(String email) {
        LoginUser loginUser = UserHolder.getUser();
        String code = RandomStringUtils.randomNumeric(CODE_NUM);
        Long expire = stringRedisTemplate.getExpire(CODE_EMAIL + email, TimeUnit.SECONDS);
        if (expire != null && expire > RESEND_TIME) {
            throw new ServiceException("验证码已发送，请稍后再试");
        }
        stringRedisTemplate.opsForValue().set(CODE_EMAIL + email, code, 5, TimeUnit.MINUTES);
        MessageDto dto = new MessageDto("绑定邮箱", "您的验证码为：" + code, email);
        sendCode(dto);
    }

    @Override
    public User getUserById(Long id) {
        if (id == null) throw new ServiceException("id参数不能为空");
        List<User> list = SpringUtils.getAopProxy(this).getList(new User().setId(id));
        if (list.isEmpty())
            throw new ServiceException("用户不存在");
        return list.get(0);
    }

    @Override
    public R changePassword(String oldPassword, String newPassword) {
        User user = UserHolder.getUser().getUser();
        User one = getOne(new LambdaQueryWrapper<User>().eq(User::getId, user.getId()));
        if (!passwordEncoder.matches(oldPassword, one.getPassword())) {
            return R.fail("旧密码错误");
        }
        User u = new User().setId(user.getId()).setPassword(passwordEncoder.encode(newPassword));
        return R.ok(updateById(u));
    }

    @Override
    public R resetPassword(String newPassword, String code) {
        LoginUser loginUser = UserHolder.getUser();
        User user = loginUser.getUser();
        String s = stringRedisTemplate.opsForValue().get(CODE_PASSWORD + user.getEmail());
        if (StringUtils.isBlank(s)) {
            return R.fail("验证码已过期");
        }
        if (!s.equals(code)) {
            return R.fail("验证码错误");
        }
        User u = new User().setId(user.getId()).setPassword(passwordEncoder.encode(newPassword));
        return R.ok(updateById(u));
    }

    @Override
    public R resetEmail(String email, String code) {
        User user = UserHolder.getUser().getUser();
        String s = stringRedisTemplate.opsForValue().get(CODE_EMAIL + email);
        if (StringUtils.isBlank(s)) {
            return R.fail("验证码已过期");
        }
        if (!s.equals(code)) {
            return R.fail("验证码错误");
        }
        user.setEmail(email);
        stringRedisTemplate.opsForValue().set(LOGIN_USER + UserHolder.getUser().getToken(), JSON.toJSONString(UserHolder.getUser()));
        return R.ok(update(new LambdaUpdateWrapper<User>().set(User::getEmail, email).eq(User::getId, user.getId())));
    }

    @Override
    public R changeAvatar(MultipartFile file) {
        String contentType = file.getContentType();
        if (!contentType.startsWith("image/"))
            return R.fail("文件格式错误");
        String suffix = StringUtils.substringAfterLast(file.getOriginalFilename(), ".");
        StringBuilder sb = new StringBuilder(minioConfig.getProxyUrl());
        String newName = IdWorker.get32UUID() + '.' + suffix;
        sb.append("/").append(minioConfig.getBucketName()).append("/").append(newName);
        try (InputStream in = file.getInputStream()) {
            PutObjectArgs putObjectArgs = PutObjectArgs.builder().object(newName)
                    .contentType(contentType)
                    .stream(in, file.getSize(), -1)
                    .bucket(minioConfig.getBucketName()).build();
            minioClient.putObject(putObjectArgs);
        } catch (Exception e) {
            log.error(e.getMessage());
            return R.fail("上传失败");
        }
        String s = sb.toString();
        LoginUser loginUser = UserHolder.getUser();
        User user = loginUser.getUser();
        update(new LambdaUpdateWrapper<User>().set(User::getAvatar, s).eq(User::getId, user.getId()));
        user.setAvatar(s);
        stringRedisTemplate.opsForValue().set(LOGIN_USER + loginUser.getToken(), JSON.toJSONString(loginUser));
        return R.ok();


    }

    @Override
    public void sendPwdCode() {
        LoginUser loginUser = UserHolder.getUser();
        User user = loginUser.getUser();
        String code = RandomStringUtils.randomNumeric(CODE_NUM);
        Long expire = stringRedisTemplate.getExpire(CODE_PASSWORD + user.getEmail(), TimeUnit.SECONDS);
        MessageDto dto = new MessageDto("重置密码", "您的验证码为：" + code, user.getEmail());
        stringRedisTemplate.opsForValue().set(CODE_PASSWORD + user.getEmail(), code, CODE_TIME, TimeUnit.SECONDS);
        if (expire != null && expire > RESEND_TIME) {
            throw new ServiceException("验证码已发送，请稍后再试");
        }
        sendCode(dto);
    }


}
