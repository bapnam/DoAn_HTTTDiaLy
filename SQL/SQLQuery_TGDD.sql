USE master
GO

--	Tạo database
CREATE DATABASE MapTGDD
/*	ON PRIMARY 
	( 
		NAME = MapTGDD_Data,
		FILENAME = 'E:\SQL\MapTGDD\MapTGDD_Data.mdf',
		SIZE = 100MB,
		MAXSIZE = 200MB,
		Filegrowth = 20MB
	)
	LOG ON
	(
		NAME = MapTGDD_Log,
		FILENAME = 'E:\SQL\MapTGDD\MapTGDD_Log.ldf',
		SIZE = 10MB,
		MAXSIZE = 20MB,
		Filegrowth = 20MB
	)
*/
GO

USE MapTGDD
GO

/*--	Đoạn lệnh dùng để xóa database
USE master
GO

DROP DATABASE MapTGDD;
GO
*/

-- TAO BANG TINH
CREATE TABLE Tinh
(
	MaTinh		NVARCHAR(10) PRIMARY KEY,
	TenTinh		NVARCHAR(50) NOT NULL UNIQUE
);
GO
-- DROP TABLE Tinh;

-- TAO BANG QUAN HUYEN
CREATE TABLE QuanHuyen
(
	MaQH		NVARCHAR(10) PRIMARY KEY,
	TenQH		NVARCHAR(50) NOT NULL UNIQUE,
	MaTinh		NVARCHAR(10),
	CONSTRAINT fk_QH_T
		FOREIGN KEY(MaTinh) 
		REFERENCES Tinh(MaTinh)
);
GO
-- DROP TABLE QuanHuyen;

-- TAO BANG NGUOI DUNG
CREATE TABLE NguoiDung
(
	MaND	NVARCHAR(10) PRIMARY KEY,
	Ho		NVARCHAR(30),
	Ten		NVARCHAR(20),
	MatKhau	NVARCHAR(20),
	MaQH	NVARCHAR(10),
	CONSTRAINT fk_ND_QH
		FOREIGN KEY(MaQH) 
		REFERENCES QuanHuyen(MaQH)
);
GO
-- DROP TABLE NguoiDung;

-- TAO BANG DIA CHI
CREATE TABLE DiaChi_TGDD
(
	MaDC		INT IDENTITY(1,1) PRIMARY KEY,
	TenDC		NVARCHAR(200),
	ToaDo		geometry,
	MaQH		NVARCHAR(10),
	CONSTRAINT fk_DC_QH
			FOREIGN KEY(MaQH) 
			REFERENCES QuanHuyen(MaQH)
);
GO
-- DROP TABLE DiaChi_TGDD;

-- Them bang tinh
INSERT INTO Tinh VALUES('CT', N'Cần Thơ');
INSERT INTO Tinh VALUES('BL', N'Bạc Liêu');
INSERT INTO Tinh VALUES('KG', N'Kiên Giang');
INSERT INTO Tinh VALUES('CM', N'Cà Mau');

GO

-- Them bang quan huyen 
INSERT INTO QuanHuyen VALUES('BT', N'Bình Thủy',	'CT');--1
INSERT INTO QuanHuyen VALUES('NK', N'Ninh Kiều',	'CT');--2
INSERT INTO QuanHuyen VALUES('CR', N'Cái Răng',		'CT');--3
INSERT INTO QuanHuyen VALUES('PD', N'Phong Điền',	'CT');--4
INSERT INTO QuanHuyen VALUES('OM', N'Ô Môn',		'CT');--5
INSERT INTO QuanHuyen VALUES('TN', N'Thốt Nốt',		'CT');--6
INSERT INTO QuanHuyen VALUES('CD', N'Cờ Đỏ',		'CT');--7
INSERT INTO QuanHuyen VALUES('TL', N'Thới Lai',		'CT');--8
INSERT INTO QuanHuyen VALUES('VT', N'Vĩnh Thạnh',	'CT');--9
GO

-- Them Quan Huyen khac
INSERT INTO QuanHuyen VALUES('TPBL', N'TP Bạc Liêu',	'BL');
INSERT INTO QuanHuyen VALUES('TPRG', N'TP Rạch Giá',	'KG');
INSERT INTO QuanHuyen VALUES('CN', N'Cái Nước',	'CM');
INSERT INTO QuanHuyen VALUES('NC', N'Năm Căn',	'CM');
GO

