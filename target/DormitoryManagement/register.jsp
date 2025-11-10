<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="layout/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-body p-4">
                <h2 class="card-title text-center mb-4">Đăng ký tài khoản Sinh viên</h2>
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
                
                <form action="register" method="post">
                    <h4>Thông tin tài khoản</h4>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tên đăng nhập:</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                         <div class="col-md-6 mb-3">
                            <label class="form-label">Mã số sinh viên:</label>
                            <input type="text" class="form-control" name="mssv" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Mật khẩu:</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Xác nhận mật khẩu:</label>
                            <input type="password" class="form-control" name="confirmPassword" required>
                        </div>
                    </div>
                    <hr>
                    <h4>Thông tin hồ sơ</h4>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Họ và Tên:</label>
                            <input type="text" class="form-control" name="fullName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email:</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số điện thoại:</label>
                            <input type="tel" class="form-control" name="phone">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ngày sinh:</label>
                            <input type="date" class="form-control" name="dob" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Giới tính:</label>
                            <select name="gender" class="form-select">
                                <option value="Nam">Nam</option>
                                <option value="Nữ">Nữ</option>
                                <option value="Khác">Khác</option>
                            </select>
                        </div>
                         <div class="col-md-6 mb-3">
                            <label class="form-label">Quê quán:</label>
                            <input type="text" class="form-control" name="hometown">
                        </div>
                    </div>
                    <div class="d-grid mt-3">
                        <button type="submit" class="btn btn-primary">Đăng ký</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="layout/footer.jsp" %>