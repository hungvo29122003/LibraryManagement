CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE TaiKhoan (
   maTaiKhoan INT AUTO_INCREMENT PRIMARY KEY,
   tenDangNhap VARCHAR(255) NOT NULL,
   matKhau VARCHAR(255) NOT NULL,
   email VARCHAR(255) UNIQUE NOT NULL,
   vaiTro ENUM('QuanLy', 'ThuThu', 'DocGia') NOT NULL DEFAULT 'DocGia'
);

CREATE TABLE QuanLy (
    maQuanLy INT AUTO_INCREMENT PRIMARY KEY,
    tenQuanLy VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,    
    diaChi VARCHAR(255) CHARACTER SET UTF8MB4,
    sdt VARCHAR(15),
    email VARCHAR(255) UNIQUE NOT NULL,
    namSinh DATE
);

CREATE TABLE ThuThu (
    maThuThu INT AUTO_INCREMENT PRIMARY KEY,
    tenThuThu VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    diaChi VARCHAR(255) CHARACTER SET UTF8MB4,
    sdt VARCHAR(15),
    email VARCHAR(255) UNIQUE NOT NULL,
    namSinh DATE
);

CREATE TABLE DocGia (
    maDocGia INT AUTO_INCREMENT PRIMARY KEY,
    tenDocGia VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    cccd CHAR(12) UNIQUE NOT NULL,
    namSinh DATE,
    sdt VARCHAR(15),
    email VARCHAR(255) UNIQUE NOT NULL,
    ngayGiaNhap DATE,
    lockAccount BOOLEAN DEFAULT FALSE
);

CREATE TABLE TheLoai (
    maTheLoai INT AUTO_INCREMENT PRIMARY KEY,
    tenTheLoai VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL
);

CREATE TABLE TrangThai (
    maTrangThai INT AUTO_INCREMENT PRIMARY KEY,
    tenTrangThai VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL
);

CREATE TABLE Khu (
    maKhu INT AUTO_INCREMENT PRIMARY KEY,
    tenKhu VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    moTa TEXT CHARACTER SET UTF8MB4
);

CREATE TABLE Sach (
    maSach INT AUTO_INCREMENT PRIMARY KEY,
    tenSach VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    tacGia VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    maTheLoai INT,
    ngayXuatBan DATE,
    maTrangThai int,
    soLuong INT DEFAULT 1,
    makhu int,
    image VARCHAR(255),
    FOREIGN KEY (maTheLoai) REFERENCES TheLoai(maTheLoai) ON DELETE CASCADE,
    FOREIGN KEY (maTrangThai) REFERENCES TrangThai(maTrangThai) on delete set null,
    FOREIGN KEY (maKhu) REFERENCES Khu(maKhu) ON DELETE SET NULL
);

CREATE TABLE BaoCaoThongKe (
    maBaoCao INT AUTO_INCREMENT PRIMARY KEY,
    tenBaoCao VARCHAR(255) CHARACTER SET UTF8MB4 NOT NULL,
    maQuanLy INT,
    noiDungThongKe TEXT CHARACTER SET UTF8MB4,
    ngayLap DATE,
    FOREIGN KEY (maQuanLy) REFERENCES QuanLy(maQuanLy) ON DELETE CASCADE
);

CREATE TABLE PhieuThu (
    maPhieu INT AUTO_INCREMENT PRIMARY KEY,
    maThuThu INT,
    maDocGia INT,
    soTienThu DECIMAL(10,2),
    ngayMuon DATE,
    ngayTra DATE,
    noiDungThu TEXT CHARACTER SET UTF8MB4,
    FOREIGN KEY (maThuThu) REFERENCES ThuThu(maThuThu) ON DELETE CASCADE,
    FOREIGN KEY (maDocGia) REFERENCES DocGia(maDocGia) ON DELETE CASCADE
);

CREATE TABLE PhieuMuon (
    maPhieu INT AUTO_INCREMENT PRIMARY KEY,
    maThuThu INT,
    maDocGia INT,
    maSach INT,
    ngayTra DATE,
    FOREIGN KEY (maThuThu) REFERENCES ThuThu(maThuThu) ON DELETE CASCADE,
    FOREIGN KEY (maDocGia) REFERENCES DocGia(maDocGia) ON DELETE CASCADE,
    FOREIGN KEY (maSach) REFERENCES Sach(maSach) ON DELETE CASCADE
);

