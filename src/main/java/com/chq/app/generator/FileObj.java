package com.chq.app.generator;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class FileObj {

    private byte[] bytes;
    private String fileName;

    public String getData() {
        return new String(bytes);
    }
}
