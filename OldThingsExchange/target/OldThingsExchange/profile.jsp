<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oldthings.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Cá Nhân - PTIT Exchange</title>
    <link rel="icon" type="image/jpeg" href="images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">
            <span class="logo-badge">PTIT</span>
            <span>TRAO ĐỔI ĐỒ CŨ</span>
        </a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="add-item.jsp" class="btn-header-post">+ Đăng tin mới</a>
            <a href="my-items">Tin của tôi</a>
            <a href="logout" class="link-logout">Đăng xuất</a>
        </nav>
    </header>

    <div class="container" style="max-width: 620px;">
        <!-- User Summary Card -->
        <div style="background: var(--bg-card); border-radius: var(--radius-lg); border: 1px solid var(--border); padding: 24px; margin-bottom: 24px; box-shadow: var(--shadow-sm); display: flex; align-items: center; gap: 20px;">
            <div style="width: 64px; height: 64px; border-radius: 50%; background: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 26px; font-weight: 800; border: 2px solid var(--primary-border);">
                <%= user.getUsername() != null && !user.getUsername().isEmpty() ? user.getUsername().substring(0, 1).toUpperCase() : "U" %>
            </div>
            <div>
                <h2 style="font-size: 20px; font-weight: 800; color: var(--text-main); margin-bottom: 4px;"><%= user.getUsername() %></h2>
                <p style="font-size: 13.5px; color: var(--text-muted); margin-bottom: 6px;"><%= user.getEmail() != null ? user.getEmail() : "" %></p>
                <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
                    <span class="badge" style="background: #FEE2E2; color: #991B1B;">QUẢN TRỊ VIÊN HỆ THỐNG</span>
                <% } else { %>
                    <span class="badge" style="background: #E2E8F0; color: #475569;">SINH VIÊN PTIT</span>
                <% } %>
            </div>
        </div>

        <% if (message != null) { %>
            <div class="alert-success">✓ <%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert-error">✕ <%= error %></div>
        <% } %>

        <!-- Form 1: Cập nhật Tên hiển thị -->
        <div class="profile-section">
            <div class="profile-section-title">
                <span>👤</span> 1. Đổi tên hiển thị / Tên sinh viên
            </div>
            <form action="profile" method="post" style="box-shadow: none; padding: 0; max-width: 100%; border: none; background: transparent;">
                <input type="hidden" name="action" value="updateUsername">
                <div class="form-group">
                    <label>Tên hiển thị hiện tại:</label>
                    <input type="text" name="username" value="<%= user.getUsername() != null ? user.getUsername() : "" %>" required>
                </div>
                <div style="display: flex; justify-content: flex-end;">
                    <button type="submit" class="btn" style="padding: 9px 18px;">Lưu tên mới</button>
                </div>
            </form>
        </div>

        <!-- Form 2: Cập nhật Email -->
        <div class="profile-section">
            <div class="profile-section-title">
                <span>✉️</span> 2. Đổi địa chỉ Email
            </div>
            <form action="profile" method="post" style="box-shadow: none; padding: 0; max-width: 100%; border: none; background: transparent;">
                <input type="hidden" name="action" value="updateEmail">
                <div class="form-group">
                    <label>Email liên hệ:</label>
                    <input type="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
                </div>
                <div style="display: flex; justify-content: flex-end;">
                    <button type="submit" class="btn" style="padding: 9px 18px;">Lưu Email mới</button>
                </div>
            </form>
        </div>

        <!-- Form 3: Đổi Mật khẩu -->
        <div class="profile-section">
            <div class="profile-section-title">
                <span>🔒</span> 3. Đổi mật khẩu tài khoản
            </div>
            <form action="profile" method="post" style="box-shadow: none; padding: 0; max-width: 100%; border: none; background: transparent;">
                <input type="hidden" name="action" value="changePassword">
                <% boolean isGoogleUser = "GOOGLE_AUTH".equals(user.getPassword()); %>
                <% if (!isGoogleUser) { %>
                    <div class="form-group">
                        <label>Mật khẩu hiện tại:</label>
                        <input type="password" name="oldPassword" placeholder="Nhập mật khẩu đang dùng" required>
                    </div>
                <% } else { %>
                    <p style="font-size: 13px; color: #0284C7; margin-bottom: 12px; background: #E0F2FE; padding: 9px 14px; border-radius: var(--radius-sm);">
                        ℹ️ Tài khoản đăng nhập qua Google. Bạn có thể thiết lập mật khẩu riêng để đăng nhập bằng tên người dùng.
                    </p>
                <% } %>
                <div class="form-group">
                    <label>Mật khẩu mới:</label>
                    <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>
                <div class="form-group">
                    <label>Xác nhận mật khẩu mới:</label>
                    <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                </div>
                <div style="display: flex; justify-content: flex-end;">
                    <button type="submit" class="btn" style="padding: 9px 18px;">Cập nhật mật khẩu</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>
</html>