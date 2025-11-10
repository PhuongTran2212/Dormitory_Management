<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Thông tin tài khoản Admin</h2>
    <a href="${pageContext.request.contextPath}/admin/profile?action=edit" class="btn btn-primary">Chỉnh sửa thông tin</a>
</div>

<div class="card">
    <div class="card-body">
        <c:if test="${not empty adminInfo}">
            <p><strong>Tên đăng nhập:</strong> <c:out value="${username}"/></p>
            <p><strong>Họ và Tên:</strong> <c:out value="${adminInfo.fullName}"/></p>
            <p><strong>Email:</strong> <c:out value="${adminInfo.email}"/></p>
            <p><strong>Số điện thoại:</strong> <c:out value="${adminInfo.phone}"/></p>
        </c:if>
        <c:if test="${empty adminInfo}">
            <div class="alert alert-warning">Không tìm thấy hồ sơ của Admin.</div>
        </c:if>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>