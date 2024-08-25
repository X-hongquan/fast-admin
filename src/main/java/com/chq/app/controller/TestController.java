package com.chq.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@RestController
public class TestController {

    @GetMapping("/test")
    public Object test() {
        URL url = TestController.class.getClassLoader().getResource("com/chq/app");
        String file = url.getFile();
        File file1 = new File(file);
        //遍历文件获取文件名
        List<String> strings =new ArrayList<>();
        for (File file2 : file1.listFiles()) {
            strings.add(file2.getName());
        }
        return strings;
    }
}
