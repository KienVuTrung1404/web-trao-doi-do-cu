package com.oldthings.servlet;

import com.oldthings.dao.UserDAO;
import com.oldthings.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (userDAO.getUserByUsername(username.trim()) != null) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        if (email != null && !email.trim().isEmpty() && userDAO.getUserByEmail(email.trim()) != null) {
            req.setAttribute("error", "Email này đã được đăng ký tài khoản!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        User user = new User(username.trim(), (email != null ? email.trim() : ""), password);
        boolean success = userDAO.register(user);

        if (success) {
            resp.sendRedirect("login.jsp?msg=registered");
        } else {
            req.setAttribute("error", "Đăng ký không thành công, vui lòng thử lại!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}