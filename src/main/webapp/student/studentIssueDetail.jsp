<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Chi tiết Yêu cầu #${issue.issueId}</h2>
    <a href="${pageContext.request.contextPath}/studentIssue" class="btn btn-secondary">Quay lại danh sách</a>
</div>

<div class="card">
    <div class="card-header">
        <strong>Tiêu đề:</strong> <c:out value="${issue.title}"/>
    </div>
    <div class="card-body">
        <p><strong>Loại yêu cầu:</strong>
            <c:if test="${issue.issueType == 'DAMAGE_REPORT'}">Báo cáo Hư hại</c:if>
            <c:if test="${issue.issueType == 'CHANGE_REQUEST'}">Yêu cầu Chuyển phòng</c:if>
        </p>
        <p><strong>Ngày gửi:</strong> <c:out value="${issue.createdAt}"/></p>
        <p><strong>Trạng thái:</strong> 
             <c:choose>
                <c:when test="${issue.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ xử lý</span></c:when>
                <c:when test="${issue.status == 'PROCESSING'}"><span class="badge bg-primary">Đang xử lý</span></c:when>
                <c:when test="${issue.status == 'RESOLVED'}"><span class="badge bg-success">Đã giải quyết</span></c:when>
                <c:when test="${issue.status == 'REJECTED'}"><span class="badge bg-danger">Đã từ chối</span></c:when>
                <c:otherwise><span class="badge bg-secondary">${issue.status}</span></c:otherwise>
            </c:choose>
        </p>
        <hr>
        <h5>Nội dung chi tiết</h5>
        <p style="white-space: pre-wrap; background-color: #f8f9fa; padding: 1rem; border-radius: 5px;">
            <c:out value="${issue.description}"/>
        </p>
        <div class="mt-3">
            <c:if test="${issue.status == 'PENDING' || issue.status == 'PROCESSING'}">
                <a href="${pageContext.request.contextPath}/studentIssue?action=edit&id=${issue.issueId}" class="btn btn-warning">Chỉnh sửa Yêu cầu</a>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>