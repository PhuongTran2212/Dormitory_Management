package com.dormitory.controller;

import com.dormitory.model.bean.Issue;
import com.dormitory.model.dao.IssueDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminIssueController", urlPatterns = { "/admin/issues" })
public class AdminIssueController extends HttpServlet {

    private final IssueDAO issueDAO = new IssueDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "view":
                    showIssueDetails(request, response);
                    break;
                case "delete":
                    deleteIssue(request, response);
                    break;
                default:
                    listIssues(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error in AdminIssueController", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int issueId = Integer.parseInt(request.getParameter("issueId"));
        String newStatus = request.getParameter("status");

        issueDAO.updateIssueStatus(issueId, newStatus);
        response.sendRedirect(request.getContextPath() + "/admin/issues");
    }

    private void listIssues(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");

        List<Issue> issueList = issueDAO.searchAndSortIssues(searchQuery);

        request.setAttribute("issueList", issueList);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("/admin/adminIssue.jsp").forward(request, response);
    }

    private void showIssueDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int issueId = Integer.parseInt(request.getParameter("id"));
        Issue issue = issueDAO.getIssueById(issueId);
        request.setAttribute("issue", issue);
        request.getRequestDispatcher("/admin/adminIssueDetails.jsp").forward(request, response);
    }

    private void deleteIssue(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        issueDAO.deleteIssue(id);
        response.sendRedirect(request.getContextPath() + "/admin/issues");
    }
}