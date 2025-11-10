package com.dormitory.model.dao;

import com.dormitory.db.DBContext;
import com.dormitory.model.bean.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.*, COUNT(s.student_id) AS actual_occupancy " +
                "FROM rooms r LEFT JOIN students s ON r.room_id = s.room_id " +
                "GROUP BY r.room_id, r.room_name, r.capacity";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setCapacity(rs.getInt("capacity"));
                room.setActualOccupancy(rs.getInt("actual_occupancy"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin một phòng bằng ID
    public Room getRoomById(int id) {
        String sql = "SELECT * FROM rooms WHERE room_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Room room = new Room();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setRoomName(rs.getString("room_name"));
                    room.setCapacity(rs.getInt("capacity"));
                    return room;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm phòng mới
    public void addRoom(Room room) {
        String sql = "INSERT INTO rooms (room_name, capacity) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomName());
            ps.setInt(2, room.getCapacity());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin phòng
    public void updateRoom(Room room) {
        String sql = "UPDATE rooms SET room_name = ?, capacity = ? WHERE room_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomName());
            ps.setInt(2, room.getCapacity());
            ps.setInt(3, room.getRoomId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa phòng
    public void deleteRoom(int id) {
        String sql = "DELETE FROM rooms WHERE room_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countTotalRooms() throws SQLException {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int countAvailableRooms() throws SQLException {
        String sql = "SELECT COUNT(r.room_id) FROM rooms r " +
                "WHERE r.capacity > (SELECT COUNT(s.student_id) FROM students s WHERE s.room_id = r.room_id)";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Room> searchRooms(String roomName, String status) {
        List<Room> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT r.*, COUNT(s.student_id) AS actual_occupancy " +
                        "FROM rooms r LEFT JOIN students s ON r.room_id = s.room_id ");

        List<Object> params = new ArrayList<>();
        boolean hasWhere = false;

        if (roomName != null && !roomName.trim().isEmpty()) {
            sql.append(" WHERE r.room_name LIKE ?");
            params.add("%" + roomName + "%");
            hasWhere = true;
        }

        sql.append(" GROUP BY r.room_id, r.room_name, r.capacity");

        if (status != null && !status.isEmpty()) {
            if ("available".equals(status)) {
                sql.append(" HAVING COUNT(s.student_id) < r.capacity");
            } else if ("full".equals(status)) {
                sql.append(" HAVING COUNT(s.student_id) = r.capacity");
            }
        }

        sql.append(" ORDER BY r.room_name ASC");

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Room room = new Room();
                    room.setRoomId(rs.getInt("room_id"));
                    room.setRoomName(rs.getString("room_name"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setActualOccupancy(rs.getInt("actual_occupancy"));
                    list.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Room> getAllRoomsWithDeviceCount() throws SQLException {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.*, COUNT(d.device_id) AS device_count " +
                "FROM rooms r LEFT JOIN devices d ON r.room_id = d.room_id " +
                "GROUP BY r.room_id, r.room_name, r.capacity " +
                "ORDER BY r.room_name ASC";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setCapacity(rs.getInt("capacity"));
                room.setDeviceCount(rs.getInt("device_count"));
                list.add(room);
            }
        }
        return list;
    }
}
