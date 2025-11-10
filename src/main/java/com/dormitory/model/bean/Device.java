package com.dormitory.model.bean;

public class Device {
    private int deviceId;
    private String deviceName;
    private String status;
    private int roomId;

    public Device() {
    }

    public Device(int deviceId, String deviceName, String status, int roomId) {
        this.deviceId = deviceId;
        this.deviceName = deviceName;
        this.status = status;
        this.roomId = roomId;
    }

    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

}
