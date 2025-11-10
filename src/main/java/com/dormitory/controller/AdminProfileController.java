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
import com.dormitory.model.bean.User;
import com.dormitory.model.dao.AdminDAO;
import com.dormitory.model.dao.UserDAO;

@WebServlet(name = "AdminProfileController", urlPatterns = { "/admin/profile" })
public class AdminProfileController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final AdminDAO adminDAO = new AdminDAO();

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
            throw new ServletException("Lỗi CSDL khi tải trang hồ sơ Admin", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String formType = request.getParameter("formType");

        try {
            if ("updateInfo".equals(formType)) {
                updateAdminInfo(request, response);
            } else if ("changePassword".equals(formType)) {
                changePassword(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/profile");
            }
        } catch (SQLException e) {
            throw new ServletException("Lỗi CSDL khi cập nhật hồ sơ Admin", e);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("account");

        Admin adminInfo = adminDAO.getAdminByUserId(sessionUser.getUserId());

        request.setAttribute("adminInfo", adminInfo);
        request.setAttribute("username", sessionUser.getUsername());
        request.getRequestDispatcher("/admin/adminProfile.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("account");

        Admin adminInfo = adminDAO.getAdminByUserId(sessionUser.getUserId());

        request.setAttribute("adminInfo", adminInfo);
        request.getRequestDispatcher("/admin/adminUpdateProfile.jsp").forward(request, response);
    }

    private void updateAdminInfo(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("account");

        Admin adminInfo = new Admin();
        adminInfo.setUserId(sessionUser.getUserId());
        adminInfo.setFullName(request.getParameter("fullName"));
        adminInfo.setEmail(request.getParameter("email"));
        adminInfo.setPhone(request.getParameter("phone"));

        adminDAO.updateAdminInfo(adminInfo);
        response.sendRedirect(request.getContextPath() + "/admin/profile");
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
