package com.chq.app.controller;

import com.chq.app.common.domain.R;
import com.chq.app.generator.ControllerBuilder;
import com.chq.app.generator.FileItem;
import com.chq.app.generator.TypeBuilder;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
@RequestMapping("/generate")
public class GeneratorController {

    @Resource
    private ControllerBuilder controllerBuilder;

    @Resource
    private TypeBuilder typeBuilder;

    @GetMapping("/type/js")
    public void exportType(HttpServletResponse response) throws IOException {
        StringBuilder build = typeBuilder.build();
        response.getWriter().write(build.toString());
    }

    @GetMapping("/api/js")
    public void exportZip(HttpServletResponse response) throws IOException {
        List<FileItem> fileItems = controllerBuilder.build();
        ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
        for (FileItem item : fileItems) {
            String fileName = item.getName();
            ZipEntry zipEntry = new ZipEntry(fileName);
            zos.putNextEntry(zipEntry);
            zos.write(item.getStr().getBytes());
            zos.closeEntry();
        }
        zos.close();
    }

    @GetMapping("/list")
    public R<List<FileItem>> list() {

        StringBuilder build = typeBuilder.build();
        List<FileItem> build1 = controllerBuilder.build();
        build1.addFirst(new FileItem(build.toString(), "dto.js"));
        return R.ok(build1);


    }


}
