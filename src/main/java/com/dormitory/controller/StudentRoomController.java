package com.dormitory.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.dormitory.model.bean.Room;
import com.dormitory.model.bean.Student;
import com.dormitory.model.bean.User;
import com.dormitory.model.dao.RoomDAO;
import com.dormitory.model.dao.StudentDAO;

@WebServlet(name = "StudentRoomController", urlPatterns = { "/student/rooms" })
public class StudentRoomController extends HttpServlet {
    private final RoomDAO roomDAO = new RoomDAO();
    private final StudentDAO studentDAO = new StudentDAO();

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
                    showRoomDetails(request, response);
                    break;
                default:
                    listAllRooms(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error in StudentRoomController", e);
        }
    }

    private void listAllRooms(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user != null) {
            Student student = studentDAO.getStudentByUserId(user.getUserId());
            request.setAttribute("student", student);
        }

        List<Room> roomList = roomDAO.getAllRooms();
        request.setAttribute("roomList", roomList);

        request.getRequestDispatcher("/student/studentListRoom.jsp").forward(request, response);
    }

    private void showRoomDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int requestedRoomId = Integer.parseInt(request.getParameter("roomId"));
        Student currentStudent = studentDAO.getStudentByUserId(user.getUserId());

        if (currentStudent != null && currentStudent.getRoomId() == requestedRoomId) {
            Room room = roomDAO.getRoomById(requestedRoomId);
            List<Student> roommates = studentDAO.getStudentsByRoomId(requestedRoomId);

            request.setAttribute("room", room);
            request.setAttribute("roommates", roommates);
            request.setAttribute("student", currentStudent);
            request.getRequestDispatcher("/student/studentRoomDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/student/rooms");
        }
    }
}