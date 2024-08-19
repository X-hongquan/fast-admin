package com.chq.app;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.ByteArrayInputStream;

@AllArgsConstructor
@Data
public class FileObj {

    private byte[] bytes;
    private String fileName;

    public String getData() {
        return new String(bytes);
    }
}
