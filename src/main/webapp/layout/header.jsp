<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Quản lý Ký túc xá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Quản lý KTX</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <c:if test="${not empty sessionScope.account}">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
             <c:if test="${sessionScope.account.role == 'ADMIN'}">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/adminHome.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/students">Quản lý Sinh viên</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/rooms">Quản lý Phòng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/devices">Quản lý Thiết bị</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/issues">Quản lý Yêu cầu</a></li>
             </c:if>
             <c:if test="${sessionScope.account.role == 'STUDENT'}">
                 <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/student/studentHome.jsp">Trang chủ</a></li>
                 <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/studentProfile">Thông tin cá nhân</a></li>
                 <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/student/rooms">Quản lý Phòng</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/studentIssue">Yêu cầu/Sự cố</a></li>
             </c:if>
          </ul>
      </c:if>

      <ul class="navbar-nav ms-auto">
    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    Chào, 
                    <c:choose>
                        <c:when test="${not empty sessionScope.account.fullName}">
                            <c:out value="${sessionScope.account.fullName}"/>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${sessionScope.account.username}"/>
                        </c:otherwise>
                    </c:choose>
                </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                      <c:if test="${sessionScope.account.role == 'ADMIN'}">
                          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile">Quản lý tài khoản</a></li>
                      </c:if>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                    </ul>
                </li>
            </c:when>
            <c:otherwise>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
            </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>
<div class="container mt-4 main-container">