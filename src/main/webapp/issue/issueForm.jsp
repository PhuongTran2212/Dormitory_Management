<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="card">
    <div class="card-header">
        <c:choose>
            <c:when test="${not empty issue}">
                <h3>Chỉnh sửa Yêu cầu #${issue.issueId}</h3>
            </c:when>
            <c:otherwise>
                <h3>Tạo Yêu cầu mới</h3>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/studentIssue" method="post">
            <%-- Nếu là form sửa, thêm một input ẩn chứa issueId --%>
            <c:if test="${not empty issue}">
                <input type="hidden" name="issueId" value="${issue.issueId}">
            </c:if>
            
            <div class="mb-3">
                <label for="issueType" class="form-label">Loại yêu cầu:</label>
                <select class="form-select" id="issueType" name="issueType" required>
                    <option value="DAMAGE_REPORT" ${issue.issueType == 'DAMAGE_REPORT' ? 'selected' : ''}>Báo cáo Thiết bị Hư hại</option>
                    <option value="CHANGE_REQUEST" ${issue.issueType == 'CHANGE_REQUEST' ? 'selected' : ''}>Yêu cầu Chuyển phòng</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="title" class="form-label">Tiêu đề:</label>
                <input type="text" class="form-control" id="title" name="title" value="<c:out value='${issue.title}'/>" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Mô tả chi tiết:</label>
                <textarea class="form-control" id="description" name="description" rows="5"><c:out value='${issue.description}'/></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Lưu lại</button>
            <a href="${pageContext.request.contextPath}/studentIssue" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</div>