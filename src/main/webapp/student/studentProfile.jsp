<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h3>Thông tin cá nhân</h3>
        <a href="${pageContext.request.contextPath}/studentProfile?action=edit" class="btn btn-primary">Chỉnh sửa thông tin</a>
    </div>
    <div class="card-body">
        <c:if test="${not empty student}">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Họ và Tên:</strong> <c:out value="${student.fullName}"/></p>
                    <p><strong>Mã số sinh viên:</strong> <c:out value="${student.mssv}"/></p>
                    <p><strong>Email:</strong> <c:out value="${student.email}"/></p>
                    <p><strong>Số điện thoại:</strong> <c:out value="${student.phone}"/></p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ngày sinh:</strong> <c:out value="${student.dob}"/></p>
                    <p><strong>Giới tính:</strong> <c:out value="${student.gender}"/></p>
                    <p><strong>Quê quán:</strong> <c:out value="${student.hometown}"/></p>
                    <p><strong>Phòng đang ở:</strong> 
                        <span class="badge bg-success fs-6"><c:out value="${student.roomName}"/></span>
                    </p>
                </div>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>