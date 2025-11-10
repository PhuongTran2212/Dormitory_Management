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

import com.dormitory.model.bean.Issue;
import com.dormitory.model.bean.Student;
import com.dormitory.model.bean.User;
import com.dormitory.model.dao.IssueDAO;
import com.dormitory.model.dao.StudentDAO;

@WebServlet(name = "IssueController", urlPatterns = { "/studentIssue" })
public class IssueController extends HttpServlet {

    private final IssueDAO issueDAO = new IssueDAO();
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
                case "add":
                    request.getRequestDispatcher("/issue/issueForm.jsp").forward(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "view":
                    showIssueDetails(request, response);
                    break;
                default:
                    showIssueList(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error in IssueController", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String issueId = request.getParameter("issueId");

        if (issueId != null && !issueId.isEmpty()) {
            updateIssue(request, response);
        } else {
            addIssue(request, response);
        }
    }

    private void showIssueList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user != null) {
            Student student = studentDAO.getStudentByUserId(user.getUserId());
            if (student != null) {
                List<Issue> issueList = issueDAO.getIssuesByStudentId(student.getStudentId());
                request.setAttribute("issueList", issueList);
            }
        }
        request.getRequestDispatcher("/student/studentIssue.jsp").forward(request, response);
    }

    private void showIssueDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int issueId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");
        Student student = studentDAO.getStudentByUserId(user.getUserId());

        Issue issue = issueDAO.getIssueById(issueId);

        if (issue != null && student != null && issue.getStudentId() == student.getStudentId()) {
            request.setAttribute("issue", issue);
            request.getRequestDispatcher("/student/studentIssueDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/studentIssue");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int issueId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");
        Student student = studentDAO.getStudentByUserId(user.getUserId());

        Issue issue = issueDAO.getIssueById(issueId);

        if (issue != null && student != null && issue.getStudentId() == student.getStudentId() &&
                ("PENDING".equals(issue.getStatus()) || "PROCESSING".equals(issue.getStatus()))) {

            request.setAttribute("issue", issue);
            request.getRequestDispatcher("/issue/issueForm.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/studentIssue");
        }
    }

    private void addIssue(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("account");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Student student = studentDAO.getStudentByUserId(user.getUserId());
            if (student == null) {
                response.sendRedirect(request.getContextPath() + "/student/studentHome.jsp");
                return;
            }

            Issue newIssue = new Issue();
            newIssue.setStudentId(student.getStudentId());
            newIssue.setIssueType(request.getParameter("issueType"));
            newIssue.setTitle(request.getParameter("title"));
            newIssue.setDescription(request.getParameter("description"));

            issueDAO.addIssue(newIssue);
            response.sendRedirect(request.getContextPath() + "/studentIssue?action=list");
        } catch (SQLException e) {
            throw new ServletException("Database error adding issue", e);
        }
    }

    private void updateIssue(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("issueId"));

            Issue issue = new Issue();
            issue.setIssueId(id);
            issue.setIssueType(request.getParameter("issueType"));
            issue.setTitle(request.getParameter("title"));
            issue.setDescription(request.getParameter("description"));

            issueDAO.updateIssue(issue);
            response.sendRedirect(request.getContextPath() + "/studentIssue?action=list");
        } catch (SQLException e) {
            throw new ServletException("Database error updating issue", e);
        }
    }
}