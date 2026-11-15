
package com.oldthings.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        // Hủy phiên đăng nhập
        HttpSession session = req.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        // Ngăn trình duyệt lưu trang cũ
        resp.setHeader("Cache-Control",
                "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        // Chuyển về trang đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
