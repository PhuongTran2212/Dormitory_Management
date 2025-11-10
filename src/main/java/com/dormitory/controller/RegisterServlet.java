package com.dormitory.controller;

import com.dormitory.model.bean.Student;
import com.dormitory.model.bean.User;
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

@WebServlet(name = "RegisterServlet", urlPatterns = { "/register" })
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin tài khoản
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String re_pass = request.getParameter("confirmPassword");

        // Lấy thông tin hồ sơ
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mssv = request.getParameter("mssv");
        String phone = request.getParameter("phone");
        String dobString = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String hometown = request.getParameter("hometown");

        try {
            if (!pass.equals(re_pass)) {
                request.setAttribute("error", "Mật khẩu không khớp!");
                doGet(request, response);
                return;
            }
            if (userDAO.checkUsernameExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                doGet(request, response);
                return;
            }

            // Tạo User
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(pass);
            newUser.setRole("STUDENT");
            int newUserId = userDAO.addUser(newUser);

            // Tạo Student và liên kết
            Student newStudent = new Student();
            newStudent.setUserId(newUserId);
            newStudent.setFullName(fullName);
            newStudent.setEmail(email);
            newStudent.setMssv(mssv);
            newStudent.setPhone(phone);
            newStudent.setGender(gender);
            newStudent.setHometown(hometown);

            // Xử lý ngày sinh
            if (dobString != null && !dobString.isEmpty()) {
                Date dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobString);
                newStudent.setDob(dob);
            }

            studentDAO.addStudent(newStudent);

            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (SQLException | ParseException e) {
            throw new ServletException("Lỗi trong quá trình đăng ký", e);
        }
    }
}
