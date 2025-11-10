package com.dormitory.model.bean;

import java.util.Date;

public class Student {
    private int studentId;
    private String fullName;
    private String email;
    private String phone;
    private int userId;
    private int roomId;
    private String mssv;
    private String gender;
    private Date dob;
    private String hometown;
    private String roomName;

    public Student() {
    }

    public Student(int studentId, String fullName, String email, String phone, int userId, int roomId, String mssv,
            String gender, Date dob, String hometown, String roomName) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.userId = userId;
        this.roomId = roomId;
        this.mssv = mssv;
        this.gender = gender;
        this.dob = dob;
        this.hometown = hometown;
        this.roomName = roomName;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getMssv() {
        return mssv;
    }

    public void setMssv(String mssv) {
        this.mssv = mssv;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getHometown() {
        return hometown;
    }

    public void setHometown(String hometown) {
        this.hometown = hometown;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

}