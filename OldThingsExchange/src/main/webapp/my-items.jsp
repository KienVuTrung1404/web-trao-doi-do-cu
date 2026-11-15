<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oldthings.model.User" %>
<%@ page import="com.oldthings.model.Item" %>
<%@ page import="java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Item> myItems = (List<Item>) request.getAttribute("myItems");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tin đăng của tôi - TRAO ĐỔI ĐỒ CŨ</title>
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
            <a href="my-items" style="background: rgba(255, 255, 255, 0.2);">Tin của tôi</a>
            <a href="profile" class="user-pill">👤 <%= currentUser.getUsername() %></a>
            <a href="logout" class="link-logout">Đăng xuất</a>
        </nav>
    </header>

    <div class="container">
        <div class="section-title">
            <h2>Quản lý tin đăng của tôi</h2>
        </div>

        <div class="item-grid">
            <%
                if (myItems != null && !myItems.isEmpty()) {
                    for (Item item : myItems) {
                        boolean isDone = "DONE".equals(item.getStatus());
            %>
                        <div class="item-card <%= isDone ? "done-card" : "" %>">
                            <a href="item-detail?id=<%= item.getId() %>" class="item-img-wrapper">
                                <img src="<%= (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) ? item.getImageUrl() : "images/no-image.png" %>" 
                                     alt="<%= item.getTitle() %>" class="item-img" onerror="this.src='images/no-image.png';">
                                <% if (isDone) { %>
                                    <span class="done-badge">ĐÃ XONG</span>
                                <% } %>
                            </a>
                            <div class="item-info">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                    <span class="item-category-tag"><%= item.getCategory() %></span>
                                    <% if (isDone) { %>
                                        <span class="badge badge-hidden">Đã trao đổi</span>
                                    <% } else { %>
                                        <span class="badge badge-active">Đang hiển thị</span>
                                    <% } %>
                                </div>

                                <a href="item-detail?id=<%= item.getId() %>" class="item-title"><%= item.getTitle() %></a>
                                <p style="font-size: 13px; color: var(--text-muted); margin-bottom: 10px; display: -webkit-box; -webkit-line-clamp: 2; line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;"><%= item.getDescription() != null ? item.getDescription() : "" %></p>
                                
                                <div class="item-meta" style="flex-direction: column; gap: 10px; align-items: flex-start;">
                                    <span>📍 <%= item.getLocation() != null ? item.getLocation() : "Hà Nội" %></span>
                                    <div style="display: flex; gap: 10px; width: 100%; border-top: 1px solid var(--border-subtle); padding-top: 10px; align-items: center;">
                                        <a href="toggle-status?id=<%= item.getId() %>" 
                                           style="font-size: 12.5px; font-weight: 700; color: <%= isDone ? "#16A34A" : "#D97706" %>;">
                                            <%= isDone ? "🔄 Đăng lại" : "✔️ Đổi xong" %>
                                        </a>
                                        <a href="edit-item?id=<%= item.getId() %>" 
                                           style="font-size: 12.5px; color: #2563EB; font-weight: 700;">
                                            ✏️ Sửa
                                        </a>
                                        <a href="delete-item?id=<%= item.getId() %>" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tin đăng này?');" 
                                           style="font-size: 12.5px; color: #DC2626; font-weight: 700; margin-left: auto;">
                                            🗑️ Xóa
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                <div class="empty-state">
                    <div class="empty-state-icon">📋</div>
                    <h3>Bạn chưa đăng món đồ nào</h3>
                    <p>Chia sẻ giáo trình hoặc đồ dùng không dùng tới cho các bạn sinh viên khác nhé!</p>
                    <a href="add-item.jsp" class="btn" style="margin-top: 6px;">+ Đăng tin mới ngay</a>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p><strong>&copy; 2026 Trao Đổi Đồ Cũ PTIT</strong> — Nền tảng trao đổi đồ dùng sinh viên Học viện Công nghệ Bưu chính Viễn thông.</p>
        <p class="footer-sub">Học tập • Chia sẻ • Tiết kiệm • Văn minh sinh viên</p>
    </footer>

</body>
</html>