package com.chq.app.builder;


import com.chq.app.web.system.pojo.Menu;
import org.apache.commons.lang3.StringUtils;

import java.sql.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 *
 */

public class TableInfoFetcher {

    /**
     * 获取指定表的元数据，包括字段名、字段类型和字段注释（如果可用）。
     *
     * @param connection 数据库连接
     * @param tableName  表名
     * @return 字段信息的列表
     */
    public static ResultSet getTableColumns(Connection connection, String tableName) throws SQLException {
        DatabaseMetaData metaData = connection.getMetaData();
        ResultSet columns = metaData.getColumns(null, null, tableName, null);
        return columns;
    }

    private static ResultSet getTableComment(Connection connection, String tableName) throws SQLException {
        String sql = "SELECT TABLE_COMMENT "
                + "FROM INFORMATION_SCHEMA.TABLES "
                + "WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?";
        PreparedStatement pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, "vjs");
        pstmt.setString(2, tableName);
        return pstmt.executeQuery();
    }

    public static void main(String[] args) {
        DatabaseInfoFetcher.genMap();

        String absPath = "D:\\IdeaProject\\fast-admin\\src\\main\\java\\com\\chq\\app\\";
        String frontAbsPath = "D:\\IdeaProject\\fast-admin\\admin-ui\\src\\";
        Config config = new Config();
        config
                .setCommonPackage("com.chq.app")
                .setTableName("dept")
                .setAuthor("神")
                .setJdbcUrl("jdbc:mysql://192.168.102.129:3306/vjs?")
                .setUsername("root")
                .setPassword("123456")
                .setPackageName("com.chq.app.web.system")
                .setAbsPath(absPath)
                .setFrontAbsPath(frontAbsPath)
                .setModule("system/");


        Connection connection = null;
        ResultSet rs = null;

        try {
            TableInfo tableInfo = new TableInfo();


            Class<?> aClass = Class.forName("com.mysql.cj.jdbc.Driver");
            // 假设已经建立好数据库连接
            connection = DriverManager.getConnection(config.getJdbcUrl(), config.getUsername(), config.getPassword()); // 这里替换为你的数据库连接代码

            String tableName = config.getTableName(); // 替换为你要查询的表名
            tableInfo.setTableName(tableName);
            //设置输出目录
            String module = config.getModule();


            tableInfo.setApiOutputPath("admin-ui/src/api/" + module + FreeMarkerBuilder.conventParamsName(tableName) + ".js");
            tableInfo.setViewsOutputPath("admin-ui/src/views/" + module + FreeMarkerBuilder.conventParamsName(tableName) + "/" + "index.vue");
            String backendDir = "src/main/java/com/chq/app/web/" + module;
            tableInfo.setPojoOutputPath(backendDir + "/pojo/" + FreeMarkerBuilder.convertToClassName(tableName) + ".java");
            tableInfo.setMapperOutputPath(backendDir + "/mapper/" + FreeMarkerBuilder.convertToClassName(tableName) + "Mapper.java");
            tableInfo.setMapperXmlOutputPath("src/main/resources/mapper/" + module + FreeMarkerBuilder.convertToClassName(tableName) + "Mapper.xml");
            tableInfo.setServiceOutputPath(backendDir + "/service/I" + FreeMarkerBuilder.convertToClassName(tableName) + "Service.java");
            tableInfo.setServiceImplOutputPath(backendDir + "/service/impl/" + FreeMarkerBuilder.convertToClassName(tableName) + "ServiceImpl.java");
            tableInfo.setControllerOutputPath(backendDir + "/controller/" + FreeMarkerBuilder.convertToClassName(tableName) + "Controller.java");


            // 获取表的元数据
            rs = getTableColumns(connection, tableName);
            ResultSet tableResult = getTableComment(connection, tableName);
            if (tableResult.next()) {
                String tableComment = tableResult.getString("TABLE_COMMENT");
                tableInfo.setComment(tableComment);
            }

            // 打印表的元数据
            while (rs.next()) {
                String columnName = rs.getString("COLUMN_NAME");
                String columnType = rs.getString("TYPE_NAME");
                String remarks = rs.getString("REMARKS"); // 字段注释
                String nullable = rs.getString("IS_NULLABLE");
                Column column = new Column();
                column.setCompleteComment(remarks);
                column.setComment(remarks);
                if (remarks.contains(":")) {
                    String trim = StringUtils.substringBefore(remarks, "(").trim();
                    column.setSelect("y");
                    column.setComment(trim);
                } else if (remarks.contains("search")) {
                    column.setSearch("y");
                    String trim = remarks.replace("search", "").trim();
                    column.setComment(trim);
                }
                if (columnName.contains("time")) {
                    System.out.println("disabled");
                    column.setDisabled("disabled");
                } else if (columnName.contains("img") || columnName.contains("images") || columnName.contains("avatar") || columnName.contains("picture")) {
                    column.setImg("y");
                }

                column.setType(columnType).setDbName(columnName).setNullable(nullable);
                tableInfo.getColumns().add(column);
            }
            setDictLabel(tableInfo);
            List<Column> columns = tableInfo.getColumns();
            for (Column column : columns) {
                if ("y".equals(column.getImg()))
                    System.out.println(column.getName());
            }
            FreeMarkerBuilder.build(tableInfo, config);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static void setDictLabel(TableInfo tableInfo) {
        Set<Column> column = new HashSet<>();
        for (Column c : tableInfo.getColumns()) {
            if ("y".equals(c.getSelect())) {
                column.add(c);
            }
        }
        if (column.isEmpty())
            setDictLabel(null);
        else {
            StringBuilder sb = new StringBuilder();
            for (Column one : column) {
                sb.append(tableInfo.getTableName()).append("$").append(one.getDbName()).append("Map").append(",");
            }
            sb.deleteCharAt(sb.length() - 1);
            String content = sb.toString();
            String format = "import {%s} from %s";
            String dictLabel = String.format(format, content, "'@/utils/dictMap.js'");
            System.out.println(dictLabel);
            tableInfo.setDictLabel(dictLabel);
        }
    }
}