<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oldthings.model.User" %>
<%@ page import="com.oldthings.model.Item" %>
<%
    User user = (User) session.getAttribute("user");
    Item item = (Item) request.getAttribute("item");
    if (user == null || item == null) {
        response.sendRedirect("my-items");
        return;
    }
    String[] categories = {"Sách & Giáo trình", "Đồ điện tử", "Thể thao", "Đồ gia dụng", "Khác"};
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa tin đăng - TRAO ĐỔI ĐỒ CŨ</title>
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
                <h2>Chỉnh Sửa Tin Đăng</h2>
                <p>Cập nhật thông tin chi tiết về món đồ trao đổi của bạn</p>
            </div>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert-error">✕ <%= error %></div>
            <% } %>

            <form action="edit-item" method="post" enctype="multipart/form-data" style="box-shadow: none; padding: 0; max-width: 100%; border: none;">
                <input type="hidden" name="id" value="<%= item.getId() %>">

                <div class="form-group">
                    <label for="title">Tên món đồ / Tiêu đề tin:</label>
                    <input type="text" id="title" name="title" required value="<%= item.getTitle() %>">
                </div>

                <div class="form-group">
                    <label for="category">Danh mục sản phẩm:</label>
                    <select id="category" name="category" required>
                        <% for (String cat : categories) { %>
                            <option value="<%= cat %>" <%= cat.equals(item.getCategory()) ? "selected" : "" %>><%= cat %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại / Zalo liên hệ:</label>
                    <input type="tel" id="phone" name="phone" required value="<%= item.getPhone() != null ? item.getPhone() : "" %>">
                </div>

                <div class="form-group">
                    <label for="description">Mô tả tình trạng & nhu cầu đổi:</label>
                    <textarea id="description" name="description" rows="4" required><%= item.getDescription() %></textarea>
                </div>

                <div class="form-group">
                    <label for="location">Khu vực / Địa chỉ giao dịch:</label>
                    <input type="text" id="location" name="location" required value="<%= item.getLocation() %>">
                </div>

                <div class="form-group">
                    <label for="imageFile">Thay đổi ảnh món đồ (để trống nếu giữ ảnh hiện tại):</label>
                    <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                        <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 10px;">
                            <img src="<%= item.getImageUrl() %>" style="width: 54px; height: 54px; object-fit: cover; border-radius: var(--radius-sm); border: 1px solid var(--border);" onerror="this.src='images/no-image.png';">
                            <span style="font-size: 13px; color: var(--text-muted);">Ảnh đang hiển thị</span>
                        </div>
                    <% } %>
                    <input type="file" id="imageFile" name="imageFile" accept="image/*" style="padding: 8px 0; border: none; background: transparent;">
                </div>

                <div style="display: flex; gap: 12px; margin-top: 10px;">
                    <button type="submit" class="btn-submit" style="flex: 1; margin-top: 0;">Lưu thay đổi</button>
                    <a href="my-items" class="btn btn-secondary" style="padding: 11px 20px;">Hủy</a>
                </div>
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