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
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị - PTIT Exchange</title>
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #F8FAFC; color: #1E293B; }
        
        header { background-color: #7A1E28; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        header .logo { color: white; font-size: 18px; font-weight: bold; text-decoration: none; }
        header a.logout { color: #FFD700; text-decoration: none; font-weight: bold; }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .page-title { color: #7A1E28; font-size: 24px; font-weight: bold; margin-bottom: 20px; border-left: 5px solid #7A1E28; padding-left: 12px; }

        /* Bảng thống kê nhanh */
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 20px; border-radius: 10px; border: 1px solid #E2E8F0; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .stat-card h3 { font-size: 14px; color: #64748B; margin-bottom: 8px; }
        .stat-card .number { font-size: 28px; font-weight: bold; color: #7A1E28; }

        /* Bảng quản lý bài đăng */
        .table-container { background: white; border-radius: 10px; border: 1px solid #E2E8F0; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; text-align: left; font-size: 14px; }
        th { background: #F1F5F9; color: #475569; font-weight: bold; padding: 14px 16px; border-bottom: 1px solid #CBD5E1; }
        td { padding: 14px 16px; border-bottom: 1px solid #E2E8F0; vertical-align: middle; }
        tr:hover { background-color: #F8FAFC; }

        .item-thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 6px; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-active { background: #DCFCE7; color: #166534; }
        .badge-hidden { background: #FEE2E2; color: #991B1B; }

        .btn-action { padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 13px; font-weight: 500; display: inline-block; cursor: pointer; }
        .btn-delete { background: #EF4444; color: white; border: none; }
        .btn-delete:hover { background: #DC2626; }
        .btn-toggle { background: #3B82F6; color: white; border: none; margin-right: 5px; }
        .btn-toggle:hover { background: #2563EB; }
    </style>
</head>
<body>

    <header>
        <a href="index" class="logo">⚙️ HỆ THỐNG QUẢN TRỊ PTIT EXCHANGE</a>
        <div>
            <span style="margin-right: 15px;">Xin chào Admin, <b><%= user.getUsername() %></b></span>
            <a href="logout" class="logout">Đăng xuất</a>
        </div>
    </header>

    <div class="container">
        <div class="page-title">Tổng quan hệ thống</div>

        <!-- Thống kê nhanh -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>TỔNG BÀI ĐĂNG</h3>
                <div class="number"><%= items != null ? items.size() : 0 %></div>
            </div>
            <div class="stat-card">
                <h3>TRẠNG THÁI HỆ THỐNG</h3>
                <div class="number" style="color: #16A34A; font-size: 20px;">Hoạt động</div>
            </div>
        </div>

        <div class="page-title">Quản lý bài đăng sinh viên</div>

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
                                     class="item-thumb" onerror="this.src='https://via.placeholder.com/50'">
                            </td>
                            <td><b><%= item.getTitle() %></b></td>
                            <td><%= item.getCategory() %></td>
                            <td><%= item.getUsername() != null ? item.getUsername() : "SV PTIT" %></td>
                            <td>
                                <% if ("ACTIVE".equalsIgnoreCase(item.getStatus())) { %>
                                    <span class="badge badge-active">Đang hiển thị</span>
                                <% } else { %>
                                    <span class="badge badge-hidden">Đã ẩn/Đã bán</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="toggle-status?id=<%= item.getId() %>" class="btn-action btn-toggle">Ẩn/Hiện</a>
                                <a href="delete-item?id=<%= item.getId() %>&returnTo=admin" 
                                   onclick="return confirm('Kiên có chắc chắn muốn xóa vĩnh viễn bài đăng rác này không?');" 
                                   class="btn-action btn-delete">Xóa</a>
                            </td>
                        </tr>
                    <% }} else { %>
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 30px; color: #64748B;">Chưa có bài đăng nào trong hệ thống.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>