<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<style>
    .clickable-row {
        cursor: pointer;
    }
</style>

<h2>Quản lý Yêu cầu từ Sinh viên</h2>

<div class="card my-3">
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/issues" method="get" class="row g-3 align-items-center">
            <input type="hidden" name="action" value="list">
            <div class="col-md-6">
                <input type="text" class="form-control" name="searchQuery" placeholder="Tìm theo tên SV hoặc tiêu đề..." value="<c:out value='${searchQuery}'/>">
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-info">Tìm kiếm</button>
            </div>
        </form>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th style="width: 5%;">STT</th>
                <th style="width: 15%;">Sinh viên</th>
                <th>Tiêu đề</th>
                <th style="width: 15%;">Loại</th>
                <th style="width: 15%;">Ngày gửi</th>
                <th style="width: 10%;">Trạng thái</th>
                <th style="width: 20%;">Cập nhật</th>
                <th style="width: 5%;">Xóa</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="issue" items="${issueList}" varStatus="loop">
                <tr class='clickable-row' data-href='${pageContext.request.contextPath}/admin/issues?action=view&id=${issue.issueId}'>
                    <td>${loop.count}</td>
                    <td><c:out value="${issue.studentName}"/></td>
                    <td><c:out value="${issue.title}"/></td>
                    <td>
                        <c:if test="${issue.issueType == 'DAMAGE_REPORT'}">Báo cáo Hư hại</c:if>
                        <c:if test="${issue.issueType == 'CHANGE_REQUEST'}">Yêu cầu Chuyển phòng</c:if>
                    </td>
                    <td>${issue.createdAt}</td>
                    <td>
                        <c:choose>
                            <c:when test="${issue.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ xử lý</span></c:when>
                            <c:when test="${issue.status == 'PROCESSING'}"><span class="badge bg-primary">Đang xử lý</span></c:when>
                            <c:when test="${issue.status == 'RESOLVED'}"><span class="badge bg-success">Đã giải quyết</span></c:when>
                            <c:when test="${issue.status == 'REJECTED'}"><span class="badge bg-danger">Đã từ chối</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">${issue.status}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td onclick="event.stopPropagation();">
                        <form action="${pageContext.request.contextPath}/admin/issues" method="post" class="d-flex">
                            <input type="hidden" name="issueId" value="${issue.issueId}">
                            <select name="status" class="form-select form-select-sm me-2">
                                <option value="PENDING" ${issue.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="PROCESSING" ${issue.status == 'PROCESSING' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="RESOLVED" ${issue.status == 'RESOLVED' ? 'selected' : ''}>Đã giải quyết</option>
                                <option value="REJECTED" ${issue.status == 'REJECTED' ? 'selected' : ''}>Từ chối</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm">Cập nhật</button>
                        </form>
                    </td>
                    <td onclick="event.stopPropagation();" class="text-center">
                        <c:choose>
                            <c:when test="${issue.status == 'RESOLVED' || issue.status == 'REJECTED'}">
                                <a href="${pageContext.request.contextPath}/admin/issues?action=delete&id=${issue.issueId}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa vĩnh viễn yêu cầu này?')">Xóa</a>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-secondary btn-sm" disabled title="Chỉ có thể xóa yêu cầu đã giải quyết hoặc bị từ chối">Xóa</button>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
             <c:if test="${empty issueList}">
                <tr>
                    <td colspan="8" class="text-center">Chưa có yêu cầu nào.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const rows = document.querySelectorAll("tr[data-href]");
        rows.forEach(row => {
            row.addEventListener("click", () => {
                window.location.href = row.dataset.href;
            });
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>