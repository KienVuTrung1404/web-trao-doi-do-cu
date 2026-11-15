<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.oldthings.model.Item" %>
<%@ page import="com.oldthings.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<Item> items = (List<Item>) request.getAttribute("items");
    if (items == null) {
        response.sendRedirect("index");
        return;
    }
    String keyword = (String) request.getAttribute("keyword");
    String category = (String) request.getAttribute("category");
    if (keyword == null) keyword = "";
    if (category == null) category = "Tất cả";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Trao Đổi Đồ Cũ PTIT</title>
    <link rel="icon" type="image/jpeg" href="images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!-- Header -->
    <header>
        <a href="index" class="logo">
            <span class="logo-badge">PTIT</span>
            <span>TRAO ĐỔI ĐỒ CŨ</span>
        </a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="add-item.jsp" class="btn-header-post">+ Đăng tin mới</a>
            <% if (user != null) { %>
                <a href="my-items">Tin của tôi</a>
                
                <% 
                    List<String> adminEmails = java.util.Arrays.asList(
                        "trungkien.ptit@gmail.com",
                        "kien.vukien@ptit.edu.vn",
                        "kien43465@gmail.com"
                    );
                    String userEmail = user.getEmail() != null ? user.getEmail().toLowerCase().trim() : "";
                    boolean isAdmin = "ADMIN".equalsIgnoreCase(user.getRole()) || adminEmails.contains(userEmail);
                    
                    if (isAdmin) { 
                %>
                    <a href="admin" class="admin-badge-btn">⚙️ Quản trị</a>
                <% } %>

                <a href="profile" class="user-pill" title="Xem trang cá nhân">
                    👤 <%= user.getUsername() %>
                </a>
                <a href="logout" class="link-logout">Đăng xuất</a>
            <% } else { %>
                <a href="login.jsp" class="btn-header-post">Đăng nhập</a>
            <% } %>
        </nav>
    </header>

    <!-- Banner & Thanh tìm kiếm -->
    <div class="banner-section">
        <div class="banner-title">Hệ Thống Trao Đổi Đồ Cũ Sinh Viên PTIT</div>
        <div class="banner-subtitle">Nhanh chóng • Tiết kiệm • Tin cậy trong nội bộ Học viện</div>
        
        <div class="search-container">
            <form action="index" method="get" class="search-form">
                <span class="search-icon">🔍</span>
                <input type="text" name="keyword" class="search-input" placeholder="Tìm kiếm sách, giáo trình, đồ điện tử, đồ gia dụng..." value="<%= keyword %>">
                <input type="hidden" name="category" value="<%= category %>">
                <button type="submit" class="search-btn">Tìm kiếm</button>
            </form>
        </div>
    </div>

    <!-- Thanh danh mục -->
    <div class="category-bar">
        <% 
            String[] cats = {"Tất cả", "Sách & Giáo trình", "Đồ điện tử", "Thể thao", "Đồ gia dụng", "Khác"};
            for (String c : cats) {
                boolean isActive = category.equals(c);
        %>
            <a href="index?category=<%= java.net.URLEncoder.encode(c, "UTF-8") %>&keyword=<%= java.net.URLEncoder.encode(keyword, "UTF-8") %>" 
               class="category-btn <%= isActive ? "active" : "" %>"><%= c %></a>
        <% } %>
    </div>

    <div class="container" style="margin-top: 0;">
        <!-- Tiêu đề danh sách -->
        <div class="section-header">
            <h2>Tin đăng mới nhất</h2>
            <% if (keyword != null && !keyword.trim().isEmpty()) { %>
                <span style="font-size: 13.5px; color: var(--text-muted);">Kết quả cho: <b>"<%= keyword %>"</b> (<a href="index" style="color: var(--primary); text-decoration: underline;">Xóa tìm kiếm</a>)</span>
            <% } %>
        </div>

        <!-- Danh sách sản phẩm -->
        <div class="item-grid">
            <% if (items != null && !items.isEmpty()) { 
                for (Item item : items) { %>
                <a href="item-detail?id=<%= item.getId() %>" class="item-card">
                    <div class="item-img-wrapper">
                        <img src="<%= (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) ? item.getImageUrl() : "images/no-image.png" %>" 
                             alt="<%= item.getTitle() %>" class="item-img" onerror="this.src='images/no-image.png'">
                    </div>
                    <div class="item-info">
                        <span class="item-category-tag"><%= item.getCategory() %></span>
                        <div class="item-title"><%= item.getTitle() %></div>
                        <div class="item-exchange-badge">💬 Trao đổi / Đổi đồ</div>
                        <div class="item-meta">
                            <span>📍 <%= item.getLocation() != null && !item.getLocation().trim().isEmpty() ? item.getLocation() : "Hà Nội" %></span>
                            <span>🕒 <%= item.getCreatedAt() != null ? item.getCreatedAt().substring(0, Math.min(10, item.getCreatedAt().length())) : "" %></span>
                        </div>
                    </div>
                </a>
            <% }} else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">📦</div>
                    <h3>Chưa tìm thấy món đồ phù hợp</h3>
                    <p>Thử tìm kiếm với từ khóa khác hoặc chuyển danh mục "Tất cả".</p>
                    <a href="index" class="btn btn-secondary">Xem tất cả tin đăng</a>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>

</body>
</html>