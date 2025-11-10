<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<h2>Danh sách Phòng Ký túc xá</h2>

<div class="table-responsive mt-3">
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>Tên Phòng</th>
                <th>Số người hiện tại / Sức chứa</th>
                <th>Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="room" items="${roomList}">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${not empty student && student.roomId == room.roomId}">
                                <a href="${pageContext.request.contextPath}/student/rooms?action=view&roomId=${room.roomId}" class="fw-bold text-decoration-none">
                                    ${room.roomName} (Phòng của bạn)
                                </a>
                            </c:when>
                            <c:otherwise>
                                ${room.roomName}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${room.actualOccupancy} / ${room.capacity}</td>
                    <td>
                        <c:if test="${room.actualOccupancy < room.capacity}">
                            <span class="badge bg-success">Còn trống</span>
                        </c:if>
                        <c:if test="${room.actualOccupancy >= room.capacity}">
                            <span class="badge bg-danger">Đã đầy</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="../layout/footer.jsp" %>