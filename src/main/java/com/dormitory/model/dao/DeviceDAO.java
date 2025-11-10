package com.dormitory.model.dao;

import com.dormitory.db.DBContext;
import com.dormitory.model.bean.Device;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeviceDAO {

    public List<Device> getDevicesByRoomId(int roomId) throws SQLException {
        List<Device> list = new ArrayList<>();
        String sql = "SELECT * FROM devices WHERE room_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Device device = new Device();
                    device.setDeviceId(rs.getInt("device_id"));
                    device.setDeviceName(rs.getString("device_name"));
                    device.setStatus(rs.getString("status"));
                    device.setRoomId(rs.getInt("room_id"));
                    list.add(device);
                }
            }
        }
        return list;
    }

    public Device getDeviceById(int deviceId) throws SQLException {
        String sql = "SELECT * FROM devices WHERE device_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Device device = new Device();
                    device.setDeviceId(rs.getInt("device_id"));
                    device.setDeviceName(rs.getString("device_name"));
                    device.setStatus(rs.getString("status"));
                    device.setRoomId(rs.getInt("room_id"));
                    return device;
                }
            }
        }
        return null;
    }

    public void addDevice(Device device) throws SQLException {
        String sql = "INSERT INTO devices (device_name, status, room_id) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, device.getDeviceName());
            ps.setString(2, device.getStatus());
            ps.setInt(3, device.getRoomId());
            ps.executeUpdate();
        }
    }

    public void updateDevice(Device device) throws SQLException {
        String sql = "UPDATE devices SET device_name = ?, status = ? WHERE device_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, device.getDeviceName());
            ps.setString(2, device.getStatus());
            ps.setInt(3, device.getDeviceId());
            ps.executeUpdate();
        }
    }

    public void deleteDevice(int deviceId) throws SQLException {
        String sql = "DELETE FROM devices WHERE device_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, deviceId);
            ps.executeUpdate();
        }
    }
}