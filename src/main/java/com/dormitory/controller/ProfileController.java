package com.dormitory.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import com.dormitory.model.bean.Student;
import com.dormitory.model.bean.User;
import com.dormitory.model.dao.StudentDAO;
import com.dormitory.model.dao.UserDAO;

@WebServlet(name = "ProfileController", urlPatterns = { "/studentProfile" })
public class ProfileController extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                showEditForm(request, response);
            } else {
                showProfile(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi CSDL khi tải trang cá nhân", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String formType = request.getParameter("formType");

        try {
            if ("updateInfo".equals(formType)) {
                updateStudentInfo(request, response);
            } else if ("changePassword".equals(formType)) {
                changePassword(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi CSDL khi cập nhật thông tin", e);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");
        Student studentProfile = studentDAO.getStudentByUserId(user.getUserId());
        request.setAttribute("student", studentProfile);
        request.getRequestDispatcher("/student/studentProfile.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");
        Student student = studentDAO.getStudentByUserId(user.getUserId());
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student/studentUpdateProfile.jsp").forward(request, response);
    }

    private void updateStudentInfo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");
        Student student = studentDAO.getStudentByUserId(user.getUserId());

        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setHometown(request.getParameter("hometown"));

        studentDAO.updateStudent(student);

        request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        showEditForm(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");

        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (!newPass.equals(confirmPass)) {
            request.setAttribute("errorMessage", "Mật khẩu mới không khớp!");
        } else if (!userDAO.checkPassword(user.getUserId(), currentPass)) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng!");
        } else {
            userDAO.updateUserPassword(user.getUserId(), newPass);
            request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
        }
        showEditForm(request, response);
    }
}