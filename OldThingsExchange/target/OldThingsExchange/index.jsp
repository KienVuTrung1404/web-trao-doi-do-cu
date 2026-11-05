<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oldthings.model.Item" %>
<%@ page import="com.oldthings.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<Item> items = (List<Item>) request.getAttribute("items");
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
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F8FAFC;
            color: #1E293B;
        }
        /* Header chuẩn PTIT */
        header {
            background-color: #7A1E28;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        header .logo {
            color: white;
            font-size: 20px;
            font-weight: bold;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        header nav {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        header nav a {
            color: white;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: opacity 0.2s;
        }
        header nav a:hover {
            opacity: 0.8;
        }
        /* Tên người dùng có thể nhấn để mở trang hồ sơ */
        header nav .profile-link {
            color: #FFD700;
            font-weight: bold;
            text-decoration: none;
        }
        header nav .profile-link:hover {
            color: #FFFFFF;
            text-decoration: underline;
        }

        /* Banner PTIT gọn gàng, cân đối */
        .banner-section {
            background: linear-gradient(135deg, #7A1E28 0%, #4a1016 100%);
            color: white;
            text-align: center;
            padding: 40px 20px 30px 20px;
        }
        .banner-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .banner-subtitle {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        /* Thanh tìm kiếm */
        .search-container {
            max-width: 650px;
            margin: 0 auto;
            padding: 0 15px;
        }
        .search-form {
            background: white;
            padding: 6px;
            border-radius: 50px;
            display: flex;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .search-input {
            flex: 1;
            border: none;
            padding: 12px 20px;
            font-size: 15px;
            outline: none;
            border-radius: 50px;
            background: transparent;
        }
        .search-btn {
            background-color: #7A1E28;
            color: white;
            border: none;
            padding: 10px 28px;
            border-radius: 50px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .search-btn:hover {
            background-color: #5c161e;
        }

        /* Thanh danh mục */
        .category-bar {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .category-btn {
            padding: 8px 18px;
            border-radius: 20px;
            background: white;
            color: #475569;
            border: 1px solid #CBD5E1;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s;
        }
        .category-btn:hover, .category-btn.active {
            background-color: #7A1E28;
            color: white;
            border-color: #7A1E28;
        }

        /* Tiêu đề phần danh sách */
        .section-header {
            max-width: 1200px;
            margin: 0 auto 20px auto;
            padding: 0 20px;
        }
        .section-header h2 {
            color: #7A1E28;
            font-size: 20px;
            font-weight: bold;
            border-left: 5px solid #7A1E28;
            padding-left: 10px;
        }

        /* Lưới sản phẩm */
        .item-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 60px 20px;
        }
        .item-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #E2E8F0;
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            text-decoration: none;
        }
        .item-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .item-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background-color: #F1F5F9;
        }
        .item-info {
            padding: 15px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .item-title {
            font-size: 16px;
            font-weight: bold;
            color: #1E293B;
            margin-bottom: 8px;
            display: -webkit-box;
            line-clamp: 2;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .item-price {
            color: #dc2626;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 10px;
        }
        .item-meta {
            font-size: 12px;
            color: #64748b;
            margin-top: auto;
            display: flex;
            justify-content: space-between;
        }

        /* Footer */
        footer {
            background-color: #1E293B;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ PTIT</a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="add-item.jsp">Đăng tin mới</a>
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
                    <a href="admin" style="background: #FFD700; color: #7A1E28 !important; padding: 6px 14px; border-radius: 20px; font-weight: bold;">Quản trị</a>
                <% } %>

                <a href="profile" style="color: #FFD700 !important; font-weight: bold; text-decoration: underline;">
                    Xin chào, <%= user.getUsername() %>
                </a>
                <a href="logout">Đăng xuất</a>
            <% } else { %>
                <a href="login.jsp" style="background: white; color: #7A1E28 !important; padding: 6px 16px; border-radius: 20px; font-weight: bold; display: inline-block;">Đăng nhập</a>
            <% } %>
        </nav>
    </header>

    <!-- Banner & Thanh tìm kiếm tinh gọn, không bị đè lỗi -->
    <div class="banner-section">
        <div class="banner-title">Hệ Thống Trao Đổi Đồ Cũ Sinh Viên PTIT</div>
        <div class="banner-subtitle">❤️ Nhanh chóng - Tiện lợi - Uy tín trong nội bộ học viện</div>
        
        <div class="search-container">
            <form action="index" method="get" class="search-form">
                <input type="text" name="keyword" class="search-input" placeholder="Tìm kiếm sách, giáo trình, đồ điện tử..." value="<%= keyword %>">
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

    <!-- Tiêu đề danh sách -->
    <div class="section-header">
        <h2>Tin đăng mới nhất</h2>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="item-grid">
        <% if (items != null && !items.isEmpty()) { 
            for (Item item : items) { %>
            <a href="item-detail?id=<%= item.getId() %>" class="item-card">
                <img src="<%= (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) ? item.getImageUrl() : "images/no-image.png" %>" 
                     alt="<%= item.getTitle() %>" class="item-img" onerror="this.src='https://via.placeholder.com/260x180?text=PTIT+Exchange'">
                <div class="item-info">
                    <div class="item-title"><%= item.getTitle() %></div>
                    <div class="item-price" style="color: #0284C7; font-weight: 600; font-size: 13px;">
                        💬 Liên hệ người bán
                    </div>
                    <div class="item-meta">
                        <span>📍 <%= item.getLocation() != null ? item.getLocation() : "Hà Nội" %></span>
                        <span>🕒 <%= item.getCreatedAt() != null ? item.getCreatedAt() : "" %></span>
                    </div>
                </div>
            </a>
        <% }} else { %>
            <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #64748b; font-size: 15px; background: white; border-radius: 12px; border: 1px solid #E2E8F0;">
                Không tìm thấy món đồ nào phù hợp với yêu cầu của bạn.
            </div>
        <% } %>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ PTIT - Phát triển dành cho sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
    </footer>

</body>
</html>