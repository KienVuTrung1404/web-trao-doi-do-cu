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
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    // Danh sách các Email được cấp quyền ADMIN
    private static final List<String> ADMIN_EMAILS = Arrays.asList(
        "trungkien.ptit@gmail.com",
        "kien.vukien@ptit.edu.vn",
        "kien43465@gmail.com"
    );

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String credential = req.getParameter("credential");

        if (credential != null && !credential.isEmpty()) {
            try {
                // Giải mã Token JWT từ Google
                String[] parts = credential.split("\\.");
                String payloadJson = new String(Base64.getUrlDecoder().decode(parts[1]), StandardCharsets.UTF_8);

                String email = extractJsonValue(payloadJson, "email");
                String name = extractJsonValue(payloadJson, "name");

                if (email != null && !email.isEmpty()) {
                    User user = userDAO.getUserByEmail(email);
                    if (user == null) {
                        user = userDAO.registerGoogleUser(name, email);
                    }

                    if (user != null) {
                        // Kiểm tra email xem có phải Admin không
                        String lowerEmail = email.toLowerCase().trim();
                        if (ADMIN_EMAILS.contains(lowerEmail) || lowerEmail.endsWith("@admin.ptit.edu.vn")) {
                            user.setRole("ADMIN");
                        } else if (user.getRole() == null || user.getRole().isEmpty()) {
                            user.setRole("USER");
                        }

                        HttpSession session = req.getSession();
                        session.setAttribute("user", user);
                        resp.sendRedirect("index");
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        req.setAttribute("error", "Đăng nhập Google thất bại!");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    private String extractJsonValue(String json, String key) {
        String searchKey = "\"" + key + "\":\"";
        int start = json.indexOf(searchKey);
        if (start == -1) return null;
        start += searchKey.length();
        int end = json.indexOf("\"", start);
        return (end != -1) ? json.substring(start, end) : null;
    }
}