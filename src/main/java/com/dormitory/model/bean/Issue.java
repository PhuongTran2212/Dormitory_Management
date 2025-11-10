package com.dormitory.model.bean;

import java.sql.Timestamp;

public class Issue {
    private int issueId;
    private int studentId;
    private String studentName;
    private String issueType;
    private String title;
    private String description;
    private String status;
    private Timestamp createdAt;
    private String mssv;
    private String roomName;

    public Issue() {
    }

    public Issue(int issueId, int studentId, String studentName, String issueType, String title, String description,
            String status, Timestamp createdAt, String mssv, String roomName) {
        this.issueId = issueId;
        this.studentId = studentId;
        this.studentName = studentName;
        this.issueType = issueType;
        this.title = title;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.mssv = mssv;
        this.roomName = roomName;
    }

    public int getIssueId() {
        return issueId;
    }

    public void setIssueId(int issueId) {
        this.issueId = issueId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getMssv() {
        return mssv;
    }

    public void setMssv(String mssv) {
        this.mssv = mssv;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

}