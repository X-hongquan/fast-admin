package com.chq.app.controller;

import com.chq.app.common.annoation.PreAuth;
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
@RequestMapping("/generator")
public class GeneratorController {

    @Resource
    private ControllerBuilder controllerBuilder;

    @Resource
    private TypeBuilder typeBuilder;

    @GetMapping("/type/js")
    @PreAuth(value = "system:generator:export", description = "导出生成代码权限")
    public void exportType(HttpServletResponse response) throws IOException {
        StringBuilder build = typeBuilder.buildJS();
        response.getWriter().write(build.toString());
    }

    @GetMapping("/api/js")
    @PreAuth(value = "system:generator:export", description = "导出生成代码权限")
    public void exportZip(HttpServletResponse response) throws IOException {
        List<FileItem> fileItems = controllerBuilder.buildJS();
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
    @PreAuth(value = "system:generator:query", description = "查询生成代码权限")
    public R<List<FileItem>> list() {
        StringBuilder build = typeBuilder.buildJS();
        List<FileItem> build1 = controllerBuilder.buildJS();
        build1.addFirst(new FileItem(build.toString(), "dto.js"));
        StringBuilder builder = typeBuilder.buildTS();
        build1.add(new FileItem(builder.toString(), "model.ts"));
        List<FileItem> fileItems = controllerBuilder.buildTS();
        for (FileItem item : fileItems) {
            build1.add(item);
        }
        return R.ok(build1);


    }


}
