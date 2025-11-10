<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="card">
    <div class="card-header">
        <c:if test="${not empty device}">
            <h3>Chỉnh sửa Thiết bị</h3>
        </c:if>
        <c:if test="${empty device}">
            <h3>Thêm Thiết bị mới</h3>
        </c:if>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/devices" method="post">
            <c:if test="${not empty device}">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="deviceId" value="${device.deviceId}" />
                <input type="hidden" name="roomId" value="${device.roomId}" />
            </c:if>
            <c:if test="${empty device}">
                <input type="hidden" name="action" value="add" />
                <input type="hidden" name="roomId" value="${param.roomId}" />
            </c:if>

            <div class="mb-3">
                <label for="deviceName" class="form-label">Tên Thiết bị:</label>
                <input type="text" class="form-control" id="deviceName" name="deviceName" value="<c:out value='${device.deviceName}'/>" required>
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Trạng thái:</label>
                <select class="form-select" id="status" name="status">
                    <option value="Hoạt động tốt" ${device.status == 'Hoạt động tốt' ? 'selected' : ''}>Hoạt động tốt</option>
                    <option value="Cần sửa chữa" ${device.status == 'Cần sửa chữa' ? 'selected' : ''}>Cần sửa chữa</option>
                    <option value="Đã hỏng" ${device.status == 'Đã hỏng' ? 'selected' : ''}>Đã hỏng</option>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Lưu lại</button>
            <a href="${pageContext.request.contextPath}/admin/rooms?action=view&id=${not empty device ? device.roomId : param.roomId}" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>