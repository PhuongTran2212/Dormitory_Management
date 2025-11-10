<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<style>
    .clickable-row { cursor: pointer; }
</style>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Danh sách Sinh viên</h2>
    <a href="${pageContext.request.contextPath}/admin/students?action=add" class="btn btn-primary">Thêm Sinh viên mới</a>
</div>

<div class="card mb-4">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/students" method="get">
            <input type="hidden" name="action" value="list">
            <div class="row g-3">
                <div class="col-md-6">
                    <input type="text" class="form-control" name="searchName" placeholder="Nhập tên sinh viên..." value="<c:out value='${searchName}'/>">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-info">Tìm kiếm</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-hover table-bordered">
        <thead class="table-dark">
            <tr>
                <th style="width: 5%;">STT</th> <%-- Sửa tiêu đề cột --%>
                <th>Họ và Tên</th>
                <th>Email</th>
                <th>Phòng</th>
                <th style="width: 15%;">Hành động</th>
            </tr>
        </thead>
        <tbody>
            <%-- Thêm varStatus="loop" --%>
            <c:forEach var="student" items="${studentList}" varStatus="loop">
                <tr class='clickable-row' data-href='${pageContext.request.contextPath}/admin/students?action=view&id=${student.studentId}'>
                    <%-- Thay student.studentId bằng loop.count --%>
                    <td>${loop.count}</td>
                    <td><c:out value="${student.fullName}"/></td>
                    <td><c:out value="${student.email}"/></td>
                    <td><c:out value="${student.roomName}"/></td>
                    <td onclick="event.stopPropagation();">
                        <a href="${pageContext.request.contextPath}/admin/students?action=edit&id=${student.studentId}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/students?action=delete&id=${student.studentId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll("tr[data-href]").forEach(row => {
            row.addEventListener("click", () => {
                window.location.href = row.dataset.href;
            });
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>