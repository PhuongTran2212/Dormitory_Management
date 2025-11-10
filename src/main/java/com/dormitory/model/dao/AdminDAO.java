package com.dormitory.model.dao;

import com.dormitory.db.DBContext;
import com.dormitory.model.bean.Admin;
import java.sql.*;

public class AdminDAO {
    public Admin getAdminByUserId(int userId) throws SQLException {
        Admin admin = null;
        String sql = "SELECT * FROM admins WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    admin = new Admin();
                    admin.setAdminId(rs.getInt("admin_id"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setPhone(rs.getString("phone"));
                    admin.setUserId(rs.getInt("user_id"));
                }
            }
        }
        return admin;
    }

    public void updateAdminInfo(Admin admin) throws SQLException {
        String sql = "UPDATE admins SET full_name = ?, email = ?, phone = ? WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, admin.getFullName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getPhone());
            ps.setInt(4, admin.getUserId());
            ps.executeUpdate();
        }
    }
}