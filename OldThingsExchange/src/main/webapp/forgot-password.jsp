<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - TRAO ĐỔI ĐỒ CŨ</title>
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
            <a href="login.jsp" class="btn-header-post">Đăng nhập</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 70vh; padding: 30px 15px;">
        <div class="form-card">
            <div class="form-header">
                <h2>Khôi Phục Mật Khẩu</h2>
                <p>Xác thực tên đăng nhập và email để đặt lại mật khẩu mới</p>
            </div>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert-error">✕ <%= error %></div>
            <% } %>

            <form action="forgot-password" method="post" style="box-shadow: none; padding: 0; margin: 0; max-width: 100%; border: none;">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required placeholder="Nhập tên đăng nhập">
                </div>

                <div class="form-group">
                    <label for="email">Email đã đăng ký:</label>
                    <input type="email" id="email" name="email" required placeholder="Nhập email khôi phục của tài khoản">
                </div>

                <div class="form-group">
                    <label for="newPassword">Mật khẩu mới:</label>
                    <input type="password" id="newPassword" name="newPassword" required placeholder="Nhập mật khẩu mới">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Nhập lại mật khẩu mới">
                </div>

                <button type="submit" class="btn-submit">Đặt lại mật khẩu</button>

                <p style="text-align: center; margin-top: 20px; font-size: 13.5px; color: var(--text-muted);">
                    Nhớ lại mật khẩu? <a href="login.jsp" style="color: var(--primary); font-weight: 700; text-decoration: none;">Đăng nhập</a>
                </p>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>

</body>
</html>