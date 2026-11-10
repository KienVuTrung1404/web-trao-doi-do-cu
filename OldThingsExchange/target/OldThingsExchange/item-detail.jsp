<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= item.getTitle() %> - TRAO ĐỔI ĐỒ CŨ</title>
    <link rel="icon" type="image/jpeg" href="/images/logo.jpg?v=1">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header>
        <a href="index" class="logo">🔴 TRAO ĐỔI ĐỒ CŨ</a>
        <nav>
            <a href="index">Trang chủ</a>
            <% if (currentUser != null) { %>
                <a href="add-item.jsp" class="btn">Đăng tin mới</a>
                <a href="my-items">Tin của tôi</a>
                <span style="font-weight: bold; color: #FDE68A;">Xin chào, <%= currentUser.getUsername() %></span>
                <a href="logout" style="color: #FECACA;">Đăng xuất</a>
            <% } else { %>
                <a href="login.jsp" class="btn">Đăng tin mới</a>
                <a href="login.jsp">Đăng nhập</a>
                <a href="register.jsp">Đăng ký</a>
            <% } %>
        </nav>
    </header>

    <div class="container">
        <div style="background: white; padding: 30px; border-radius: 14px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); display: flex; gap: 30px; flex-wrap: wrap;">
            
            <div style="flex: 1; min-width: 300px; position: relative;">
                <img src="<%= item.getImageUrl() %>" alt="<%= item.getTitle() %>" class="<%= isDone ? "done-img" : "" %>" style="width: 100%; height: 350px; object-fit: cover; border-radius: 10px; border: 1px solid #e2e8f0;" onerror="this.src='https://via.placeholder.com/400x350?text=No+Image';">
                <% if (isDone) { %>
                    <div style="position: absolute; top: 15px; left: 15px; background: #dc2626; color: white; padding: 6px 14px; border-radius: 20px; font-weight: 700; font-size: 13px;">
                        ĐÃ TRAO ĐỔI XONG
                    </div>
                <% } %>
            </div>

            <div style="flex: 1.2; min-width: 300px; display: flex; flex-direction: column;">
                <span class="product-type" style="margin-bottom: 12px;"><%= item.getCategory() %></span>
                <h1 style="font-size: 24px; color: #0f172a; margin-bottom: 15px;"><%= item.getTitle() %></h1>
                
                <p style="font-size: 15px; color: #475569; line-height: 1.6; margin-bottom: 20px; white-space: pre-line;">
                    <strong>Mô tả & nhu cầu trao đổi:</strong><br><%= item.getDescription() %>
                </p>

                <div style="background: #f8fafc; padding: 15px; border-radius: 10px; margin-bottom: 20px; line-height: 1.8;">
                    <p>📍 <strong>Khu vực:</strong> <%= item.getLocation() %></p>
                    <p>👤 <strong>Người đăng:</strong> <%= item.getUsername() %></p>
                    <p>📞 <strong>SĐT / Zalo:</strong> <strong style="color: #7A1E28;"><%= phone %></strong></p>
                </div>

                <div style="margin-top: auto; display: flex; gap: 12px; flex-wrap: wrap;">
                    <% if (isDone) { %>
                        <div style="width: 100%; background: #F1F5F9; color: #64748B; text-align: center; padding: 12px; border-radius: 10px; font-weight: 600;">
                             Món đồ này đã được trao đổi xong.
                        </div>
                    <% } else if (!phone.equals("Chưa cập nhật")) { %>
                        <a href="https://zalo.me/<%= phone %>" target="_blank" class="btn" style="flex: 1; text-align: center; background-color: #0068FF;">
                            💬 Nhắn Zalo
                        </a>
                        <a href="tel:<%= phone %>" class="btn" style="flex: 1; text-align: center;">
                            📞 Gọi điện trực tiếp
                        </a>
                    <% } else { %>
                        <span style="color: #64748b; font-size: 14px;">Người đăng không để lại số điện thoại.</span>
                    <% } %>
                </div>
            </div>

        </div>
    </div>

    <footer>
        <p>&copy; 2026 Trao Đổi Đồ Cũ - Hệ thống trao đổi đồ cũ sinh viên PTIT.</p>
    </footer>

</body>
</html>