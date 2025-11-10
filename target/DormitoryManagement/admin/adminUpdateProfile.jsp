<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="row">
    <div class="col-md-7">
        <div class="card">
            <div class="card-header"><h4>Cập nhật thông tin</h4></div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/profile" method="post">
                    <input type="hidden" name="formType" value="updateInfo">
                    <div class="mb-3">
                        <label class="form-label">Họ và Tên:</label>
                        <input type="text" class="form-control" name="fullName" value="<c:out value='${adminInfo.fullName}'/>">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email:</label>
                        <input type="email" class="form-control" name="email" value="<c:out value='${adminInfo.email}'/>">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại:</label>
                        <input type="text" class="form-control" name="phone" value="<c:out value='${adminInfo.phone}'/>">
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    <a href="${pageContext.request.contextPath}/admin/profile" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </div>
    <div class="col-md-5">
        <div class="card">
            <div class="card-header"><h4>Đổi mật khẩu</h4></div>
            <div class="card-body">
                <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>
                <c:if test="${not empty successMessage}"><div class="alert alert-success">${successMessage}</div></c:if>
                <form action="${pageContext.request.contextPath}/admin/profile" method="post">
                    <input type="hidden" name="formType" value="changePassword">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu hiện tại:</label>
                        <input type="password" class="form-control" name="currentPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới:</label>
                        <input type="password" class="form-control" name="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Xác nhận mật khẩu mới:</label>
                        <input type="password" class="form-control" name="confirmPassword" required>
                    </div>
                    <button type="submit" class="btn btn-warning">Đổi mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>