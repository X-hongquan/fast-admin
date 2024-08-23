package com.chq.app.controller;

import com.chq.app.generator.Builder;
import com.chq.app.generator.FileObj;
import com.chq.app.generator.GenerateDtoJs;
import com.chq.app.common.domain.R;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
@RequestMapping("/generate")
public class GeneratorController {

    @GetMapping("/type/{mode}")
    public void generateTypeJS(@PathVariable("mode") String mode, HttpServletResponse response) throws IOException {
        if ("ts".equals(mode)) {
            Builder builder = new Builder();
            response.getOutputStream().write(builder.builderType());
        } else {
            byte[] build = GenerateDtoJs.build();
            response.getOutputStream().write(build);
        }
    }

    @GetMapping("/api/{mode}")
    public void generateAPI(@PathVariable("mode") String mode, HttpServletResponse response) throws IOException {
        Builder builder = new Builder();
        List<FileObj> fileObjs = new ArrayList<>();
        builder.builderAPI(mode, fileObjs);
        ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
        for (FileObj fileObj : fileObjs) {
            String fileName = fileObj.getFileName();
            ZipEntry zipEntry = new ZipEntry(fileName);
            zos.putNextEntry(zipEntry);
            zos.write(fileObj.getBytes());
            zos.closeEntry();
        }
        zos.close();
    }

    @GetMapping("/list")
    public R<List<FileObj>> list() {
        List<FileObj> list = new ArrayList<>();
        Builder builder = new Builder();
        list.add(new FileObj(GenerateDtoJs.build(), "type.js"));
        builder.builderAPI("js",list);
        list.add(new FileObj(builder.builderType(), "type.d.ts"));
        builder.builderAPI("ts",list);
        return R.ok(list);
    }

}
