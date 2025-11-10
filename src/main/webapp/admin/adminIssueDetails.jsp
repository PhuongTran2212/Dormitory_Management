<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Chi tiết Yêu cầu #${issue.issueId}</h2>
    <a href="${pageContext.request.contextPath}/admin/issues" class="btn btn-secondary">Quay lại danh sách</a>
</div>

<div class="card">
    <div class="card-header">
        <strong>Tiêu đề:</strong> <c:out value="${issue.title}"/>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <h5>Thông tin người gửi</h5>
                <p><strong>Tên sinh viên:</strong> <c:out value="${issue.studentName}"/></p>
                <p><strong>MSSV:</strong> <c:out value="${issue.mssv}"/></p>
                <p><strong>Phòng hiện tại:</strong> <c:out value="${issue.roomName}"/></p>
            </div>
            <div class="col-md-6">
                <h5>Thông tin yêu cầu</h5>
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
            </div>
        </div>
        <hr>
        <h5>Nội dung chi tiết</h5>
        <p style="white-space: pre-wrap; background-color: #f8f9fa; padding: 1rem; border-radius: 5px;"><c:out value="${issue.description}"/></p>
    </div>
    <div class="card-footer">
        <%-- FORM CẬP NHẬT TRẠNG THÁI --%>
        <form action="${pageContext.request.contextPath}/admin/issues" method="post" class="d-flex align-items-center">
            <input type="hidden" name="issueId" value="${issue.issueId}">
            <label for="status" class="form-label me-2 mb-0"><strong>Cập nhật trạng thái:</strong></label>
            <select name="status" id="status" class="form-select me-3" style="width: auto;">
                <option value="PENDING" ${issue.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                <option value="PROCESSING" ${issue.status == 'PROCESSING' ? 'selected' : ''}>Đang xử lý</option>
                <option value="RESOLVED" ${issue.status == 'RESOLVED' ? 'selected' : ''}>Đã giải quyết</option>
                <option value="REJECTED" ${issue.status == 'REJECTED' ? 'selected' : ''}>Từ chối</option>
            </select>
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        </form>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>