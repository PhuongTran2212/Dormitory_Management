<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Chi tiết phòng: <c:out value="${room.roomName}"/></h2>
    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">Quay lại danh sách</a>
</div>

<div class="card mb-4">
    <div class="card-header">
        Thông tin phòng
    </div>
    <div class="card-body">
        <p><strong>Tên phòng:</strong> <c:out value="${room.roomName}"/></p>
        <p><strong>Sức chứa:</strong> <c:out value="${room.capacity}"/></p>
    </div>
</div>

<div class="card">
    <div class="card-header">
        Danh sách sinh viên đang ở
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>MSSV</th>
                        <th>Họ và Tên</th>
                        <th>Email</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${studentsInRoom}">
                        <tr>
                            <td><c:out value="${student.mssv}"/></td>
                            <td><c:out value="${student.fullName}"/></td>
                            <td><c:out value="${student.email}"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/students?action=edit&id=${student.studentId}" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/students?action=remove_from_room&id=${student.studentId}" class="btn btn-info btn-sm" onclick="return confirm('Xóa sinh viên này khỏi phòng?')">Xóa khỏi phòng</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty studentsInRoom}">
                        <tr>
                            <td colspan="4" class="text-center">Chưa có sinh viên nào trong phòng này.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@ include file="../layout/footer.jsp" %>