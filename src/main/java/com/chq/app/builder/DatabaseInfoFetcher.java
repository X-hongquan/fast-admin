package com.chq.app.builder;

import org.apache.commons.lang3.StringUtils;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 生成字典信息
 */
public class DatabaseInfoFetcher {

    public static void main(String[] args) {
        String url = "jdbc:mysql://192.168.102.129:3306/vjs?nullCatalogMeansCurrent=true";
        String user = "root";
        String password = "123456";
        String schema = "vjs";
        StringBuilder sb = new StringBuilder();
        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            DatabaseMetaData metaData = connection.getMetaData();

            // 获取指定 schema 下的所有表
            ResultSet tables = metaData.getTables(null, "vjs", "%", new String[]{"TABLE"});
            while (tables.next()) {
                String tableName = tables.getString("TABLE_NAME");


                // 获取表的字段信息和注释
                ResultSet columns = metaData.getColumns(null, schema, tableName, "%");

                while (columns.next()) {
                    String columnName = columns.getString("COLUMN_NAME");
                    String columnType = columns.getString("TYPE_NAME");
                    int columnSize = columns.getInt("COLUMN_SIZE");

                    String pattern
                           ="/**\n" +
                            " * %s字典\n" +
                            " */\n" +
                            "export const %s$%sMap = {\n";
                    String columnComment = columns.getString("REMARKS"); // 获取注释
                   if (StringUtils.isNotBlank(columnComment)&&columnComment.contains("(")) {

                       String trim = columnComment.trim();
                       String[] split = StringUtils.split(trim, "(");
                       String first = split[0].trim();
                       String format = String.format(pattern, first, tableName, columnName);
                       String desc= split[1].substring(0, split[1].length()-1);
                       String[] items=desc.split(" ");
                       sb.append(format);
                       for (String item : items) {
                           String substring = item.substring(1);
                           sb.append("  ").append(item.charAt(0)).append(": '").append(substring).append("',").append("\n");
                       }
                       sb.deleteCharAt(sb.length()-2);
                       sb.append("}\n");
                   }

                }
                // 关闭列结果集
                columns.close();
            }
            try (FileWriter fileWriter= new FileWriter("D:\\IdeaProject\\fast-admin\\admin-ui\\src\\utils\\dictMap.js")){
                fileWriter.write(sb.toString());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            // 关闭表结果集
            tables.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}