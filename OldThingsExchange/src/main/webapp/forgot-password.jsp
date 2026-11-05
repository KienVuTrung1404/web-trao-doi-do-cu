<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - TRAO ĐỔI ĐỒ CŨ</title>
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ</a>
        <nav>
            <a href="login.jsp">Đăng nhập</a>
            <a href="register.jsp">Đăng ký</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center;">
        <form action="forgot-password" method="post">
            <h2>Khôi phục mật khẩu</h2>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <p style="color: #dc2626; font-weight: bold; margin-bottom: 12px; font-size: 14px;"><%= error %></p>
            <% } %>

            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required placeholder="Nhập tên đăng nhập">

            <label for="email">Email đã đăng ký:</label>
            <input type="email" id="email" name="email" required placeholder="Nhập email khôi phục">

            <button type="submit">Gửi mã OTP qua Email</button>

            <p style="text-align: center; margin-top: 15px; font-size: 14px; color: #475569;">
                Nhớ lại mật khẩu? <a href="login.jsp" style="color: #2563eb; font-weight: bold; text-decoration: none;">Đăng nhập</a>
            </p>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ - Hệ thống trao đổi đồ cũ sinh viên PTIT.</p>
    </footer>

</body>
</html>