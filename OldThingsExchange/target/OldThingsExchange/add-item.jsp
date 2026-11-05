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
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ</a>
        <nav>
            <a href="index">Trang chủ</a>
            <span style="font-weight: bold; color: #FDE68A;">Xin chào, <%= user.getUsername() %></span>
            <a href="logout" style="color: #FECACA;">Đăng xuất</a>
        </nav>
    </header>

    <div class="container" style="display: flex; justify-content: center;">
        <form action="add-item" method="post" enctype="multipart/form-data">
            <h2>Đăng tin trao đổi đồ mới</h2>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <p style="color: #dc2626; font-weight: bold; margin-bottom: 10px;"><%= error %></p>
            <% } %>

            <label for="title">Tên món đồ:</label>
            <input type="text" id="title" name="title" required placeholder="VD: Giáo trình Cơ sở dữ liệu">

            <label for="category">Danh mục:</label>
            <select id="category" name="category" required>
                <option value="Sách & Giáo trình">Sách & Giáo trình</option>
                <option value="Đồ điện tử">Đồ điện tử</option>
                <option value="Thể thao">Thể thao</option>
                <option value="Đồ gia dụng">Đồ gia dụng</option>
                <option value="Khác">Khác</option>
            </select>

            <label for="phone">Số điện thoại / Zalo liên hệ:</label>
            <input type="tel" id="phone" name="phone" required placeholder="VD: 0987654321">

            <label for="description">Mô tả tình trạng & nhu cầu đổi:</label>
            <textarea id="description" name="description" rows="4" required placeholder="Mô tả tình trạng đồ cũ và món đồ bạn muốn đổi lại..."></textarea>

            <label for="location">Khu vực / Địa chỉ:</label>
            <input type="text" id="location" name="location" required placeholder="VD: Hà Đông, Hà Nội">

            <label for="imageFile">Chọn ảnh từ máy tính:</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/*" style="padding: 8px 0;">

            <button type="submit">Đăng tin</button>
        </form>
    </div>

    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ - Hệ thống trao đổi đồ cũ sinh viên PTIT.</p>
    </footer>

</body>
</html>