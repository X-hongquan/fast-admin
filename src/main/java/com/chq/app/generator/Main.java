package com.chq.app.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {
        TypeBuilder typeBuilder = new TypeBuilder();
        StringBuilder build = typeBuilder.build();
        FileWriter fileWriter = new FileWriter("dto.js");
        fileWriter.write(build.toString());
        fileWriter.close();
        File api = new File("api");
        if (!api.exists()) {
            api.mkdir();
        }
        List<FileItem> build1 = new ControllerBuilder().build();
        for (FileItem fileItem : build1) {
            FileWriter fileWriter1 = new FileWriter(api.getAbsolutePath() + File.separator + fileItem.getName());
            fileWriter1.write(fileItem.getStr());
            fileWriter1.close();
        }

    }
}
