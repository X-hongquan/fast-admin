package com.chq.app.web.system.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.pojo.SysFile;
import com.chq.app.web.system.service.IFileService;
import com.chq.app.web.system.service.ISysFileService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayInputStream;
import java.io.IOException;

/**
 * 策略模式 文件下载
 */
@RestController
@RequestMapping("/file")
public class FileController {

    @Autowired
    @Qualifier(value = "sysFileServiceImpl")
    private IFileService sysFileService;

    @Autowired
    @Qualifier(value = "minioFileServiceImpl")
    private IFileService minioFileService;

    @GetMapping("/{fileName}")
    public void dbDownload(@PathVariable("fileName") String fileName, HttpServletResponse response) {
        //byte[] bytes = sysFileService.download(fileName, null);
        //
        byte[] bytes = minioFileService.download(fileName, null);
        try {
            response.getOutputStream().write(bytes);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


}
