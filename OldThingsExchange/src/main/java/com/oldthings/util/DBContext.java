package com.oldthings.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    // File database SQLite sẽ tự động được tạo tại thư mục Tomcat
    private static final String URL = "jdbc:sqlite:C:/apache-tomcat-10.1.61/oldthings.db";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.sqlite.JDBC");
        return DriverManager.getConnection(URL);
    }   
}