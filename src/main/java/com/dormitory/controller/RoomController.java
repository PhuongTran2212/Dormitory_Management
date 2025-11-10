package com.dormitory.controller;

import com.dormitory.model.bean.Room;
import com.dormitory.model.bean.Student;
import com.dormitory.model.dao.RoomDAO;
import com.dormitory.model.dao.StudentDAO;
import com.dormitory.model.dao.DeviceDAO;
import com.dormitory.model.bean.Device;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RoomController", urlPatterns = { "/admin/rooms" })
public class RoomController extends HttpServlet {

    private RoomDAO roomDAO = new RoomDAO();
    private StudentDAO studentDAO = new StudentDAO();
    private final DeviceDAO deviceDAO = new DeviceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    request.getRequestDispatcher("/room/roomForm.jsp").forward(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteRoom(request, response);
                    break;
                case "view":
                    showRoomDetails(request, response);
                    break;
                default:
                    listRoom(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action.equals("add")) {
                insertRoom(request, response);
            } else if (action.equals("edit")) {
                updateRoom(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listRoom(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String roomName = request.getParameter("roomName");
        String status = request.getParameter("status");

        List<Room> roomList = roomDAO.searchRooms(roomName, status);

        request.setAttribute("roomList", roomList);
        request.setAttribute("roomName", roomName);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/room/roomList.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Room existingRoom = roomDAO.getRoomById(id);
        request.setAttribute("room", existingRoom);
        request.getRequestDispatcher("/room/roomForm.jsp").forward(request, response);
    }

    private void showRoomDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("id"));

        Room room = roomDAO.getRoomById(roomId);
        List<Student> studentsInRoom = studentDAO.getStudentsByRoomId(roomId);

        request.setAttribute("room", room);
        request.setAttribute("studentsInRoom", studentsInRoom);

        request.getRequestDispatcher("/room/roomDetail.jsp").forward(request, response);
    }

    private void insertRoom(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String roomName = request.getParameter("roomName");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        Room newRoom = new Room();
        newRoom.setRoomName(roomName);
        newRoom.setCapacity(capacity);
        roomDAO.addRoom(newRoom);
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String roomName = request.getParameter("roomName");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        Room room = new Room();
        room.setRoomId(id);
        room.setRoomName(roomName);
        room.setCapacity(capacity);
        roomDAO.updateRoom(room);
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        int studentCount = studentDAO.countStudentsInRoom(id);

        if (studentCount == 0) {
            roomDAO.deleteRoom(id);
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        } else {
            request.setAttribute("deleteError", "Không thể xóa phòng đang có sinh viên!");
            listRoom(request, response);
        }
    }
}