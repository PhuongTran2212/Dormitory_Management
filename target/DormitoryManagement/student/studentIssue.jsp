<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>
<style>
    .clickable-row { cursor: pointer; }
</style>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Lịch sử Yêu cầu/Sự cố</h2>
    <%-- SỬA LẠI ĐƯỜNG DẪN Ở ĐÂY --%>
    <a href="${pageContext.request.contextPath}/studentIssue?action=add" class="btn btn-primary">Tạo Yêu cầu mới</a>
</div>

<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>STT</th>
                <th>Tiêu đề</th>
                <th>Loại Yêu cầu</th>
                <th>Ngày gửi</th>
                <th>Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty issueList}">
                <tr><td colspan="5" class="text-center">Bạn chưa có yêu cầu nào.</td></tr>
            </c:if>
            <c:forEach var="issue" items="${issueList}" varStatus="loop">
                <%-- SỬA LẠI ĐƯỜNG DẪN Ở ĐÂY --%>
                <tr class="clickable-row" data-href="${pageContext.request.contextPath}/studentIssue?action=view&id=${issue.issueId}">
                    <td>${loop.count}</td>
                    <td><c:out value="${issue.title}" /></td>
                    <td>
                        <c:if test="${issue.issueType == 'DAMAGE_REPORT'}">Báo cáo Hư hại</c:if>
                        <c:if test="${issue.issueType == 'CHANGE_REQUEST'}">Yêu cầu Chuyển phòng</c:if>
                    </td>
                    <td><c:out value="${issue.createdAt}" /></td>
                    <td>
                        <c:choose>
                            <c:when test="${issue.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ xử lý</span></c:when>
                            <c:when test="${issue.status == 'PROCESSING'}"><span class="badge bg-primary">Đang xử lý</span></c:when>
                            <c:when test="${issue.status == 'RESOLVED'}"><span class="badge bg-success">Đã giải quyết</span></c:when>
                            <c:when test="${issue.status == 'REJECTED'}"><span class="badge bg-danger">Đã từ chối</span></c:when>
                            <c:otherwise><span class="badge bg-info">${issue.status}</span></c:otherwise>
                        </c:choose>
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