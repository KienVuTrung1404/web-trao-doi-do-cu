package com.oldthings.servlet;

import com.oldthings.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("forgot-password.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tất cả các trường thông tin!");
            req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean success = userDAO.resetPassword(username.trim(), email.trim(), newPassword);

        if (success) {
            resp.sendRedirect("login.jsp?msg=password_reset");
        } else {
            req.setAttribute("error", "Tên đăng nhập và Email không khớp với bất kỳ tài khoản nào!");
            req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
        }
    }
}