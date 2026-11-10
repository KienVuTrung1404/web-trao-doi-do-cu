package com.oldthings.dao;

import com.oldthings.model.User;
import com.oldthings.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // 1. Kiểm tra đăng nhập (checkLogin & login)
    public User checkLogin(String username, String password) {
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, username);
            pstmt.setString(3, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public User login(String username, String password) {
        return checkLogin(username, password);
    }

    // 2. Lấy thông tin người dùng theo Email
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Lấy thông tin người dùng theo Username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Lấy thông tin người dùng theo ID
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 5. Lấy danh sách tất cả người dùng (Dành cho Admin)
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 6. Đăng ký tài khoản (registerUser & register)
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users(username, email, password, role) VALUES(?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getRole() != null ? user.getRole() : "USER");
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean register(User user) {
        return registerUser(user);
    }

    // 7. Tự động Đăng ký / Đăng nhập bằng Google Auth 1 chạm
    public User registerGoogleUser(String name, String email) {
        User existingUser = getUserByEmail(email);
        if (existingUser != null) {
            return existingUser;
        }

        String baseUsername = email.split("@")[0];
        String username = baseUsername;

        int count = 1;
        while (getUserByUsername(username) != null) {
            username = baseUsername + count;
            count++;
        }

        String sql = "INSERT INTO users(username, email, password, role) VALUES(?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, "GOOGLE_AUTH");
            pstmt.setString(4, "USER");
            int affected = pstmt.executeUpdate();

            if (affected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    return new User(id, username, email, "GOOGLE_AUTH", "USER");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return getUserByEmail(email);
    }

    // 8. Cập nhật thông tin Profile
    public boolean updateEmail(int userId, String newEmail) {
    // Bổ sung kiểm tra email đã tồn tại hay chưa
    User existing = getUserByEmail(newEmail);
    if (existing != null && existing.getId() != userId) {
        return false; // Email đã được sử dụng bởi người khác
    }

    String sql = "UPDATE users SET email = ? WHERE id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, newEmail);
        pstmt.setInt(2, userId);
        return pstmt.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    public boolean checkOldPassword(int userId, String oldPassword) {
        String sql = "SELECT * FROM users WHERE id = ? AND password = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setString(2, oldPassword);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 9. Quên mật khẩu
    public boolean resetPassword(String arg1, String arg2, String arg3) {
        String newPass = (arg3 != null && !arg3.isEmpty()) ? arg3 : arg2;
        String target = (arg1 != null && !arg1.isEmpty()) ? arg1 : arg2;
        String sql = "UPDATE users SET password = ? WHERE email = ? OR username = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newPass);
            pstmt.setString(2, target);
            pstmt.setString(3, target);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 10. Phân quyền Admin
    public boolean makeAdmin(int id) {
        String sql = "UPDATE users SET role = 'ADMIN' WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm mapResultSet
    private User mapUser(ResultSet rs) throws Exception {
        int id = rs.getInt("id");
        String username = rs.getString("username");
        String email = rs.getString("email");
        String password = rs.getString("password");
        
        String role = "USER";
        try {
            role = rs.getString("role");
            if (role == null || role.isEmpty()) {
                role = "USER";
            }
        } catch (Exception ignored) {}

        return new User(id, username, email, password, role);
    }
    // Cập nhật tên đăng nhập người dùng
    public boolean updateUsername(int userId, String newUsername) {
        User existing = getUserByUsername(newUsername);
        if (existing != null && existing.getId() != userId) {
            return false; // Tên người dùng đã được sử dụng bởi người khác
        }
        String sql = "UPDATE users SET username = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newUsername);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}