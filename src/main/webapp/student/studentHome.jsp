<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layout/header.jsp" %>

<div class="p-5 mb-4 bg-light rounded-3">
  <div class="container-fluid py-5">
    <h1 class="display-5 fw-bold">Chào mừng ${sessionScope.account.fullName}!</h1>
    <p class="col-md-8 fs-4">Sử dụng thanh điều hướng phía trên để xem thông tin hoặc gửi yêu cầu hỗ trợ.</p>
  </div>
</div>

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
        <p>Thủ tướng Israel Benjamin Netanyahu tuyên bố sẽ tiếp tục chiến dịch ở Gaza "không ngơi nghỉ" cho đến khi Hamas thả toàn bộ con tin...</p>
        <a href="https://vnexpress.net/israel-canh-bao-chien-dau-khong-ngoi-nghi-neu-hamas-khong-tha-con-tin-4921997.html" class="read-more" target="_blank">Xem thêm</a>
      </div>
    </article>
  </div>
</section>

<%@ include file="../layout/footer.jsp" %>