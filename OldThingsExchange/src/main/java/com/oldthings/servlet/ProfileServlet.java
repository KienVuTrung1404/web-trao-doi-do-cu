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
        } else if ("changePassword".equals(action)) {
            String oldPassword = req.getParameter("oldPassword");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (newPassword == null || newPassword.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập mật khẩu mới và xác nhận mật khẩu!");
            } else if (!newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            } else if ("GOOGLE_AUTH".equals(user.getPassword())) {
                boolean success = userDAO.changePassword(user.getId(), newPassword);
                if (success) {
                    user.setPassword(newPassword);
                    session.setAttribute("user", user);
                    req.setAttribute("message", "Thiết lập mật khẩu mới thành công!");
                } else {
                    req.setAttribute("error", "Không thể cập nhật mật khẩu, vui lòng thử lại!");
                }
            } else {
                if (oldPassword == null || oldPassword.trim().isEmpty()) {
                    req.setAttribute("error", "Vui lòng nhập mật khẩu hiện tại!");
                } else if (!userDAO.checkOldPassword(user.getId(), oldPassword)) {
                    req.setAttribute("error", "Mật khẩu hiện tại không chính xác!");
                } else {
                    boolean success = userDAO.changePassword(user.getId(), newPassword);
                    if (success) {
                        user.setPassword(newPassword);
                        session.setAttribute("user", user);
                        req.setAttribute("message", "Đổi mật khẩu thành công!");
                    } else {
                        req.setAttribute("error", "Không thể cập nhật mật khẩu, vui lòng thử lại!");
                    }
                }
            }
        }

        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}