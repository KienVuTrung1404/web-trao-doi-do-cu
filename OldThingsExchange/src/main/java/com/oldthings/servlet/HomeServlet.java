
package com.oldthings.servlet;

import com.oldthings.dao.ItemDAO;
import com.oldthings.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/home", "/index"})
public class HomeServlet extends HttpServlet {

    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");

        List<Item> itemList = itemDAO.getItems(keyword, category, true);

        req.setAttribute("items", itemList);
        req.setAttribute("keyword", keyword != null ? keyword : "");

        if (category == null || category.trim().isEmpty()) {
            category = "Tất cả";
        }

        req.setAttribute("category", category);

        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
