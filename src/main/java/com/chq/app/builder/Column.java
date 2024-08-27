package com.chq.app.builder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class Column {
    private String name;
    private String type;
    private String comment;
    private String dbName;
    private String nullable;


    public String getType() {
        String s = switch (type) {
            //大写数据库类型
            case "TINYINT", "INT" -> "Integer";
            case "BIGINT" -> "Long";
            case "VARCHAR", "CHAR", "TEXT" -> "String";
            case "DECIMAL", "FLOAT", "DOUBLE" -> "BigDecimal";
            case "DATE", "TIME", "DATETIME", "TIMESTAMP" -> "LocalDateTime";
            case "BOOLEAN" -> "Boolean";
            default -> type;
        };
        return s;
    }

    public String getName() {
        return convertToLowerCaseCamelCase(dbName);
    }

    public static String convertToLowerCaseCamelCase(String fieldName) {
        // 使用正则表达式匹配下划线和后面的字母
        Pattern pattern = Pattern.compile("_(.)");
        Matcher matcher = pattern.matcher(fieldName);
        StringBuffer sb = new StringBuffer();

        // 替换匹配到的部分，将下划线后面的第一个字母转为大写
        while (matcher.find()) {
            matcher.appendReplacement(sb, matcher.group(1).toUpperCase());
        }
        matcher.appendTail(sb);

        return sb.toString();
    }
}
