package com.chq.app.builder;



import java.sql.*;


/**
 *
 */

public class TableInfoFetcher {

    /**
     * 获取指定表的元数据，包括字段名、字段类型和字段注释（如果可用）。
     *
     * @param connection 数据库连接
     * @param tableName 表名
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
        Config config = new Config();
        config
                .setTableName("operation_log")
                .setAuthor("chq")
                .setJdbcUrl("jdbc:mysql://192.168.102.129:3306/vjs?")
                .setUsername("root")
                .setPassword("123456")
                .setPackageName("com.chq.app")
                .setAbsPath("D:\\IdeaProject\\fast-admin\\src\\main\\java\\com\\chq\\app\\")
                .setFrontAbsPath("D:\\IdeaProject\\fast-admin\\admin-ui\\src\\");


        Connection connection = null;
        ResultSet rs = null;

        try {
            TableInfo tableInfo = new TableInfo();
            Class<?> aClass = Class.forName("com.mysql.cj.jdbc.Driver");
            // 假设已经建立好数据库连接
            connection = DriverManager.getConnection(config.getJdbcUrl(),config.getUsername(),config.getPassword()); // 这里替换为你的数据库连接代码

            String tableName = config.getTableName(); // 替换为你要查询的表名
            tableInfo.setTableName(tableName);
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
                column.setType(columnType).setDbName(columnName).setComment(remarks).setNullable(nullable);
                tableInfo.getColumns().add(column);
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
}