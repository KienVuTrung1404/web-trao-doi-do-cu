package com.oldthings.model;

public class Item {
    private int id;
    private int userId;
    private String title;
    private String description;
    private double price;
    private String category;
    private String location;
    private String phone;
    private String imageUrl;
    private String status;
    private String createdAt;
    private String username;

    public Item() {
    }

    // Constructor dùng khi thêm mới (8 tham số)
    public Item(String title, String description, double price, String category, String location, String phone, String imageUrl, int userId) {
        this.title = title;
        this.description = description;
        this.price = price;
        this.category = category;
        this.location = location;
        this.phone = phone;
        this.imageUrl = imageUrl;
        this.userId = userId;
    }

    // Constructor đầy đủ dùng cho ItemDAO (12 tham số)
    public Item(int id, String title, String category, String description, String location, 
                String imageUrl, String phone, String status, String createdAt, int userId, String username, double price) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.description = description;
        this.location = location;
        this.imageUrl = imageUrl;
        this.phone = phone;
        this.status = status;
        this.createdAt = createdAt;
        this.userId = userId;
        this.username = username;
        this.price = price;
    }

    // Getters và Setters đầy đủ
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    // Constructor dùng khi thêm mới và chỉnh sửa tin
public Item(String title, String category, String description,
            String location, String imageUrl, String phone, int userId) {
    this.title = title;
    this.category = category;
    this.description = description;
    this.location = location;
    this.imageUrl = imageUrl;
    this.phone = phone;
    this.userId = userId;
}
    // Constructor dùng khi lấy dữ liệu từ database
    public Item(int id, String title, String category, String description,
                String location, String imageUrl, String phone,
                String status, String createdAt, int userId, String username) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.description = description;
        this.location = location;
        this.imageUrl = imageUrl;
        this.phone = phone;
        this.status = status;
        this.createdAt = createdAt;
        this.userId = userId;
        this.username = username;
    }
}