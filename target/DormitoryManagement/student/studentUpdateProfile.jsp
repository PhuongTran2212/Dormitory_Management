<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="row">
    <%-- FORM CẬP NHẬT THÔNG TIN --%>
    <div class="col-md-7 mb-4">
        <div class="card h-100">
            <div class="card-header"><h4>Cập nhật thông tin cá nhân</h4></div>
            <div class="card-body">
                <c:if test="${not empty successMessage && (empty param.formType || param.formType == 'updateInfo')}"><div class="alert alert-success">${successMessage}</div></c:if>
                <form action="studentProfile" method="post">
                    <input type="hidden" name="formType" value="updateInfo">
                    <div class="mb-3"><label class="form-label">Họ và Tên:</label><input type="text" class="form-control" value="<c:out value='${student.fullName}'/>" readonly></div>
                    <div class="mb-3"><label class="form-label">MSSV:</label><input type="text" class="form-control" value="<c:out value='${student.mssv}'/>" readonly></div>
                    <div class="mb-3"><label class="form-label">Email:</label><input type="email" class="form-control" name="email" value="<c:out value='${student.email}'/>"></div>
                    <div class="mb-3"><label class="form-label">Số điện thoại:</label><input type="text" class="form-control" name="phone" value="<c:out value='${student.phone}'/>"></div>
                    <div class="mb-3"><label class="form-label">Quê quán:</label><input type="text" class="form-control" name="hometown" value="<c:out value='${student.hometown}'/>"></div>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    <a href="${pageContext.request.contextPath}/studentProfile" class="btn btn-secondary">Quay lại</a>
                </form>
            </div>
        </div>
    </div>

    <%-- FORM ĐỔI MẬT KHẨU --%>
    <div class="col-md-5 mb-4">
        <div class="card h-100">
            <div class="card-header"><h4>Đổi mật khẩu</h4></div>
            <div class="card-body">
                <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>
                <c:if test="${not empty successMessage && param.formType == 'changePassword'}"><div class="alert alert-success">${successMessage}</div></c:if>
                <form action="studentProfile" method="post">
                    <input type="hidden" name="formType" value="changePassword">
                    <div class="mb-3"><label class="form-label">Mật khẩu hiện tại:</label><input type="password" class="form-control" name="currentPassword" required></div>
                    <div class="mb-3"><label class="form-label">Mật khẩu mới:</label><input type="password" class="form-control" name="newPassword" required></div>
                    <div class="mb-3"><label class="form-label">Xác nhận mật khẩu mới:</label><input type="password" class="form-control" name="confirmPassword" required></div>
                    <button type="submit" class="btn btn-warning">Đổi mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>