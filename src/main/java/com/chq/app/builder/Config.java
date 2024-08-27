package com.chq.app.builder;

import lombok.Data;
import lombok.experimental.Accessors;

@Accessors(chain = true)
@Data
public class Config {
    private String tableName;
    private String packageName;
    private String author;
    private String moduleName;
    private String absPath;
    private String jdbcUrl;
    private String username;
    private String password;
    private String frontAbsPath;
}
