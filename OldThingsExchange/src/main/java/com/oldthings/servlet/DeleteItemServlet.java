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

@WebServlet("/delete-item")
public class DeleteItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String idRaw = req.getParameter("id");
        if (idRaw != null) {
            try {
                int itemId = Integer.parseInt(idRaw);
                itemDAO.deleteItem(itemId, user.getId());
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        resp.sendRedirect("my-items");
    }
}