CREATE TABLE ViPham (
    maViPham INT AUTO_INCREMENT PRIMARY KEY,
    maDocGia INT,
    loaiViPham TEXT CHARACTER SET UTF8MB4 NOT NULL,
    ngayViPham DATE,
    FOREIGN KEY (maDocGia) REFERENCES DocGia(maDocGia) ON DELETE CASCADE
);

-- Thêm dữ liệu vào bảng TaiKhoan
INSERT INTO TaiKhoan (tenDangNhap, matKhau, email, vaiTro) VALUES
('admin', 'admin123', 'admin@library.com', 'QuanLy'),
('thuThu01', 'password01', 'thuthu01@library.com', 'ThuThu'),
('docGia01', 'password02', 'docgia01@library.com', 'DocGia');

-- Thêm dữ liệu vào bảng QuanLy
INSERT INTO QuanLy (tenQuanLy, diaChi, sdt, email, namSinh) VALUES
('Nguyen Van A', '123 Le Loi, Ha Noi', '0123456789', 'admin@library.com', '1985-03-12');

-- Thêm dữ liệu vào bảng ThuThu
INSERT INTO ThuThu (tenThuThu, diaChi, sdt, email, namSinh) VALUES
('Tran Thi B', '45 Tran Hung Dao, HCM', '0987654321', 'thuthu01@library.com', '1992-07-20');

-- Thêm dữ liệu vào bảng DocGia
INSERT INTO DocGia (tenDocGia, cccd, namSinh, sdt, email, ngayGiaNhap, lockAccount) VALUES
('Le Van C', '123456789012', '2001-05-15', '0912345678', 'docgia01@library.com', '2024-01-10', FALSE);

-- Thêm dữ liệu vào bảng TheLoai
INSERT INTO TheLoai (tenTheLoai) VALUES
('Khoa Học Viễn Tưởng'),
('Tiểu Thuyết'),
('Lịch Sử');

-- Thêm dữ liệu vào bảng TrangThai
INSERT INTO TrangThai (tenTrangThai) VALUES
('Có sẵn'),
('Đã mượn'),
('Đang sửa chữa');

-- Thêm dữ liệu vào bảng Khu
INSERT INTO Khu (tenKhu, moTa) VALUES
('A1', 'Khu vực sách khoa học'),
('B2', 'Khu vực sách tiểu thuyết');

-- Thêm dữ liệu vào bảng Sach
INSERT INTO Sach (tenSach, tacGia, maTheLoai, ngayXuatBan, maTrangThai, soLuong, maKhu, image) VALUES
('Dune', 'Frank Herbert', 1, '1965-08-01', 1, 5, 1, 'dune.jpg'),
('1984', 'George Orwell', 2, '1949-06-08', 1, 3, 2, '1984.jpg');

-- Thêm dữ liệu vào bảng BaoCaoThongKe
INSERT INTO BaoCaoThongKe (tenBaoCao, maQuanLy, noiDungThongKe, ngayLap) VALUES
('Thống kê tháng 2', 1, 'Báo cáo số lượng sách mượn tháng 2', '2024-02-29');

-- Thêm dữ liệu vào bảng PhieuThu
INSERT INTO PhieuThu (maThuThu, maDocGia, soTienThu, ngayMuon, ngayTra, noiDungThu) VALUES
(1, 1, 50000.00, '2024-02-01', '2024-02-15', 'Phí mượn sách tháng 2');

-- Thêm dữ liệu vào bảng PhieuMuon
INSERT INTO PhieuMuon (maThuThu, maDocGia, maSach, ngayTra) VALUES
(1, 1, 1, '2024-03-01');

-- Thêm dữ liệu vào bảng ViPham
INSERT INTO ViPham (maDocGia, loaiViPham, ngayViPham) VALUES
(1, 'Trả sách trễ', '2024-02-20');

