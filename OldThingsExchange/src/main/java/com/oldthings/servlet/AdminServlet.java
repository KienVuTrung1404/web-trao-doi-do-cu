package com.oldthings.servlet;

import com.oldthings.dao.ItemDAO;
import com.oldthings.model.Item;
import com.oldthings.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    // Danh sách các Email được phép vào trang Quản trị
    private static final List<String> ADMIN_EMAILS = Arrays.asList(
        "trungkien.ptit@gmail.com",
        "kien.vukien@ptit.edu.vn",
        "kien43465@gmail.com"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra xem user đã đăng nhập chưa
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Kiểm tra quyền Admin theo Email hoặc thuộc tính Role
        String email = user.getEmail() != null ? user.getEmail().toLowerCase().trim() : "";
        boolean isAdmin = "ADMIN".equalsIgnoreCase(user.getRole()) || ADMIN_EMAILS.contains(email);

        if (!isAdmin) {
            response.sendRedirect("index");
            return;
        }

        // Nếu đúng là Admin, lấy toàn bộ danh sách bài đăng
        List<Item> allItems = itemDAO.getAllItems();
        request.setAttribute("items", allItems);

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}