package com.dormitory.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dormitory.db.DBContext;
import com.dormitory.model.bean.Issue;
import com.dormitory.model.bean.Student;

public class IssueDAO {
    public void addIssue(Issue issue) {
        String sql = "INSERT INTO issues (student_id, issue_type, title, description, status) VALUES (?, ?, ?, ?, 'PENDING')";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, issue.getStudentId());
            ps.setString(2, issue.getIssueType());
            ps.setString(3, issue.getTitle());
            ps.setString(4, issue.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Issue> getIssuesByStudentId(int studentId) {
        List<Issue> list = new ArrayList<>();
        String sql = "SELECT * FROM issues WHERE student_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Issue issue = new Issue();
                    issue.setIssueId(rs.getInt("issue_id"));
                    issue.setIssueType(rs.getString("issue_type"));
                    issue.setTitle(rs.getString("title"));
                    issue.setStatus(rs.getString("status"));
                    issue.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(issue);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Issue> getAllIssues() {
        List<Issue> list = new ArrayList<>();
        String sql = "SELECT i.*, s.full_name FROM issues i " +
                "JOIN students s ON i.student_id = s.student_id " +
                "ORDER BY i.created_at ASC";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Issue issue = new Issue();
                issue.setIssueId(rs.getInt("issue_id"));
                issue.setStudentName(rs.getString("full_name"));
                issue.setTitle(rs.getString("title"));
                issue.setIssueType(rs.getString("issue_type"));
                issue.setCreatedAt(rs.getTimestamp("created_at"));
                issue.setStatus(rs.getString("status"));
                list.add(issue);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Issue getIssueById(int issueId) {
        Issue issue = null;
        String sql = "SELECT i.*, s.full_name, s.mssv, r.room_name FROM issues i " +
                "JOIN students s ON i.student_id = s.student_id " +
                "LEFT JOIN rooms r ON s.room_id = r.room_id WHERE i.issue_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, issueId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    issue = new Issue();
                    issue.setIssueId(rs.getInt("issue_id"));
                    issue.setStudentId(rs.getInt("student_id"));
                    issue.setIssueType(rs.getString("issue_type"));
                    issue.setTitle(rs.getString("title"));
                    issue.setDescription(rs.getString("description"));
                    issue.setStatus(rs.getString("status"));
                    issue.setCreatedAt(rs.getTimestamp("created_at"));
                    issue.setStudentName(rs.getString("full_name"));
                    issue.setMssv(rs.getString("mssv"));
                    issue.setRoomName(rs.getString("room_name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return issue;
    }

    public void updateIssueStatus(int issueId, String newStatus) {
        String sql = "UPDATE issues SET status = ? WHERE issue_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, issueId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Issue> searchAndSortIssues(String searchQuery) {
        List<Issue> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT i.*, s.full_name FROM issues i JOIN students s ON i.student_id = s.student_id");

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" WHERE s.full_name LIKE ? OR i.title LIKE ?");
        }

        sql.append(" ORDER BY i.created_at ASC");

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String query = "%" + searchQuery + "%";
                ps.setString(1, query);
                ps.setString(2, query);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Issue issue = new Issue();
                    issue.setIssueId(rs.getInt("issue_id"));
                    issue.setStudentId(rs.getInt("student_id"));
                    issue.setIssueType(rs.getString("issue_type"));
                    issue.setTitle(rs.getString("title"));
                    issue.setDescription(rs.getString("description"));
                    issue.setStatus(rs.getString("status"));
                    issue.setCreatedAt(rs.getTimestamp("created_at"));
                    issue.setStudentName(rs.getString("full_name"));
                    list.add(issue);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countPendingIssues() throws SQLException {
        String sql = "SELECT COUNT(*) FROM issues WHERE status = 'PENDING'";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void deleteIssue(int issueId) throws SQLException {
        String sql = "DELETE FROM issues WHERE issue_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, issueId);
            ps.executeUpdate();
        }
    }

    public void updateIssue(Issue issue) throws SQLException {
        String sql = "UPDATE issues SET title = ?, description = ?, issue_type = ? WHERE issue_id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, issue.getTitle());
            ps.setString(2, issue.getDescription());
            ps.setString(3, issue.getIssueType());
            ps.setInt(4, issue.getIssueId());
            ps.executeUpdate();
        }
    }
}
