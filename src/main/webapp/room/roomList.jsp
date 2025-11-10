<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<style>
    .clickable-row { cursor: pointer; }
</style>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Danh sách Phòng</h2>
    <a href="${pageContext.request.contextPath}/admin/rooms?action=add" class="btn btn-primary">Thêm Phòng mới</a>
</div>

<div class="card mb-4">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/rooms" method="get">
            <input type="hidden" name="action" value="list">
            <div class="row g-3">
                <div class="col-md-5">
                    <input type="text" class="form-control" name="roomName" placeholder="Tìm theo tên phòng..." value="<c:out value='${roomName}'/>">
                </div>
                <div class="col-md-5">
                    <select name="status" class="form-select">
                        <option value="">Tất cả trạng thái</option>
                        <option value="available" ${status == 'available' ? 'selected' : ''}>Còn trống</option>
                        <option value="full" ${status == 'full' ? 'selected' : ''}>Đã đầy</option>
                    </select>
                </div>
                <div class="col-md-2 d-grid">
                    <button type="submit" class="btn btn-info">Tìm kiếm</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Tên Phòng</th>
                <th>Số người hiện tại / Sức chứa</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${roomList}">
                <tr class='clickable-row' data-href='${pageContext.request.contextPath}/admin/rooms?action=view&id=${room.roomId}'>
                    <td>${room.roomId}</td>
                    <td><c:out value="${room.roomName}"/></td>
                    <td>
                        <span class="badge ${room.actualOccupancy < room.capacity ? 'bg-success' : 'bg-danger'}">
                            ${room.actualOccupancy} / ${room.capacity}
                        </span>
                    </td>
                    <td onclick="event.stopPropagation();">
                        <a href="${pageContext.request.contextPath}/admin/rooms?action=edit&id=${room.roomId}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/rooms?action=delete&id=${room.roomId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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