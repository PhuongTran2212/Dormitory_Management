<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Chi tiết Sinh viên</h2>
    <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-secondary">Quay lại danh sách</a>
</div>

<div class="card">
    <div class="card-header">
        <h4><c:out value="${student.fullName}"/></h4>
    </div>
    <div class="card-body">
        <c:if test="${not empty student}">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Mã số sinh viên:</strong> <c:out value="${student.mssv}"/></p>
                    <p><strong>Email:</strong> <c:out value="${student.email}"/></p>
                    <p><strong>Số điện thoại:</strong> <c:out value="${student.phone}"/></p>
                    <p><strong>Phòng đang ở:</strong> 
                        <c:choose>
                            <c:when test="${not empty student.roomName}">
                                <span class="badge bg-success fs-6"><c:out value="${student.roomName}"/></span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">Chưa xếp phòng</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="col-md-6">
                    <p><strong>Ngày sinh:</strong> <c:out value="${student.dob}"/></p>
                    <p><strong>Giới tính:</strong> <c:out value="${student.gender}"/></p>
                    <p><strong>Quê quán:</strong> <c:out value="${student.hometown}"/></p>
                </div>
            </div>
        </c:if>
        <c:if test="${empty student}">
            <div class="alert alert-warning">Không tìm thấy thông tin sinh viên.</div>
        </c:if>
    </div>
    <div class="card-footer text-end">
        <a href="${pageContext.request.contextPath}/admin/students?action=edit&id=${student.studentId}" class="btn btn-primary">Chỉnh sửa hồ sơ</a>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>