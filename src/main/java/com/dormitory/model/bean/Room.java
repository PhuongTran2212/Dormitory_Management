package com.dormitory.model.bean;

public class Room {
    private int roomId;
    private String roomName;
    private int capacity;
    private int actualOccupancy;

    public Room() {
    }

    public Room(int roomId, String roomName, int capacity, int actualOccupancy) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.capacity = capacity;
        this.actualOccupancy = actualOccupancy;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public int getActualOccupancy() {
        return actualOccupancy;
    }

    public void setActualOccupancy(int actualOccupancy) {
        this.actualOccupancy = actualOccupancy;
    }

    private int deviceCount;

    public int getDeviceCount() {
        return deviceCount;
    }

    public void setDeviceCount(int deviceCount) {
        this.deviceCount = deviceCount;
    }
}