-- Them bang nguoi dung
INSERT INTO NguoiDung VALUES('ND1', N'Nguyễn Văn',		N'Minh',		'ND01',	'BT');
INSERT INTO NguoiDung VALUES('ND2', N'Ngô Duy',			N'Nam',			'ND02',	'NK');
INSERT INTO NguoiDung VALUES('ND3', N'Phan Hải',		N'Dương',		'ND03',	'CR');
INSERT INTO NguoiDung VALUES('ND04', N'Ngô Duy',			N'Nam',			'12345',	'NK');

GO


-- Them bang dia chi
--Binh Thuy
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Đường Cách Mạng Tháng 8, Phường An Thới, Quận Bình Thuỷ, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.05526 105.7704 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động 115 Cách Mạng Tháng Tám, P. An Thới, Q. Bình Thủy, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.06903 105.7563 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Đường Nguyễn Chí Thanh, khu vực Thới Thuận, phường Thới An Đông, quận Bình Thuỷ, TP Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.07994 105.6902 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Đường Bùi Hữu Nghĩa (tỉnh 918), khu vực Bình Dương B, Phường Long Tuyền, Quận Bình Thủy, Thành Phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.02295 105.7185 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu vực Bình Phó B, phường Long Tuyền, quận Bình Thủy, thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.03620 105.7452 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Đường Bùi Hữu Nghĩa, Phường Long Hòa, Quận Bình Thủy, Thành Phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.05614 105.7254 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Số 189 Lê Hồng Phong, P. Trà Nóc, Q. Bình Thủy, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.10061 105.7058 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'26B/9 Lê Hồng Phong, P.Bình Thủy, Q.Bình Thủy, TP.Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.07470 105.7502 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'8A Cách Mạng Tháng 8, P. An Thới, Q. Bình Thủy, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.06086 105.7645 )', 0),
	'BT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Lô số 30A7, KCN Trà Nóc 1, P. Trà Nóc, Q. Bình Thủy, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.10006 105.7120 )', 0),
	'BT'	);
GO

--Ninh Kieu
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Số 8 Hòa Bình, P. An Cư, Q. Ninh Kiều, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.03489 105.7855 )', 0), 'NK'	);


INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động 01 Bis, KDC 91B, Đường Nguyễn Văn Linh, P.An Khánh, Q. Ninh Kiều, TP.Cần Thơ.',
	geometry::STGeomFromText ( 'POINT ( 10.02566 105.7585 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N' Thế Giới Di Động Số 43 Mậu Thân, P. An Hòa, Q. Ninh Kiều, Tp. Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.042428 105.766052 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động 172B Đường 3/2, Phường Hưng Lợi, Quận Ninh Kiều, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.023871 105.767281 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'217 đường 3/2, P.Hưng Lợi, Q.Ninh Kiều, Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.021406 105.765083 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'35B Cách Mạng Tháng 8, P.An Hòa, Q.Ninh Kiều, Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.047611 105.777679 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'552-554 Ba Mươi Tháng Tư, P. Hưng Lợi, Q. Ninh Kiều, TP. Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.016070 105.764008 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'84-86A-86-86B Đường 30/4, P. An Phú, Q.Ninh Kiều, Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.029678 105.779831 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'305V Nguyễn Văn Linh, Khu vực III, P.An Khánh, Q.Ninh Kiều, TP.Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.030640 105.752319 )', 0),
	'NK'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'403 - 405 Nguyễn Văn Cừ, Phường An Hòa, Quận Ninh Kiều, TP.Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.043965 105.765167 )', 0),
	'NK'	);
GO

--Thot Not
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Số 520, tổ 25, Quốc lộ 91, P. Thốt Nốt, Q. Thốt Nốt, Tp. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.272304 105.530273 )', 0),
	'TN'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Qui Thạnh 2, xã Trung Kiên, huyện Thốt Nốt, tỉnh Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.226715 105.552940 )', 0),
	'TN'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu vực Tân Phú, Phường Thuận Hưng, Quận Thốt Nốt, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.218019 105.578537 )', 0),
	'TN'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Thới Thạnh 2, phường Thới Thuận, quận Thốt Nốt, Tp. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.299274 105.506828 )', 0),
	'TN'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'384/17 Quốc Lộ 91, P.Thốt Nốt, Q.Thốt Nốt, cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.270742 105.531418 )', 0),
	'TN'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'571 ấp Thới hòa 1, P.Thới Thuận, Q.Thốt Nôt, TP.Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.315237 105.485909 )', 0),
	'TN'	);
GO

