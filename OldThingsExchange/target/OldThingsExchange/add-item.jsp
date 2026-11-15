<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oldthings.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng tin mới - TRAO ĐỔI ĐỒ CŨ</title>
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
            <a href="my-items">Tin của tôi</a>
            <a href="profile" class="user-pill">👤 <%= user.getUsername() %></a>
            <a href="logout" class="link-logout">Đăng xuất</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center;">
        <div class="form-card form-card-wide">
            <div class="form-header">
                <h2>Đăng Tin Trao Đổi Đồ Mới</h2>
                <p>Chia sẻ món đồ bạn không dùng tới cho cộng đồng sinh viên PTIT</p>
            </div>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert-error">✕ <%= error %></div>
            <% } %>

            <form action="add-item" method="post" enctype="multipart/form-data" style="box-shadow: none; padding: 0; max-width: 100%; border: none;">
                <div class="form-group">
                    <label for="title">Tên món đồ / Tiêu đề tin:</label>
                    <input type="text" id="title" name="title" required placeholder="VD: Giáo trình Cơ sở dữ liệu PTIT">
                </div>

                <div class="form-group">
                    <label for="category">Danh mục sản phẩm:</label>
                    <select id="category" name="category" required>
                        <option value="Sách & Giáo trình">Sách & Giáo trình</option>
                        <option value="Đồ điện tử">Đồ điện tử</option>
                        <option value="Thể thao">Thể thao</option>
                        <option value="Đồ gia dụng">Đồ gia dụng</option>
                        <option value="Khác">Khác</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại / Zalo liên hệ:</label>
                    <input type="tel" id="phone" name="phone" required placeholder="VD: 0987654321">
                </div>

                <div class="form-group">
                    <label for="description">Mô tả tình trạng & nhu cầu đổi:</label>
                    <textarea id="description" name="description" rows="4" required placeholder="Mô tả chi tiết tình trạng đồ (còn mới bao nhiêu %) và món đồ bạn muốn nhận lại..."></textarea>
                </div>

                <div class="form-group">
                    <label for="location">Khu vực / Địa chỉ giao dịch:</label>
                    <input type="text" id="location" name="location" required placeholder="VD: KTX PTIT, Cơ sở Hà Đông, Hà Nội">
                </div>

                <div class="form-group">
                    <label for="imageFile">Ảnh chụp món đồ (tuỳ chọn):</label>
                    <input type="file" id="imageFile" name="imageFile" accept="image/*" style="padding: 8px 0; border: none; background: transparent;">
                </div>

                <button type="submit" class="btn-submit">Đăng tin ngay</button>
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