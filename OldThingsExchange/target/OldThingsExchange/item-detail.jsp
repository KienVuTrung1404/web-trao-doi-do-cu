
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.oldthings.model.User" %>
<%@ page import="com.oldthings.model.Item" %>
<%
    Item item = (Item) request.getAttribute("item");
    if (item == null) {
        response.sendRedirect("index");
        return;
    }
    User currentUser = (User) session.getAttribute("user");
    String phone = item.getPhone() != null && !item.getPhone().trim().isEmpty() ? item.getPhone() : "Chưa cập nhật";
    boolean isDone = "DONE".equals(item.getStatus());

    List<String> adminEmails = Arrays.asList(
        "trungkien.ptit@gmail.com",
        "kien.vukien@ptit.edu.vn",
        "kien43465@gmail.com"
    );
    String userEmail = (currentUser != null && currentUser.getEmail() != null) ? currentUser.getEmail().toLowerCase().trim() : "";
    boolean isAdmin = currentUser != null && ("ADMIN".equalsIgnoreCase(currentUser.getRole()) || adminEmails.contains(userEmail));
    boolean isOwner = currentUser != null && currentUser.getId() == item.getUserId();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= item.getTitle() %> - TRAO ĐỔI ĐỒ CŨ</title>
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
            <a href="add-item.jsp" class="btn-header-post">+ Đăng tin mới</a>
            <% if (currentUser != null) { %>
                <a href="my-items">Tin của tôi</a>
                <a href="profile" class="user-pill">👤 <%= currentUser.getUsername() %></a>
                <a href="logout" class="link-logout">Đăng xuất</a>
            <% } else { %>
                <a href="login.jsp" class="btn-header-post">Đăng nhập</a>
            <% } %>
        </nav>
    </header>

    <div class="container">
        <div class="detail-card">

            <div class="detail-img-box">
                <img src="<%= (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) ? item.getImageUrl() : "images/no-image.png" %>" 
                     alt="<%= item.getTitle() %>" 
                     class="detail-img <%= isDone ? "done-img" : "" %>" 
                     onerror="this.src='images/no-image.png';">
                <% if (isDone) { %>
                    <span class="done-badge" style="top: 15px; left: 15px; right: auto; background: #DC2626; font-size: 12px; padding: 6px 14px;">
                        ĐÃ TRAO ĐỔI XONG
                    </span>
                <% } %>
            </div>

            <div class="detail-info-box">
                <span class="item-category-tag" style="margin-bottom: 12px; font-size: 12px;"><%= item.getCategory() %></span>
                <h1 class="detail-title"><%= item.getTitle() %></h1>

                <div class="detail-desc">
                    <strong style="color: var(--text-main); display: block; margin-bottom: 6px;">Mô tả & nhu cầu trao đổi:</strong>
                    <%= item.getDescription() %>
                </div>

                <div class="detail-meta-box">
                    <p><strong>📍 Khu vực:</strong> <%= item.getLocation() != null ? item.getLocation() : "Học viện PTIT" %></p>
                    <p><strong>👤 Người đăng:</strong> <%= item.getUsername() != null ? item.getUsername() : "Sinh viên PTIT" %></p>
                    <p><strong>🕒 Ngày đăng:</strong> <%= item.getCreatedAt() != null ? item.getCreatedAt() : "Mới đây" %></p>
                    <p><strong>📞 Số điện thoại:</strong> <strong style="color: var(--primary);"><%= phone %></strong></p>
                </div>

                <% if (isOwner || isAdmin) { %>
                    <div style="background: #FFFBEB; border: 1px solid #FDE68A; padding: 16px; border-radius: var(--radius-sm); margin-bottom: 22px;">
                        <div style="font-size: 13px; font-weight: bold; color: #B45309; margin-bottom: 10px;">
                            ⚙️ Quản lý tin đăng này (<%= isOwner ? "Bạn là người đăng" : "Quyền Quản trị viên" %>):
                        </div>
                        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                            <% if (isOwner) { %>
                                <a href="edit-item?id=<%= item.getId() %>" 
                                   style="background: #2563EB; color: white; padding: 8px 16px; border-radius: var(--radius-sm); text-decoration: none; font-size: 13px; font-weight: 700;">
                                    ✏️ Chỉnh sửa tin
                                </a>
                                <a href="toggle-status?id=<%= item.getId() %>" 
                                   style="background: <%= isDone ? "#16A34A" : "#D97706" %>; color: white; padding: 8px 16px; border-radius: var(--radius-sm); text-decoration: none; font-size: 13px; font-weight: 700;">
                                    <%= isDone ? "🔄 Đăng lại tin" : "✔️ Đánh dấu đã đổi xong" %>
                                </a>
                            <% } %>
                            <a href="delete-item?id=<%= item.getId() %><%= isAdmin ? "&returnTo=admin" : "" %>" 
                               onclick="return confirm('Bạn có chắc chắn muốn xóa tin này không?');"
                               style="background: #DC2626; color: white; padding: 8px 16px; border-radius: var(--radius-sm); text-decoration: none; font-size: 13px; font-weight: 700;">
                                🗑️ Xóa tin
                            </a>
                        </div>
                    </div>
                <% } %>

                <div style="margin-top: auto; display: flex; gap: 12px; flex-wrap: wrap;">
                    <% if (isDone) { %>
                        <div style="width: 100%; background: #F1F5F9; color: var(--text-muted); text-align: center; padding: 14px; border-radius: var(--radius-sm); font-weight: 700; font-size: 14px;">
                            Món đồ này đã được trao đổi xong.
                        </div>
                    <% } else if (!phone.equals("Chưa cập nhật")) { %>
                        <a href="https://zalo.me/<%= phone %>"
                           target="_blank"
                           rel="noopener noreferrer"
                           class="btn-zalo">
                            💬 Liên hệ trao đổi qua Zalo (<%= phone %>)
                        </a>
                    <% } else { %>
                        <span style="color: var(--text-muted); font-size: 14px;">Người đăng không để lại số điện thoại.</span>
                    <% } %>
                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>

</body>
</html>
