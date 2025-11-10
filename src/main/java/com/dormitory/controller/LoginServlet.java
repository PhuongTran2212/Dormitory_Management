package com.dormitory.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import com.dormitory.model.bean.Admin;
import com.dormitory.model.bean.Student;
import com.dormitory.model.bean.User;
import com.dormitory.model.dao.AdminDAO;
import com.dormitory.model.dao.StudentDAO;
import com.dormitory.model.dao.UserDAO;

@WebServlet(name = "LoginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
            User account = userDAO.checkLogin(user, pass);

            if (account != null) {
                if ("STUDENT".equals(account.getRole())) {
                    Student studentProfile = studentDAO.getStudentByUserId(account.getUserId());
                    if (studentProfile != null) {
                        account.setFullName(studentProfile.getFullName());
                    }
                } else if ("ADMIN".equals(account.getRole())) {
                    Admin adminProfile = adminDAO.getAdminByUserId(account.getUserId());
                    if (adminProfile != null) {
                        account.setFullName(adminProfile.getFullName());
                    }
                }

                HttpSession session = request.getSession();
                session.setAttribute("account", account);

                if ("ADMIN".equals(account.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/adminHome.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/student/studentHome.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error during login", e);
        }
    }
}
