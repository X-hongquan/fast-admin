package com.chq.app.controller;

import com.chq.app.common.annoation.AsyncTask;
import com.chq.app.common.async.FutureHolder;
import com.chq.app.common.enums.ExecuteType;
import com.chq.app.util.SpringUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@RestController
@RequestMapping("/test")
public class TestController {


    @Autowired
    private RestTemplate restTemplate;
    @GetMapping("/test")
    public Object test() {
        SpringUtils.getAopProxy(this).getInt();
        //遍历文件获取文件名
        int j= FutureHolder.get().get();
        return j;
    }





    @AsyncTask(title = "测试", executeType = ExecuteType.SYNC)
    public Integer getInt() {
        return 10;
    }


}
