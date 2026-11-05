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

@WebServlet("/add-item")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AddItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String category = req.getParameter("category");
        String description = req.getParameter("description");
        String location = req.getParameter("location");
        String phone = req.getParameter("phone");

        Part filePart = req.getPart("imageFile");
        String imageUrl = "https://via.placeholder.com/300x180?text=No+Image";

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = req.getServletContext().getRealPath("") + "uploads";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            imageUrl = "uploads/" + uniqueFileName;
        }

        Item item = new Item(title, category, description, location, imageUrl, phone, user.getId());
        boolean success = itemDAO.addItem(item);

        if (success) {
            resp.sendRedirect("index");
        } else {
            req.setAttribute("error", "Đã có lỗi xảy ra, không thể đăng tin!");
            req.getRequestDispatcher("add-item.jsp").forward(req, resp);
        }
    }
}