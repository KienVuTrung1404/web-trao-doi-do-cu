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
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ</a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="my-items">Tin của tôi</a>
            <span style="font-weight: bold; color: #FDE68A;">Xin chào, <%= user.getUsername() %></span>
            <a href="logout" style="color: #FECACA;">Đăng xuất</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center;">
        <form action="edit-item" method="post" enctype="multipart/form-data">
            <h2>Chỉnh sửa tin đăng</h2>
            <input type="hidden" name="id" value="<%= item.getId() %>">

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <p style="color: #dc2626; font-weight: bold; margin-bottom: 10px;"><%= error %></p>
            <% } %>

            <label for="title">Tên món đồ:</label>
            <input type="text" id="title" name="title" required value="<%= item.getTitle() %>">

            <label for="category">Danh mục:</label>
            <select id="category" name="category" required>
                <% for (String cat : categories) { %>
                    <option value="<%= cat %>" <%= cat.equals(item.getCategory()) ? "selected" : "" %>><%= cat %></option>
                <% } %>
            </select>

            <label for="phone">Số điện thoại / Zalo liên hệ:</label>
            <input type="tel" id="phone" name="phone" required value="<%= item.getPhone() != null ? item.getPhone() : "" %>">

            <label for="description">Mô tả tình trạng & nhu cầu đổi:</label>
            <textarea id="description" name="description" rows="4" required><%= item.getDescription() %></textarea>

            <label for="location">Khu vực / Địa chỉ:</label>
            <input type="text" id="location" name="location" required value="<%= item.getLocation() %>">

            <label for="imageFile">Thay ảnh mới (để trống nếu muốn giữ ảnh cũ):</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/*" style="padding: 8px 0;">

            <button type="submit">Lưu thay đổi</button>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ - Hệ thống trao đổi đồ cũ sinh viên PTIT.</p>
    </footer>

</body>
</html>