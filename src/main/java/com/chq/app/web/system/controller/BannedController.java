package com.chq.app.web.system.controller;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.chq.app.common.annoation.Log;
import com.chq.app.common.domain.LoginUser;
import com.chq.app.common.domain.R;
import com.chq.app.common.enums.BusinessType;
import com.chq.app.dto.TokenDto;
import com.chq.app.web.system.pojo.LoginLog;
import com.chq.app.web.system.pojo.User;
import com.chq.app.web.system.service.ILoginLogService;
import com.chq.app.web.system.service.IUserRoleService;
import com.chq.app.web.system.service.IUserService;
import com.chq.app.websocket.CustomWebSocketHandler;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import static com.chq.app.common.constant.RedisConstant.LOGIN_USER;

@Slf4j
@RestController
@RequestMapping("/banned")
public class BannedController {

    @Autowired
    private IUserService userService;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private ILoginLogService loginLogService;

    /**
     * 封号处理
     *
     * @param tokenDto
     * @return
     */
    @PostMapping
    @Log(title = "封号强退", businessType = BusinessType.FORCE)
    public R banned(@RequestBody TokenDto tokenDto) {

        for (String token : tokenDto.getTokens()) {
            String s = stringRedisTemplate.opsForValue().get(LOGIN_USER + token);
            if (StringUtils.isBlank(s)) {
                return R.fail("用户未登录");
            }
            LoginUser loginUser = JSON.parseObject(s, LoginUser.class);
            User user = loginUser.getUser();
            LambdaUpdateWrapper<User> lqw = new LambdaUpdateWrapper<User>().set(User::getStatus, 0).eq(User::getId, user.getId());
            userService.update(lqw);
            stringRedisTemplate.delete(LOGIN_USER + token);
            CustomWebSocketHandler.remove(token);
        }
        CustomWebSocketHandler.sendOnlineCount();
        return R.ok();
    }

    /**
     * 下线处理
     */
    @PostMapping("/offline")
    public R offline(TokenDto tokens) {
        for (String token : tokens.getTokens()) {
            CustomWebSocketHandler.remove(token);
        }
        return R.ok();

    }

    /**
     * 获取登录用户列表
     * @return
     */
    @GetMapping
    public R<List<LoginUser>> getBannedList() {
        List<LoginUser> list = new ArrayList<>();
        Set<String> sessionTokenList = CustomWebSocketHandler.getSessionTokenList();
        for (String s : sessionTokenList) {
            String s1 = stringRedisTemplate.opsForValue().get(LOGIN_USER + s);
            if (!StringUtils.isBlank(s1)) {
                LoginUser loginUser = JSON.parseObject(s1, LoginUser.class);
                loginUser.setToken(s);
                LoginLog one = loginLogService.getOne(new LambdaQueryWrapper<LoginLog>().eq(LoginLog::getToken, s));
                loginUser.setIp(one.getIp());
                loginUser.setLocation(one.getLocation());
                list.add(loginUser);
            }
        }
        return R.ok(list);
    }
}
