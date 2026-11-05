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
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ</a>
        <nav>
            <a href="index">Trang chủ</a>
            <a href="add-item.jsp" class="btn">Đăng tin mới</a>
            <a href="my-items">Tin của tôi</a>
            <span style="font-weight: bold; color: #FDE68A;">Xin chào, <%= currentUser.getUsername() %></span>
            <a href="logout" style="color: #FECACA;">Đăng xuất</a>
        </nav>
    </header>

    <div class="container">
        <div class="section-title">
            <h2>Quản lý tin đăng của tôi</h2>
        </div>

        <div class="product-grid">
            <%
                if (myItems != null && !myItems.isEmpty()) {
                    for (Item item : myItems) {
                        boolean isDone = "DONE".equals(item.getStatus());
            %>
                        <div class="product-card <%= isDone ? "done-card" : "" %>">
                            <a href="item-detail?id=<%= item.getId() %>">
                                <img src="<%= item.getImageUrl() %>" alt="<%= item.getTitle() %>" class="product-img" onerror="this.src='https://via.placeholder.com/300x180?text=No+Image';">
                            </a>
                            <div class="product-info">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                    <span class="product-type"><%= item.getCategory() %></span>
                                    <% if (isDone) { %>
                                        <span style="background: #E2E8F0; color: #475569; font-size: 11px; font-weight: 700; padding: 3px 8px; border-radius: 12px;">ĐÃ TRAO ĐỔI</span>
                                    <% } else { %>
                                        <span style="background: #DCFCE7; color: #15803D; font-size: 11px; font-weight: 700; padding: 3px 8px; border-radius: 12px;">ĐANG HIỂN THỊ</span>
                                    <% } %>
                                </div>

                                <a href="item-detail?id=<%= item.getId() %>" class="product-title"><%= item.getTitle() %></a>
                                <p style="font-size: 13px; color: #64748B; margin-bottom: 10px; display: -webkit-box; -webkit-line-clamp: 2; line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;"><%= item.getDescription() %></p>
                                
                                <div class="product-meta" style="flex-direction: column; gap: 10px; align-items: flex-start;">
                                    <span>📍 <%= item.getLocation() %></span>
                                    <div style="display: flex; gap: 12px; width: 100%; border-top: 1px solid #F1F5F9; padding-top: 10px;">
                                        <a href="toggle-status?id=<%= item.getId() %>" class="<%= isDone ? "link-repost" : "link-done" %>">
                                            <%= isDone ? "🔄 Đăng lại" : "✔️ Đã đổi xong" %>
                                        </a>
                                        <a href="edit-item?id=<%= item.getId() %>" style="color: #2563eb; font-weight: bold; text-decoration: none;">✏️ Sửa</a>
                                        <a href="delete-item?id=<%= item.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa tin đăng này?');" style="color: #dc2626; font-weight: bold; text-decoration: none; margin-left: auto;">🗑️ Xóa</a>
                                    </div>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 40px; background: white; border-radius: 14px;">
                    <p style="font-size: 16px; color: #64748b;">Bạn chưa có tin đăng nào.</p>
                    <a href="add-item.jsp" class="btn" style="margin-top: 15px;">Đăng tin ngay</a>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ - Hệ thống trao đổi đồ cũ sinh viên PTIT.</p>
    </footer>

</body>
</html>