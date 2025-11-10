<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="card">
    <div class="card-header">
        <c:if test="${not empty student}">
            <h3>Chỉnh sửa thông tin Sinh viên</h3>
        </c:if>
        <c:if test="${empty student}">
            <h3>Thêm Sinh viên mới</h3>
        </c:if>
    </div>
    <div class="card-body">
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

        <form action="${pageContext.request.contextPath}/admin/students" method="post">
            <c:if test="${not empty student}">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="id" value="<c:out value='${student.studentId}' />" />
            </c:if>
            <c:if test="${empty student}">
                <input type="hidden" name="action" value="add" />
            </c:if>

            <%-- CHỈ HIỂN THỊ KHI THÊM MỚI --%>
            <c:if test="${empty student}">
                <h4>Thông tin tài khoản</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tên đăng nhập:</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Mật khẩu:</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                </div>
                <hr>
            </c:if>

            <h4>Thông tin hồ sơ</h4>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="fullName" class="form-label">Họ và Tên:</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="<c:out value='${student.fullName}' />" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="mssv" class="form-label">Mã số sinh viên:</label>
                    <input type="text" class="form-control" id="mssv" name="mssv" value="<c:out value='${student.mssv}' />" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="<c:out value='${student.email}' />" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="phone" class="form-label">Số điện thoại:</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="<c:out value='${student.phone}' />">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="dob" class="form-label">Ngày sinh:</label>
                    <input type="date" class="form-control" id="dob" name="dob" value="${student.dob}">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="gender" class="form-label">Giới tính:</label>
                    <select class="form-select" id="gender" name="gender">
                        <option value="Nam" ${student.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                        <option value="Nữ" ${student.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                        <option value="Khác" ${student.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="hometown" class="form-label">Quê quán:</label>
                    <input type="text" class="form-control" id="hometown" name="hometown" value="<c:out value='${student.hometown}' />">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="roomId" class="form-label">Phòng:</label>
                    <select class="form-select" id="roomId" name="roomId">
                        <option value="0">Chưa xếp phòng</option>
                        <c:forEach var="room" items="${roomList}">
                            <option value="${room.roomId}" ${student.roomId == room.roomId ? 'selected' : ''}>
                                <c:out value="${room.roomName}" />
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Lưu lại</button>
            <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>