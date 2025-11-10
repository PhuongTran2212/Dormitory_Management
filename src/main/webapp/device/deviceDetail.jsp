<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Quản lý thiết bị - Phòng: <c:out value="${room.roomName}"/></h2>
    <a href="${pageContext.request.contextPath}/admin/devices" class="btn btn-secondary">Quay lại danh sách phòng</a>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Danh sách Thiết bị</h5>
        <a href="${pageContext.request.contextPath}/admin/devices?action=add&roomId=${room.roomId}" class="btn btn-success">
            <i class="bi bi-plus-circle-fill me-2"></i>Thêm Thiết bị
        </a>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Tên Thiết bị</th>
                        <th>Trạng thái</th>
                        <th class="text-end">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="device" items="${devicesInRoom}">
                        <tr>
                            <td><c:out value="${device.deviceName}"/></td>
                            <td>
                                <%-- THÊM MÀU SẮC CHO TRẠNG THÁI --%>
                                <c:choose>
                                    <c:when test="${device.status == 'Hoạt động tốt'}">
                                        <span class="badge bg-success">${device.status}</span>
                                    </c:when>
                                    <c:when test="${device.status == 'Cần sửa chữa'}">
                                        <span class="badge bg-warning text-dark">${device.status}</span>
                                    </c:when>
                                    <c:when test="${device.status == 'Đã hỏng'}">
                                        <span class="badge bg-danger">${device.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${device.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/admin/devices?action=edit&id=${device.deviceId}" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/devices?action=delete&id=${device.deviceId}&roomId=${room.roomId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa thiết bị này?')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty devicesInRoom}">
                        <tr>
                            <td colspan="3" class="text-center">Chưa có thiết bị nào trong phòng này.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>