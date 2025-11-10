package com.dormitory.model.bean;

public class Admin {
    private int adminId;
    private String fullName;
    private String email;
    private String phone;
    private int userId;

    public Admin() {
    }

    public Admin(int adminId, String fullName, String email, String phone, int userId) {
        this.adminId = adminId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.userId = userId;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}
