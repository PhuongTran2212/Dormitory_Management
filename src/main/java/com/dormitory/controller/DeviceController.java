package com.dormitory.controller;

import com.dormitory.model.bean.Device;
import com.dormitory.model.bean.Room;
import com.dormitory.model.dao.DeviceDAO;
import com.dormitory.model.dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DeviceController", urlPatterns = { "/admin/devices" })
public class DeviceController extends HttpServlet {

    private final DeviceDAO deviceDAO = new DeviceDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "view":
                    showDeviceDetails(request, response);
                    break;
                case "add":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteDevice(request, response);
                    break;
                default:
                    listRoomsWithDevices(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi CSDL trong DeviceController", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                insertDevice(request, response);
            } else if ("edit".equals(action)) {
                updateDevice(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi CSDL khi xử lý form thiết bị", e);
        }
    }

    private void listRoomsWithDevices(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Room> roomList = roomDAO.getAllRoomsWithDeviceCount();
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("/device/deviceListByRoom.jsp").forward(request, response);
    }

    private void showDeviceDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        Room room = roomDAO.getRoomById(roomId);
        List<Device> devicesInRoom = deviceDAO.getDevicesByRoomId(roomId);
        request.setAttribute("room", room);
        request.setAttribute("devicesInRoom", devicesInRoom);
        request.getRequestDispatcher("/device/deviceDetail.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("roomId", request.getParameter("roomId"));
        request.getRequestDispatcher("/device/deviceForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int deviceId = Integer.parseInt(request.getParameter("id"));
        Device device = deviceDAO.getDeviceById(deviceId);
        request.setAttribute("device", device);
        request.getRequestDispatcher("/device/deviceForm.jsp").forward(request, response);
    }

    private void insertDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String deviceName = request.getParameter("deviceName");
        String status = request.getParameter("status");

        Device newDevice = new Device();
        newDevice.setRoomId(roomId);
        newDevice.setDeviceName(deviceName);
        newDevice.setStatus(status);

        deviceDAO.addDevice(newDevice);
        response.sendRedirect(request.getContextPath() + "/admin/devices?action=view&roomId=" + roomId);
    }

    private void updateDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int deviceId = Integer.parseInt(request.getParameter("deviceId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String deviceName = request.getParameter("deviceName");
        String status = request.getParameter("status");

        Device device = new Device();
        device.setDeviceId(deviceId);
        device.setRoomId(roomId);
        device.setDeviceName(deviceName);
        device.setStatus(status);

        deviceDAO.updateDevice(device);
        response.sendRedirect(request.getContextPath() + "/admin/devices?action=view&roomId=" + roomId);
    }

    private void deleteDevice(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int deviceId = Integer.parseInt(request.getParameter("id"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        deviceDAO.deleteDevice(deviceId);
        response.sendRedirect(request.getContextPath() + "/admin/devices?action=view&roomId=" + roomId);
    }
}
