package com.chq.app.controller;

import com.chq.app.common.annoation.AsyncTask;
import com.chq.app.common.async.FutureHolder;
import com.chq.app.common.enums.ExecuteType;
import com.chq.app.pojo.User;
import com.chq.app.service.ILoginLogService;
import com.chq.app.util.SpringUtils;
import com.chq.app.util.WebUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.net.Socket;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@RestController
@RequestMapping("/test")
public class TestController {


    @Autowired
    private ILoginLogService loginLogService;

    @PostMapping
    public void testLog(HttpServletRequest request) {
        loginLogService.recordLoginLog(new User().setUsername("wqeq"),"qweqw", WebUtils.getIp());
    }

    @GetMapping("weq")
    public String hello() {
        return "你好我们";
    }





}
