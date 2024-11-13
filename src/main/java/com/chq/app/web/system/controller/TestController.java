package com.chq.app.web.system.controller;

import com.chq.app.web.system.pojo.User;
import com.chq.app.web.system.service.ILoginLogService;
import com.chq.app.common.util.WebUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test")
public class TestController {


    @Autowired
    private ILoginLogService loginLogService;

    @PostMapping
    public void testLog(HttpServletRequest request) {
        loginLogService.recordLoginLog(new User().setUsername("wqeq"),"qweqw", WebUtils.getIp());
    }

    @GetMapping("/weq")
    public String hello() {
        return "你好我们";
    }

    /**
     * 测试@RequstParam
     */
    @RequestMapping("/test")
    public void test(@RequestParam("name") String name) {
        System.out.println(name);
    }





}
