<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.oldthings.model.Item" %>
<%@ page import="com.oldthings.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    
    // Danh sách Email Admin
    List<String> adminEmails = Arrays.asList(
        "trungkien.ptit@gmail.com",
        "kien.vukien@ptit.edu.vn",
        "kien43465@gmail.com"
    );

    String userEmail = (user != null && user.getEmail() != null) ? user.getEmail().toLowerCase().trim() : "";
    boolean isAdmin = user != null && ("ADMIN".equalsIgnoreCase(user.getRole()) || adminEmails.contains(userEmail));

    // Nếu không phải Admin thì chuyển hướng về trang chủ
    if (!isAdmin) {
        response.sendRedirect("index");
        return;
    }

    List<Item> items = (List<Item>) request.getAttribute("items");
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị - PTIT Exchange</title>
    <link rel="icon" type="image/jpeg" href="images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">
            <span class="logo-badge" style="background: var(--gold-light); color: var(--gold-text);">ADMIN</span>
            <span>PTIT EXCHANGE</span>
        </a>
        <nav>
            <a href="index">Trang chủ</a>
            <span class="user-pill">Admin: <%= user.getUsername() %></span>
            <a href="logout" class="link-logout">Đăng xuất</a>
        </nav>
    </header>

    <div class="container">
        <div class="section-title">
            <h2>Tổng quan hệ thống</h2>
        </div>

        <!-- Thống kê nhanh -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>TỔNG BÀI ĐĂNG</h3>
                <div class="number"><%= items != null ? items.size() : 0 %></div>
            </div>
            <div class="stat-card">
                <h3>TỔNG THÀNH VIÊN</h3>
                <div class="number"><%= users != null ? users.size() : 0 %></div>
            </div>
            <div class="stat-card">
                <h3>TRẠNG THÁI HỆ THỐNG</h3>
                <div class="number" style="color: #16A34A; font-size: 22px;">Hoạt động</div>
            </div>
        </div>

        <div class="section-title">
            <h2>Quản lý bài đăng sinh viên</h2>
        </div>

        <!-- Bảng bài đăng -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tiêu đề món đồ</th>
                        <th>Danh mục</th>
                        <th>Người đăng</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (items != null && !items.isEmpty()) {
                        for (Item item : items) { %>
                        <tr>
                            <td><b>#<%= item.getId() %></b></td>
                            <td>
                                <img src="<%= (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) ? item.getImageUrl() : "images/no-image.png" %>" 
                                     class="item-thumb" onerror="this.src='images/no-image.png';">
                            </td>
                            <td>
                                <a href="item-detail?id=<%= item.getId() %>" style="font-weight: 700; color: var(--text-main);" hover="color: var(--primary);">
                                    <%= item.getTitle() %>
                                </a>
                            </td>
                            <td><span class="item-category-tag" style="margin-bottom: 0;"><%= item.getCategory() %></span></td>
                            <td><%= item.getUsername() != null ? item.getUsername() : "SV PTIT" %></td>
                            <td>
                                <% if ("ACTIVE".equalsIgnoreCase(item.getStatus())) { %>
                                    <span class="badge badge-active">Đang hiển thị</span>
                                <% } else { %>
                                    <span class="badge badge-hidden">Đã ẩn/Đã đổi</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="delete-item?id=<%= item.getId() %>&returnTo=admin" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa bài đăng này không?');" 
                                   class="btn btn-danger" style="padding: 6px 12px; font-size: 12.5px;">Xóa</a>
                            </td>
                        </tr>
                    <% }} else { %>
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 32px; color: var(--text-muted);">Chưa có bài đăng nào trong hệ thống.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="section-title">
            <h2>Quản lý người dùng hệ thống</h2>
        </div>

        <!-- Bảng người dùng -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên người dùng</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (users != null && !users.isEmpty()) {
                        for (User u : users) { %>
                        <tr>
                            <td><b>#<%= u.getId() %></b></td>
                            <td><b><%= u.getUsername() %></b></td>
                            <td><%= u.getEmail() != null ? u.getEmail() : "" %></td>
                            <td>
                                <% if ("ADMIN".equalsIgnoreCase(u.getRole())) { %>
                                    <span class="badge" style="background: #FEE2E2; color: #991B1B;">QUẢN TRỊ VIÊN</span>
                                <% } else { %>
                                    <span class="badge" style="background: #E2E8F0; color: #475569;">SINH VIÊN</span>
                                <% } %>
                            </td>
                            <td>
                                <% if (!"ADMIN".equalsIgnoreCase(u.getRole())) { %>
                                    <a href="admin?action=makeAdmin&userId=<%= u.getId() %>" 
                                       onclick="return confirm('Bạn có muốn nâng cấp tài khoản này thành Quản trị viên?');" 
                                       class="btn" style="padding: 6px 12px; font-size: 12.5px;">Cấp quyền Admin</a>
                                <% } else { %>
                                    <span style="color: var(--text-muted); font-size: 13px; font-weight: 600;">Đã là Admin</span>
                                <% } %>
                            </td>
                        </tr>
                    <% }} else { %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 32px; color: var(--text-muted);">Chưa có tài khoản người dùng nào.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>

</body>
</html>