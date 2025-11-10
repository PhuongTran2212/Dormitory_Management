DROP DATABASE IF EXISTS dormitory_management;
CREATE DATABASE dormitory_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dormitory_management;

-- Bảng users: Chỉ chứa thông tin đăng nhập và vai trò
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(10) NOT NULL COMMENT 'ADMIN hoặc STUDENT',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
);

-- Bảng admins: Bảng mới chứa hồ sơ của Admin
CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` nvarchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
);

-- Bảng rooms: Chứa thông tin về phòng
CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_name` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_name` (`room_name`)
);

-- Bảng students: Chứa thông tin hồ sơ của sinh viên
CREATE TABLE `students` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` nvarchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `mssv` varchar(20) DEFAULT NULL,
  `gender` nvarchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `hometown` nvarchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `mssv` (`mssv`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `students_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE SET NULL
);

-- Bảng issues: Lưu các yêu cầu, báo cáo từ sinh viên
CREATE TABLE `issues` (
  `issue_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `issue_type` varchar(50) NOT NULL,
  `title` nvarchar(255) NOT NULL,
  `description` text,
  `status` varchar(20) DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`issue_id`),
  CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
);

-- Bảng devices: Bảng mới quản lý thiết bị trong phòng
CREATE TABLE `devices` (
  `device_id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` nvarchar(100) NOT NULL,
  `status` nvarchar(50) DEFAULT 'Hoạt động tốt',
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`device_id`),
  CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
);

-- --- BƯỚC 3: THÊM DỮ LIỆU MẪU ---

-- 1. Thêm tài khoản Users (3 Admin, 15 Student)
INSERT INTO `users` (`username`, `password`, `role`) VALUES
('admin', 'admin', 'ADMIN'),
('quanly01', '123456', 'ADMIN'),
('vanphong', '123456', 'ADMIN'),
('an.nv', '123456', 'STUDENT'),
('binh.ht', '123456', 'STUDENT'),
('chi.lt', '123456', 'STUDENT'),
('dung.pq', '123456', 'STUDENT'),
('giang.th', '123456', 'STUDENT'),
('ha.mv', '123456', 'STUDENT'),
('khanh.lq', '123456', 'STUDENT'),
('linh.nt', '123456', 'STUDENT'),
('minh.dv', '123456', 'STUDENT'),
('nam.tv', '123456', 'STUDENT'),
('oanh.dtk', '123456', 'STUDENT'),
('phuong.lt', '123456', 'STUDENT'),
('quan.nd', '123456', 'STUDENT'),
('son.hv', '123456', 'STUDENT'),
('tam.nt', '123456', 'STUDENT');

-- 2. Thêm hồ sơ Admins (3 Admin)
INSERT INTO `admins` (`full_name`, `email`, `phone`, `user_id`) VALUES
('Trưởng ban Quản lý', 'admin@ktx.edu.vn', '0123456789', 1),
('Nguyễn Thị Bích', 'bich.nt@ktx.edu.vn', '0987654321', 2),
('Trần Văn Cường', 'cuong.tv@ktx.edu.vn', '0911223344', 3);

-- 3. Thêm Phòng (5 phòng)
INSERT INTO `rooms` (`room_id`, `room_name`, `capacity`) VALUES
(101, 'P101-A1', 4),
(102, 'P102-A1', 4),
(201, 'P201-A2', 6),
(202, 'P202-A2', 6),
(301, 'P301-B1', 8);

