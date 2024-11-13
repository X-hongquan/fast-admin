package com.chq.app.web.system.service.impl;

import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.common.annoation.AsyncTask;
import com.chq.app.web.system.pojo.LoginLog;
import com.chq.app.web.system.pojo.User;
import com.chq.app.web.system.service.ILoginLogService;
import com.chq.app.web.system.mapper.LoginLogMapper;
import com.chq.app.common.util.IpUtil;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.List;

/**
* @author ASUS
* @description 针对表【login_log】的数据库操作Service实现
* @createDate 2024-08-26 17:46:39
*/
@Service
public class LoginLogServiceImpl extends ServiceImpl<LoginLogMapper, LoginLog> implements ILoginLogService {

    @Resource
    private RestTemplate restTemplate;

    @AsyncTask(title = "记录登录日志")
    public void recordLoginLog(User u, String uuid,String ip) {
        boolean privateIp = IpUtil.isPrivateIp(ip);
        LoginLog loginLog = new LoginLog();
        loginLog.setIp(ip).
                setLoginTime(LocalDateTime.now())
                .setLoginUser(u.getUsername())
                .setToken(uuid);
        ;
        if (privateIp) {
            loginLog.setLocation("内网");
        } else {
            String s =
                    sendGetRequest("http://ip-api.com/json/" + ip + "?lang=zh-CN");
            if (StringUtils.isNotBlank(s)) {
                JSONObject jsonObject = JSONObject.parseObject(s);
                String o = (String) jsonObject.get("regionName");
                String o1 = (String) jsonObject.get("city");
                loginLog.setLocation(o + " " + o1);
            }
        }
        save(loginLog);
    }

    @Override
    public List<LoginLog> getList(LoginLog loginLog) {
        return  baseMapper.getList(loginLog);
    }


    private String sendGetRequest(String url) {
        // 创建HttpHeaders对象
        HttpHeaders headers = new HttpHeaders();
        // 设置请求头
        headers.add("User-Agent", "Mozilla/5.0");
        // 创建HttpEntity对象
        HttpEntity<String> entity = new HttpEntity<>("parameters", headers);
        // 发送GET请求
        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                String.class
        );

        return response.getBody();
    }
}




