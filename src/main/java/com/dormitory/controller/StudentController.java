package com.dormitory.controller;

import com.dormitory.model.bean.Room;
import com.dormitory.model.bean.Student;
import com.dormitory.model.bean.User;
import com.dormitory.model.dao.RoomDAO;
import com.dormitory.model.dao.StudentDAO;
import com.dormitory.model.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "StudentController", urlPatterns = { "/admin/students" })
public class StudentController extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "add":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                case "remove_from_room":
                    removeStudentFromRoom(request, response);
                    break;
                case "view":
                    showStudentDetails(request, response);
                    break;
                default:
                    listStudent(request, response);
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
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "add":
                    insertStudent(request, response);
                    break;
                case "edit":
                    updateStudent(request, response);
                    break;
                default:
                    listStudent(request, response);
                    break;
            }
        } catch (SQLException | ParseException e) {
            throw new ServletException(e);
        }
    }

    private void listStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String searchName = request.getParameter("searchName");
        String sortField = request.getParameter("sortField");
        String sortDir = request.getParameter("sortDir");

        List<Student> studentList = studentDAO.searchAndSortStudents(searchName, sortField, sortDir);

        request.setAttribute("studentList", studentList);
        request.setAttribute("searchName", searchName);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortDir", sortDir);
        request.setAttribute("reverseSortDir", "asc".equals(sortDir) ? "desc" : "asc");
        request.getRequestDispatcher("/admin/adminListStudent.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Room> roomList = roomDAO.getAllRooms();
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("/admin/adminUpdateStudent.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student existingStudent = studentDAO.getStudentById(id);
        List<Room> roomList = roomDAO.getAllRooms();
        request.setAttribute("student", existingStudent);
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("/admin/adminUpdateStudent.jsp").forward(request, response);
    }

    private void showStudentDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/admin/adminStudentDetail.jsp").forward(request, response);
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {

        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        if (userDAO.checkUsernameExists(username)) {
            request.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại!");
            showNewForm(request, response);
            return;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(pass);
        newUser.setRole("STUDENT");
        int newUserId = userDAO.addUser(newUser);

        if (newUserId == 0) {
            request.setAttribute("error", "Không thể tạo tài khoản người dùng. Vui lòng thử lại.");
            showNewForm(request, response);
            return;
        }

        Student newStudent = new Student();
        newStudent.setUserId(newUserId);
        setStudentProperties(newStudent, request);

        studentDAO.addStudent(newStudent);

        response.sendRedirect(request.getContextPath() + "/admin/students");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);

        setStudentProperties(student, request);
        studentDAO.updateStudent(student);

        String newPassword = request.getParameter("newPassword");
        if (newPassword != null && !newPassword.isEmpty()) {
            userDAO.updateUserPassword(student.getUserId(), newPassword);
        }

        request.setAttribute("successMessage", "Cập nhật thông tin sinh viên thành công!");
        showEditForm(request, response);
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);
        response.sendRedirect(request.getContextPath() + "/admin/students");
    }

    private void removeStudentFromRoom(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        int studentId = Integer.parseInt(request.getParameter("id"));
        studentDAO.removeStudentFromRoom(studentId);
        response.sendRedirect(request.getContextPath() + "/admin/students");
    }

    private void setStudentProperties(Student student, HttpServletRequest request) throws ParseException {
        student.setFullName(request.getParameter("fullName"));
        student.setMssv(request.getParameter("mssv"));
        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setGender(request.getParameter("gender"));
        student.setHometown(request.getParameter("hometown"));

        String dobString = request.getParameter("dob");
        if (dobString != null && !dobString.isEmpty()) {
            Date dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobString);
            student.setDob(dob);
        }

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        if (roomId > 0) {
            student.setRoomId(roomId);
        } else {
            student.setRoomId(0);
        }
    }
}