-- 4. Thêm hồ sơ Students (15 Sinh viên)
INSERT INTO `students` (`full_name`, `email`, `phone`, `user_id`, `room_id`, `mssv`, `gender`, `dob`, `hometown`) VALUES
('Nguyễn Văn An', 'an.nv@email.com', '0912345678', 4, 101, '21IT001', 'Nam', '2003-05-15', 'Đà Nẵng'),
('Hoàng Thế Bình', 'binh.ht@email.com', '0923456789', 5, 101, '21IT002', 'Nam', '2003-08-20', 'Quảng Nam'),
('Lê Thị Chi', 'chi.lt@email.com', '0934567890', 6, 102, '21IT003', 'Nữ', '2003-11-25', 'Hà Nội'),
('Phạm Quốc Dũng', 'dung.pq@email.com', '0945678901', 7, 102, '21IT004', 'Nam', '2003-02-10', 'TP. Hồ Chí Minh'),
('Trần Huyền Giang', 'giang.th@email.com', '0956789012', 8, 201, '21IT005', 'Nữ', '2003-07-30', 'Huế'),
('Mai Văn Hà', 'ha.mv@email.com', '0967890123', 9, 201, '22KT006', 'Nam', '2004-01-01', 'Bình Định'),
('Lê Quốc Khánh', 'khanh.lq@email.com', '0978901234', 10, 201, '22KT007', 'Nam', '2004-03-03', 'Nghệ An'),
('Nguyễn Thùy Linh', 'linh.nt@email.com', '0989012345', 11, 202, '22KT008', 'Nữ', '2004-05-05', 'Hải Phòng'),
('Đặng Văn Minh', 'minh.dv@email.com', '0912345098', 12, 202, '22KT009', 'Nam', '2004-07-07', 'Cần Thơ'),
('Trần Văn Nam', 'nam.tv@email.com', '0923456109', 13, 301, '23NN010', 'Nam', '2005-09-09', 'Thanh Hóa'),
('Đỗ Thị Kim Oanh', 'oanh.dtk@email.com', '0934567210', 14, 301, '23NN011', 'Nữ', '2005-11-11', 'Vĩnh Phúc'),
('Lê Thu Phương', 'phuong.lt@email.com', '0945678321', 15, 301, '23NN012', 'Nữ', '2005-02-02', 'Lạng Sơn'),
('Nguyễn Đức Quân', 'quan.nd@email.com', '0956789432', 16, NULL, '23NN013', 'Nam', '2005-04-04', 'Thái Bình'),
('Hoàng Văn Sơn', 'son.hv@email.com', '0967890543', 17, NULL, '23NN014', 'Nam', '2005-06-06', 'Nam Định'),
('Nguyễn Thị Tâm', 'tam.nt@email.com', '0978901654', 18, NULL, '23NN015', 'Nữ', '2005-08-08', 'Hà Tĩnh');

-- 5. Thêm dữ liệu cho bảng `issues`
INSERT INTO `issues` (`student_id`, `issue_type`, `title`, `description`, `status`) VALUES
(1, 'DAMAGE_REPORT', 'Quạt trần phòng 101 kêu to', 'Quạt trần trong phòng P101-A1 khi bật số 3 kêu rất to, ảnh hưởng đến việc học.', 'PENDING'),
(3, 'CHANGE_REQUEST', 'Xin chuyển sang phòng 201', 'Em muốn xin chuyển sang phòng 201 để ở cùng bạn học chung lớp.', 'PENDING'),
(2, 'DAMAGE_REPORT', 'Bóng đèn bàn học bị cháy', 'Bóng đèn ở bàn học của em đã bị cháy, không sáng nữa.', 'RESOLVED'),
(5, 'DAMAGE_REPORT', 'Vòi nước bị rò rỉ', 'Vòi nước trong nhà vệ sinh phòng 201 bị rỉ nước liên tục.', 'PROCESSING');

-- 6. Thêm dữ liệu cho bảng `devices`
INSERT INTO `devices` (`device_name`, `status`, `room_id`) VALUES
('Giường tầng 1', 'Hoạt động tốt', 101),
('Bàn học 1', 'Hoạt động tốt', 101),
('Quạt trần', 'Cần sửa chữa', 101),
('Điều hòa', 'Hoạt động tốt', 101),
('Giường tầng 1', 'Hoạt động tốt', 102),
('Bàn học 1', 'Hoạt động tốt', 102),
('Quạt trần', 'Hoạt động tốt', 102),
('Điều hòa', 'Hoạt động tốt', 102),
('Giường tầng 1', 'Hoạt động tốt', 201),
('Bàn học 1', 'Hoạt động tốt', 201),
('Bóng đèn', 'Hoạt động tốt', 201);

