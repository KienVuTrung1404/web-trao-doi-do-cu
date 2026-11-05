package com.oldthings.servlet;

import com.oldthings.dao.ItemDAO;
import com.oldthings.model.Item;
import com.oldthings.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/edit-item")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class EditItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    private User getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUser(req);
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Item item = itemDAO.getItemById(id);
            if (item == null || item.getUserId() != user.getId()) {
                resp.sendRedirect("my-items");
                return;
            }
            req.setAttribute("item", item);
            req.getRequestDispatcher("edit-item.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect("my-items");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        User user = getUser(req);
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("my-items");
            return;
        }

        Item old = itemDAO.getItemById(id);
        if (old == null || old.getUserId() != user.getId()) {
            resp.sendRedirect("my-items");
            return;
        }

        String title = req.getParameter("title");
        String category = req.getParameter("category");
        String description = req.getParameter("description");
        String location = req.getParameter("location");
        String phone = req.getParameter("phone");

        // Mặc định giữ ảnh cũ
        String imageUrl = old.getImageUrl();

        Part filePart = req.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = req.getServletContext().getRealPath("") + "uploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            filePart.write(uploadPath + File.separator + uniqueFileName);
            imageUrl = "uploads/" + uniqueFileName;
        }

        Item item = new Item(title, category, description, location, imageUrl, phone, user.getId());
        item.setId(id);

        if (itemDAO.updateItem(item)) {
            resp.sendRedirect("my-items");
        } else {
            item.setUsername(old.getUsername());
            req.setAttribute("item", item);
            req.setAttribute("error", "Không thể cập nhật tin, vui lòng thử lại!");
            req.getRequestDispatcher("edit-item.jsp").forward(req, resp);
        }
    }
    
}