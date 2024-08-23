package com.chq.app.generator;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class Example {
    public static void main(String[] args) throws IOException {
        Builder builder = new Builder();
        Path path = Paths.get("output");
        if (!Files.exists(path))
            Files.createDirectories(path);
        ZipOutputStream zos = new ZipOutputStream(Files.newOutputStream(path.resolve("api.zip")));
        List<FileObj> fileObjs = new ArrayList<>();
        builder.builderAPI("js", fileObjs);
        for (FileObj fileObj : fileObjs) {
            ZipEntry zipEntry = new ZipEntry(fileObj.getFileName()+".js");
            zos.putNextEntry(zipEntry);
            zos.write(fileObj.getBytes());
            zos.closeEntry();
        }
        zos.close();

    }
}
