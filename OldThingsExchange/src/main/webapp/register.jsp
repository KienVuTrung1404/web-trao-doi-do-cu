<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - TRAO ĐỔI ĐỒ CŨ</title>
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
                <h2>Đăng Ký Tài Khoản</h2>
                <p>Tham gia cộng đồng Trao Đổi Đồ Cũ Sinh Viên PTIT</p>
            </div>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert-error">✕ <%= error %></div>
            <% } %>

            <form action="register" method="post" style="box-shadow: none; padding: 0; margin: 0; max-width: 100%; border: none;">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required placeholder="Nhập tên đăng nhập (viết liền)">
                </div>

                <div class="form-group">
                    <label for="email">Email sinh viên (dùng để khôi phục mật khẩu):</label>
                    <input type="email" id="email" name="email" placeholder="VD: student@ptit.edu.vn">
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Nhập lại mật khẩu">
                </div>

                <button type="submit" class="btn-submit">Đăng ký ngay</button>

                <p style="text-align: center; margin-top: 20px; font-size: 13.5px; color: var(--text-muted);">
                    Đã có tài khoản? <a href="login.jsp" style="color: var(--primary); font-weight: 700; text-decoration: none;">Đăng nhập ngay</a>
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