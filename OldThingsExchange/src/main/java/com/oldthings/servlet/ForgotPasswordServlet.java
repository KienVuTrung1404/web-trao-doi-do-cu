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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (newPassword != null && !newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean success = userDAO.resetPassword(username, email, newPassword);

        if (success) {
            resp.sendRedirect("login.jsp?msg=password_reset");
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc Email không chính xác!");
            req.getRequestDispatcher("forgot-password.jsp").forward(req, resp);
        }
    }
}