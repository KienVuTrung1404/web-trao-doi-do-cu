package com.oldthings.dao;

import com.oldthings.model.Item;
import com.oldthings.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public ItemDAO() {
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        String sql = "CREATE TABLE IF NOT EXISTS items ("
                   + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                   + "title TEXT NOT NULL, "
                   + "category TEXT NOT NULL, "
                   + "description TEXT, "
                   + "location TEXT, "
                   + "image_url TEXT, "
                   + "phone TEXT, "
                   + "status TEXT DEFAULT 'ACTIVE', "
                   + "created_date DATETIME DEFAULT CURRENT_TIMESTAMP, "
                   + "user_id INTEGER, "
                   + "FOREIGN KEY(user_id) REFERENCES users(id)"
                   + ");";
        try (Connection conn = DBContext.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            try {
                stmt.execute("ALTER TABLE items ADD COLUMN phone TEXT");
            } catch (Exception ignored) {}
            try {
                stmt.execute("ALTER TABLE items ADD COLUMN status TEXT DEFAULT 'ACTIVE'");
            } catch (Exception ignored) {}
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean addItem(Item item) {
        String sql = "INSERT INTO items(title, category, description, location, image_url, phone, status, user_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, item.getTitle());
            pstmt.setString(2, item.getCategory());
            pstmt.setString(3, item.getDescription());
            pstmt.setString(4, item.getLocation());
            pstmt.setString(5, item.getImageUrl());
            pstmt.setString(6, item.getPhone());
            pstmt.setString(7, "ACTIVE");
            pstmt.setInt(8, item.getUserId());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET title = ?, category = ?, description = ?, location = ?, phone = ?, image_url = ? WHERE id = ? AND user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, item.getTitle());
            pstmt.setString(2, item.getCategory());
            pstmt.setString(3, item.getDescription());
            pstmt.setString(4, item.getLocation());
            pstmt.setString(5, item.getPhone());
            pstmt.setString(6, item.getImageUrl());
            pstmt.setInt(7, item.getId());
            pstmt.setInt(8, item.getUserId());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean toggleStatus(int itemId, int userId) {
        Item item = getItemById(itemId);
        if (item == null || item.getUserId() != userId) return false;

        String newStatus = "ACTIVE".equals(item.getStatus()) ? "DONE" : "ACTIVE";
        String sql = "UPDATE items SET status = ? WHERE id = ? AND user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, itemId);
            pstmt.setInt(3, userId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Item mapItem(ResultSet rs) throws Exception {
        String phone = "";
        String status = "ACTIVE";
        try { phone = rs.getString("phone"); } catch (Exception ignored) {}
        try {
            String s = rs.getString("status");
            if (s != null && !s.isEmpty()) status = s;
        } catch (Exception ignored) {}

        return new Item(
            rs.getInt("id"),
            rs.getString("title"),
            rs.getString("category"),
            rs.getString("description"),
            rs.getString("location"),
            rs.getString("image_url"),
            phone,
            status,
            rs.getString("created_date"),
            rs.getInt("user_id"),
            rs.getString("username")
        );
    }

    public List<Item> getAllItems() {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.*, u.username FROM items i JOIN users u ON i.user_id = u.id ORDER BY i.id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Item> searchItems(String keyword) {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.*, u.username FROM items i JOIN users u ON i.user_id = u.id "
                   + "WHERE i.title LIKE ? OR i.category LIKE ? OR i.description LIKE ? "
                   + "ORDER BY i.id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String queryKey = "%" + keyword + "%";
            pstmt.setString(1, queryKey);
            pstmt.setString(2, queryKey);
            pstmt.setString(3, queryKey);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Item> getItemsByCategory(String category) {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.*, u.username FROM items i JOIN users u ON i.user_id = u.id WHERE i.category = ? ORDER BY i.id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Item> getItemsByUserId(int userId) {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.*, u.username FROM items i JOIN users u ON i.user_id = u.id WHERE i.user_id = ? ORDER BY i.id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteItem(int itemId, int userId) {
        String sql = "DELETE FROM items WHERE id = ? AND user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Item getItemById(int id) {
        String sql = "SELECT i.*, u.username FROM items i JOIN users u ON i.user_id = u.id WHERE i.id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapItem(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean deleteItemByAdmin(int itemId) {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}