--Phong Dien
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Mỹ Phước, Xã Mỹ Khánh, Huyện Phong Điền, Thành Phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 9.995441 105.668999 )', 0),
	'PD'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Thới Giai, Xã Gia Xuân, Huyện Phong Điền, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 9.995441 105.668999 )', 0),
	'PD'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Trường Thuận, Xã Trường Long, Huyện Phong Điền, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 9.981348 105.634308 )', 0),
	'PD'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu dân cư thương mại huyện Phong Điền, Thị Trấn Phong Điền, Huyện Phong Điền, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 9.996312 105.669067 )', 0),
	'PD'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'168-169-170, Ấp Thị Tứ, TT. Phong Điền, H. Phong Điền, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 9.996174 105.671433 )', 0),
	'PD'	);
GO

--VinhThanh
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Quy Lân 5, xã Thạnh Quới, huyện Vĩnh Thạnh, thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.213866 105.379639 )', 0),
	'VT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Phụng Quới A, thị trấn Thạnh An, huyện Vĩnh Thạnh, thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.155253 105.322624 )', 0),
	'VT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Lô B, Số 11,13,15,17 Quốc Lộ 80, Ấp Vĩnh Tiến, Thị Trấn Vĩnh Thạnh, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.230489 105.395851 )', 0),
	'VT'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'2937 - 2939, QL 80, ấp Phụng Quới A, TT. Thạnh An, H. Vĩnh Thạnh, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.156094 105.323372 )', 0),
	'VT'	);
GO

--Cai Rang
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu Yên Hạ, P. Lê Bình, Q. Cái Răng, TP.Cần Thơ (Ngay cổng chào Lê Bình)',
	geometry::STGeomFromText ( 'POINT ( 9.999739 105.750450 )', 0),
	'CR'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu vực Phú Quới, Phường Thường Thạnh, Quận Cái Răng, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 9.958106 105.759834 )', 0),
	'CR'	);
GO

--O Mon
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu vực Thới Trinh A, Phường Thới An, Quận Ô Môn, Thành Phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.109265 105.622917 )', 0),
	'OM'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Thửa số 82, Tờ bản đồ số 59 , KV 11, p. Châu Văn Liêm, Q. Ô Môn, TP Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.109394 105.624039 )', 0),
	'OM'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Khu vực Thới Mỹ, phường Thới Long, quận Ô Môn, thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.171621 105.589134 )', 0),
	'OM'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Tân Thạnh, phường Trường Lạc, quận Ô Môn, TP. Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.055024 105.647553 )', 0),
	'OM'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động 1832 Quốc lộ 91, Khu Thới Hưng, P. Long Hưng, Q. Ô Môn, Tp. Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.148519 105.575234 )', 0),
	'OM'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Số 1066/6 Quốc Lộ 91, Khu vực 5, P.Châu Văn Liêm, Quận Ô Môn , Tp.Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.108925 105.620781 )', 0),
	'OM'	);
GO

--Co Do
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Thạnh Quới 1, Xã Trung Hưng, Huyện Cờ Đỏ, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.181620 105.478790 )', 0),
	'CD'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Ấp Thới Hòa, TT.Cờ Đỏ, H.Cờ Đỏ, TP.Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.095154 105.427620 )', 0),
	'CD'	);
GO

--Thoi Lai
INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Trường Trung, Xã Trường Thành, Huyện Thới Lai, Thành Phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.024513 105.613243 )', 0),
	'TL'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Phú Thọ, Xã Trường xuân, Huyện Thới Lai, Thành phố Cần Thơ',
	geometry::STGeomFromText ( 'POINT ( 10.004800 105.535004 )', 0),
	'TL'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Thế Giới Di Động Ấp Thới Thuận B, Thị Trấn Thới Lai, Huyện Thới Lai, Thành phố Cần Thơ ',
	geometry::STGeomFromText ( 'POINT ( 10.067349 105.562355 )', 0),
	'TL'	);

INSERT INTO DiaChi_TGDD VALUES(
	N'Ấp Thới Thuận A, TT. Thới Lai, H. Thới Lai, Cần Thơ',
	geometry::STGeomFromText ( 'POINT (10.065477 105.559349)', 0),
	'TL'	);
GO

---------------------------------------------------------------------------------------
-- Thêm thủ tục Login
CREATE PROCEDURE Sp_Account_Login @UserName varchar(10), @Password varchar(20)
AS
BEGIN
	declare @count int
	declare @res bit
	select @count = count(*) from NguoiDung where MaND = @UserName and MatKhau = @Password
	if @count > 0
		set @res = 1
	else
		set @res = 0
	select @res
END
GO

--exec Sp_Account_Login 'N1', 'ND01'
GO
