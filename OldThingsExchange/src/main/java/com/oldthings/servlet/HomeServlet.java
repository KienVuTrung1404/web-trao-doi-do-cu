
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

        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");

        List<Item> itemList;

        if (category != null && !category.equals("Tất cả")
                && !category.trim().isEmpty()) {

            itemList = itemDAO.getItemsByCategory(category.trim());

        } else if (keyword != null && !keyword.trim().isEmpty()) {

            itemList = itemDAO.searchItems(keyword.trim());

        } else {

            itemList = itemDAO.getAllItems();
        }

        req.setAttribute("items", itemList);
        req.setAttribute("keyword", keyword);

        if (category == null || category.trim().isEmpty()) {
            category = "Tất cả";
        }

        req.setAttribute("category", category);

        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}
