<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="card">
    <div class="card-header">
        <c:if test="${not empty room}">
            <h3>Chỉnh sửa thông tin Phòng</h3>
        </c:if>
        <c:if test="${empty room}">
            <h3>Thêm Phòng mới</h3>
        </c:if>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/rooms" method="post">
            <c:if test="${not empty room}">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="id" value="<c:out value='${room.roomId}' />" />
            </c:if>
            <c:if test="${empty room}">
                <input type="hidden" name="action" value="add" />
            </c:if>

            <div class="mb-3">
                <label for="roomName" class="form-label">Tên Phòng:</label>
                <input type="text" class="form-control" id="roomName" name="roomName" value="<c:out value='${room.roomName}' />" required>
            </div>
            <div class="mb-3">
                <label for="capacity" class="form-label">Sức chứa:</label>
                <input type="number" class="form-control" id="capacity" name="capacity" value="<c:out value='${room.capacity}' />" required min="1">
            </div>
            
            <button type="submit" class="btn btn-primary">Lưu lại</button>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>