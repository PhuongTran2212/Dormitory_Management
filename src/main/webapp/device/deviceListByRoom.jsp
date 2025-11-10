<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<style>
    .clickable-row { cursor: pointer; }
</style>

<h2>Quản lý Thiết bị theo Phòng</h2>

<div class="table-responsive mt-3">
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>STT</th>
                <th>Tên Phòng</th>
                <th>Số lượng thiết bị</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${roomList}" varStatus="loop">
                <tr class="clickable-row" data-href="${pageContext.request.contextPath}/admin/devices?action=view&roomId=${room.roomId}">
                    <td>${loop.count}</td>
                    <td><c:out value="${room.roomName}"/></td>
                    <td><span class="badge bg-info">${room.deviceCount}</span></td>
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