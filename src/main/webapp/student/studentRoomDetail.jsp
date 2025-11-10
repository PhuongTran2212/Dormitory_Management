<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Chi tiết phòng: <c:out value="${room.roomName}"/></h2>
    <a href="${pageContext.request.contextPath}/student/rooms" class="btn btn-secondary">Quay lại danh sách</a>
</div>

<div class="card">
    <div class="card-header">
        <h3>Danh sách thành viên trong phòng</h3>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Họ và Tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="mate" items="${roommates}">
                        <tr>
                            <td>
                                <c:out value="${mate.fullName}"/>
                                <c:if test="${mate.studentId == student.studentId}">
                                    <span class="badge bg-primary ms-2">Bạn</span>
                                </c:if>
                            </td>
                            <td><c:out value="${mate.email}"/></td>
                            <td><c:out value="${mate.phone}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>