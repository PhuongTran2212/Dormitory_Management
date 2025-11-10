package com.dormitory.model.dao;

import com.dormitory.db.DBContext;
import com.dormitory.model.bean.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private Student mapRowToStudent(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setStudentId(rs.getInt("student_id"));
        s.setFullName(rs.getString("full_name"));
        s.setEmail(rs.getString("email"));
        s.setPhone(rs.getString("phone"));
        s.setUserId(rs.getInt("user_id"));
        s.setRoomId(rs.getInt("room_id"));
        s.setMssv(rs.getString("mssv"));
        s.setGender(rs.getString("gender"));
        s.setDob(rs.getDate("dob"));
        s.setHometown(rs.getString("hometown"));
        return s;
    }

    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT s.*, r.room_name FROM students s LEFT JOIN rooms r ON s.room_id = r.room_id ORDER BY s.student_id";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student s = mapRowToStudent(rs);
                s.setRoomName(rs.getString("room_name"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Student getStudentById(int studentId) {
        String sql = "SELECT s.*, r.room_name FROM students s " +
                "LEFT JOIN rooms r ON s.room_id = r.room_id " +
                "WHERE s.student_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student student = mapRowToStudent(rs);
                    student.setRoomName(rs.getString("room_name"));
                    return student;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Student getStudentByUserId(int userId) throws SQLException {
        String sql = "SELECT s.*, r.room_name FROM students s LEFT JOIN rooms r ON s.room_id = r.room_id WHERE s.user_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student s = mapRowToStudent(rs);
                    s.setRoomName(rs.getString("room_name"));
                    return s;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Student> getStudentsByRoomId(int roomId) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE room_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToStudent(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (full_name, email, mssv, user_id, dob, gender, hometown, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getMssv());
            ps.setInt(4, student.getUserId());

            if (student.getDob() != null) {
                ps.setDate(5, new java.sql.Date(student.getDob().getTime()));
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }

            ps.setString(6, student.getGender());
            ps.setString(7, student.getHometown());
            ps.setString(8, student.getPhone());

            ps.executeUpdate();
        }
    }

    public void updateStudent(Student student) {
        String sql = "UPDATE students SET full_name = ?, email = ?, phone = ?, room_id = ?, mssv = ?, gender = ?, dob = ?, hometown = ? WHERE student_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPhone());
            ps.setInt(4, student.getRoomId());
            ps.setString(5, student.getMssv());
            ps.setString(6, student.getGender());
            ps.setDate(7, new java.sql.Date(student.getDob().getTime()));
            ps.setString(8, student.getHometown());
            ps.setInt(9, student.getStudentId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteStudent(int studentId) {
        String sql = "DELETE FROM students WHERE student_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeStudentFromRoom(int studentId) {
        String sql = "UPDATE students SET room_id = NULL WHERE student_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countStudentsInRoom(int roomId) {
        String sql = "SELECT COUNT(*) FROM students WHERE room_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Student> searchAndSortStudents(String searchName, String sortField, String sortDir) {
        List<Student> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT s.*, r.room_name FROM students s LEFT JOIN rooms r ON s.room_id = r.room_id");

        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" WHERE s.full_name LIKE ?");
        }

        if (sortField != null && !sortField.isEmpty()) {
            if ("student_id".equals(sortField) || "full_name".equals(sortField) || "email".equals(sortField)) {
                sql.append(" ORDER BY ").append(sortField);
                if ("desc".equalsIgnoreCase(sortDir)) {
                    sql.append(" DESC");
                } else {
                    sql.append(" ASC");
                }
            }
        } else {
            sql.append(" ORDER BY s.student_id ASC");
        }

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            if (searchName != null && !searchName.trim().isEmpty()) {
                ps.setString(1, "%" + searchName + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Student s = mapRowToStudent(rs);
                    s.setRoomName(rs.getString("room_name"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countTotalStudents() throws SQLException {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}