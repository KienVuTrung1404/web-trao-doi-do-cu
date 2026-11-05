package com.oldthings.servlet;

import com.oldthings.dao.UserDAO;
import com.oldthings.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("updateUsername".equals(action)) {
            String newUsername = req.getParameter("username");
            if (newUsername != null && !newUsername.trim().isEmpty()) {
                boolean success = userDAO.updateUsername(user.getId(), newUsername.trim());
                if (success) {
                    user.setUsername(newUsername.trim());
                    session.setAttribute("user", user);
                    req.setAttribute("message", "Cập nhật tên người dùng thành công!");
                } else {
                    req.setAttribute("error", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác!");
                }
            }
        } else if ("updateEmail".equals(action)) {
            String newEmail = req.getParameter("email");
            if (newEmail != null && !newEmail.trim().isEmpty()) {
                boolean success = userDAO.updateEmail(user.getId(), newEmail.trim());
                if (success) {
                    user.setEmail(newEmail.trim());
                    session.setAttribute("user", user);
                    req.setAttribute("message", "Cập nhật Email thành công!");
                } else {
                    req.setAttribute("error", "Email đã tồn tại hoặc không hợp lệ!");
                }
            }
        }

        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}