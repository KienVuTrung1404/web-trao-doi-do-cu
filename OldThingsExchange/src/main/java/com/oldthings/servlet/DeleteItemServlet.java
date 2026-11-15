
package com.oldthings.servlet;

import com.oldthings.dao.ItemDAO;
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

@WebServlet("/delete-item")
public class DeleteItemServlet extends HttpServlet {

    private ItemDAO itemDAO = new ItemDAO();

    private static final List<String> ADMIN_EMAILS = Arrays.asList(
        "trungkien.ptit@gmail.com",
        "kien.vukien@ptit.edu.vn",
        "kien43465@gmail.com"
    );

    private boolean isAdmin(User user) {
        if (user == null) return false;

        String email = user.getEmail() != null
                ? user.getEmail().toLowerCase().trim()
                : "";

        return "ADMIN".equalsIgnoreCase(user.getRole())
                || ADMIN_EMAILS.contains(email);
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        User user = (session != null)
                ? (User) session.getAttribute("user")
                : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String idRaw = req.getParameter("id");

        if (idRaw != null) {
            try {
                int itemId = Integer.parseInt(idRaw);

                if (isAdmin(user)) {
                    itemDAO.deleteItemByAdmin(itemId);
                } else {
                    itemDAO.deleteItem(itemId, user.getId());
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Quay lại đúng trang Admin sau khi xóa
        if (isAdmin(user) && "admin".equals(req.getParameter("returnTo"))) {
            resp.sendRedirect(req.getContextPath() + "/admin");
        } else {
            resp.sendRedirect(req.getContextPath() + "/my-items");
        }
    }
}
