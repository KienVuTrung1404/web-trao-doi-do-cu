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
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #F8FAFC; color: #1E293B; }
        
        header { background-color: #7A1E28; color: white; display: flex; justify-content: space-between; align-items: center; padding: 15px 40px; }
        header .logo { color: white; font-size: 18px; font-weight: bold; text-decoration: none; }
        header nav a { color: white; text-decoration: none; font-size: 15px; margin-left: 20px; }

        .container { max-width: 550px; margin: 40px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); border: 1px solid #E2E8F0; }
        h2 { color: #7A1E28; margin-bottom: 25px; text-align: center; font-size: 22px; border-bottom: 2px solid #F1F5F9; padding-bottom: 10px; }

        .section-box { background: #F8FAFC; padding: 20px; border-radius: 10px; border: 1px solid #E2E8F0; margin-bottom: 20px; }
        .section-title { font-weight: bold; color: #475569; margin-bottom: 12px; font-size: 15px; }

        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; margin-bottom: 6px; font-size: 13px; font-weight: 600; color: #64748B; }
        .form-group input { width: 100%; padding: 10px 12px; border: 1px solid #CBD5E1; border-radius: 6px; font-size: 14px; outline: none; }
        .form-group input:focus { border-color: #7A1E28; }

        .btn-submit { background-color: #7A1E28; color: white; border: none; padding: 9px 16px; font-size: 14px; font-weight: bold; border-radius: 6px; cursor: pointer; float: right; margin-top: 5px; }
        .btn-submit:hover { background-color: #5c161e; }
        .clear { clear: both; }

        .alert-success { background: #DCFCE7; color: #166534; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-weight: 500; font-size: 14px; }
        .alert-error { background: #FEE2E2; color: #991B1B; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-weight: 500; font-size: 14px; }
    </style>
</head>
<body>

    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ PTIT</a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="my-items">Tin của tôi</a>
            <a href="logout" style="color: #FFD700; font-weight: bold;">Đăng xuất</a>
        </nav>
    </header>

    <div class="container">
        <h2>Chỉnh Sửa Thông Tin Cá Nhân</h2>

        <% if (message != null) { %>
            <div class="alert-success">✓ <%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert-error">✕ <%= error %></div>
        <% } %>

        <!-- Form 1: Cập nhật Tên hiển thị -->
        <div class="section-box">
            <div class="section-title">1. Đổi tên người dùng / Tên sinh viên</div>
            <form action="profile" method="post">
                <input type="hidden" name="action" value="updateUsername">
                <div class="form-group">
                    <label>Tên hiển thị hiện tại</label>
                    <input type="text" name="username" value="<%= user.getUsername() != null ? user.getUsername() : "" %>" required>
                </div>
                <button type="submit" class="btn-submit">Lưu tên mới</button>
                <div class="clear"></div>
            </form>
        </div>

        <!-- Form 2: Cập nhật Email -->
        <div class="section-box">
            <div class="section-title">2. Đổi địa chỉ Email</div>
            <form action="profile" method="post">
                <input type="hidden" name="action" value="updateEmail">
                <div class="form-group">
                    <label>Email liên hệ</label>
                    <input type="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
                </div>
                <button type="submit" class="btn-submit">Lưu Email mới</button>
                <div class="clear"></div>
            </form>
        </div>
    </div>

</body>
</html>