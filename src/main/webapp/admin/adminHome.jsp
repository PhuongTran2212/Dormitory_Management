<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dormitory.model.dao.StudentDAO" %>
<%@ page import="com.dormitory.model.dao.RoomDAO" %>
<%@ page import="com.dormitory.model.dao.IssueDAO" %>
<%
    StudentDAO studentDAO = new StudentDAO();
    RoomDAO roomDAO = new RoomDAO();
    IssueDAO issueDAO = new IssueDAO();

    int totalStudents = studentDAO.countTotalStudents();
    int totalRooms = roomDAO.countTotalRooms();
    int pendingIssues = issueDAO.countPendingIssues();
    int availableRooms = roomDAO.countAvailableRooms();

    request.setAttribute("totalStudents", totalStudents);
    request.setAttribute("totalRooms", totalRooms);
    request.setAttribute("pendingIssues", pendingIssues);
    request.setAttribute("availableRooms", availableRooms);
%>
<%@ include file="../layout/header.jsp" %>

<section class="hero-section">
  <div class="hero-overlay"></div>
  <div class="hero-content">
    <h1 class="display-4">Chào mừng Admin!</h1>
    <p class="lead">Trang tổng quan quản lý Hệ thống Ký túc xá.</p>
  </div>
</section>

<section class="stats-section text-center mb-5">
    <h2 class="section-title">Tổng quan hệ thống</h2>
    <div class="row">
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card text-white bg-primary stats-card h-100">
                <div class="card-body d-flex flex-column justify-content-center align-items-center">
                    <i class="bi bi-people-fill fs-1"></i>
                    <h3 class="card-title mt-2">${totalStudents}</h3>
                    <p class="card-text">Tổng số sinh viên</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card text-white bg-success stats-card h-100">
                <div class="card-body d-flex flex-column justify-content-center align-items-center">
                    <i class="bi bi-door-open-fill fs-1"></i>
                    <h3 class="card-title mt-2">${totalRooms}</h3>
                    <p class="card-text">Tổng số phòng</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card text-white bg-warning stats-card h-100">
                <div class="card-body d-flex flex-column justify-content-center align-items-center">
                    <i class="bi bi-exclamation-triangle-fill fs-1"></i>
                    <h3 class="card-title mt-2">${pendingIssues}</h3>
                    <p class="card-text">Yêu cầu chờ xử lý</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card text-white bg-info stats-card h-100">
                <div class="card-body d-flex flex-column justify-content-center align-items-center">
                    <i class="bi bi-house-check-fill fs-1"></i>
                    <h3 class="card-title mt-2">${availableRooms}</h3>
                    <p class="card-text">Phòng còn trống</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="news-section">
  <h2 class="section-title">Tin tức & Thông báo gần đây</h2>
  <div class="news-container">
    <article class="news-card">
      <img src="https://vcdn1-kinhdoanh.vnecdn.net/2024/10/11/dien-HN-7617-1728641579.jpg?w=1020&h=0&q=100&dpr=1&fit=crop&s=Q97oWyi6nz25MPzrzW0Swg" alt="Ảnh tin tức" />
      <div class="card-content">
        <h3>Giá điện tăng 4,8% lên hơn 2.100 đồng/kWh từ hôm nay</h3>
        <p class="card-meta">Ngày đăng: 02/08/2025</p>
        <p>Mỗi kWh điện có giá 2.103,11 đồng áp dụng từ hôm nay, theo quyết định của Tập đoàn Điện lực Việt Nam (EVN)...</p>
        <a href="https://vnexpress.net/gia-dien-tang-4-8-len-hon-2-100-dong-kwh-tu-hom-nay-4802746.html" class="read-more" target="_blank">Xem thêm</a>
      </div>
    </article>
    <article class="news-card">
      <img src="https://vcdn1-vnexpress.vnecdn.net/2012/08/12/moitruong1-1353984923.jpg?w=500&h=0&q=100&dpr=1&fit=crop&s=s3AqfgEOK2Yf8SPbpAbPig" alt="Ảnh tin tức" />
      <div class="card-content">
        <h3>Chung tay bảo vệ môi trường là trách nhiệm của cộng đồng</h3>
        <p class="card-meta">Ngày đăng: 30/07/2025</p>
        <p>Đối xử tốt, sống thân thiện với môi trường, ta sẽ tận hưởng được những giây phút thư giãn, thoải mái trong bầu không khí trong lành...</p>
        <a href="https://vnexpress.net/chung-tay-bao-ve-moi-truong-la-trach-nhiem-cua-cong-dong-2394431.html" class="read-more" target="_blank">Xem thêm</a>
      </div>
    </article>
    <article class="news-card">
      <img src="https://vcdn1-vnexpress.vnecdn.net/2025/08/02/afp-20180420-146961-v1-highres-5551-2232-1754130284.jpg?w=1020&h=0&q=100&dpr=1&fit=crop&s=_fOHXfPDATWob74YQBEvGA" alt="Ảnh tin tức" />
      <div class="card-content">
        <h3>Israel cảnh báo chiến đấu 'không ngơi nghỉ' nếu Hamas không thả con tin</h3>
        <p class="card-meta">Ngày đăng: 28/07/2025</p>
        <p>Gần đây xuất hiện một số đối tượng lạ mặt có hành vi đáng ngờ. Sinh viên cần nâng cao cảnh giác, bảo vệ...</p>
        <a href="https://vnexpress.net/israel-canh-bao-chien-dau-khong-ngoi-nghi-neu-hamas-khong-tha-con-tin-4921997.html" class="read-more" target="_blank">Xem thêm</a>
      </div>
    </article>
  </div>
</section>

<%@ include file="../layout/footer.jsp" %>