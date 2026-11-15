package com.oldthings.util;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private static String getDatabaseUrl() {
        // 1. Kiểm tra biến môi trường cấu hình tùy chỉnh
        String customPath = System.getenv("OLDTHINGS_DB_PATH");
        if (customPath != null && !customPath.trim().isEmpty()) {
            return "jdbc:sqlite:" + customPath.trim();
        }

        // 2. Tự động nhận diện thư mục Tomcat nếu đang chạy trong Tomcat
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase != null && !catalinaBase.trim().isEmpty()) {
            File tomcatDb = new File(catalinaBase, "oldthings.db");
            return "jdbc:sqlite:" + tomcatDb.getAbsolutePath().replace('\\', '/');
        }

        // 3. Kiểm tra file cơ sở dữ liệu mặc định đã có trên máy
        File defaultDb = new File("C:/apache-tomcat-10.1.61/oldthings.db");
        if (defaultDb.exists()) {
            return "jdbc:sqlite:" + defaultDb.getAbsolutePath().replace('\\', '/');
        }

        // 4. Fallback tại thư mục hiện tại của ứng dụng
        return "jdbc:sqlite:oldthings.db";
    }

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.sqlite.JDBC");
        return DriverManager.getConnection(getDatabaseUrl());
    }   
}