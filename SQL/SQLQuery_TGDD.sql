USE master
GO

CREATE DATABASE MapTGDD
	ON PRIMARY 
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
GO

USE MapTGDD
GO


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

-- Them bang nguoi dung
INSERT INTO NguoiDung VALUES('ND1', N'Nguyễn Văn',		N'Minh',		'ND01',	'BT');
INSERT INTO NguoiDung VALUES('ND2', N'Ngô Duy',			N'Nam',			'ND02',	'NK');
INSERT INTO NguoiDung VALUES('ND3', N'Phan Hải',		N'Dương',		'ND03',	'CR');
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
/*
--Ninh kieu
INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

INSERT INTO DiaChi_TGDD VALUES(
	N'',
	geometry::STGeomFromText ( 'POINT (  )', 0),
	,
		);

----------------------------------------------------------------------------------------------------------
---- Them bang xa phuong
---- Binh Thuy
--INSERT INTO XaPhuong VALUES(N'An Thới',			1);
--INSERT INTO XaPhuong VALUES(N'Long Tuyền',		1);
--INSERT INTO XaPhuong VALUES(N'Bình Thủy',		1);
--INSERT INTO XaPhuong VALUES(N'Bùi Hữu Nghĩa',	1);
--INSERT INTO XaPhuong VALUES(N'Long Hòa',		1);
--INSERT INTO XaPhuong VALUES(N'Thới An Đông',	1);
--INSERT INTO XaPhuong VALUES(N'Trà An',			1);
--INSERT INTO XaPhuong VALUES(N'Trà Nóc',			1);

---- Cai rang
--INSERT INTO XaPhuong VALUES(N'Lê Bình',		3);
--INSERT INTO XaPhuong VALUES(N'Hưng Phú',	3);
--INSERT INTO XaPhuong VALUES(N'Hưng Thạnh',	3);
--INSERT INTO XaPhuong VALUES(N'Ba Láng',		3);
--INSERT INTO XaPhuong VALUES(N'Thường Thạnh',3);
--INSERT INTO XaPhuong VALUES(N'Phú Thứ',		3);
--INSERT INTO XaPhuong VALUES(N'Tân Phú',		3);

---- Ninh Kieu
--INSERT INTO XaPhuong VALUES(N'Cái Khế',		2);
--INSERT INTO XaPhuong VALUES(N'An Hòa',		2);
--INSERT INTO XaPhuong VALUES(N'Thới Bình',	2);
--INSERT INTO XaPhuong VALUES(N'An Nghiệp',	2);
--INSERT INTO XaPhuong VALUES(N'An Cư',		2);
--INSERT INTO XaPhuong VALUES(N'Tân An',		2);
--INSERT INTO XaPhuong VALUES(N'An Phú',		2);
--INSERT INTO XaPhuong VALUES(N'Xuân Khánh',	2);
--INSERT INTO XaPhuong VALUES(N'Hưng Lợi',	2);
--INSERT INTO XaPhuong VALUES(N'An Khánh',	2);
--INSERT INTO XaPhuong VALUES(N'An Bình',		2);

---- Ô Môn
--INSERT INTO XaPhuong VALUES(N'Châu Văn Liêm',	5);
--INSERT INTO XaPhuong VALUES(N'Thới Hòa',		5);
--INSERT INTO XaPhuong VALUES(N'Thới Long',		5);
--INSERT INTO XaPhuong VALUES(N'Long Hưng',		5);
--INSERT INTO XaPhuong VALUES(N'Thới An',			5);
--INSERT INTO XaPhuong VALUES(N'Phước Thới',		5);
--INSERT INTO XaPhuong VALUES(N'Trường Lạc',		5);

---- Thot Not
--INSERT INTO XaPhuong VALUES(N'Thốt Nốt',	6);
--INSERT INTO XaPhuong VALUES(N'Thới Thuận',	6);
--INSERT INTO XaPhuong VALUES(N'Thuận An',	6);
--INSERT INTO XaPhuong VALUES(N'Tân Lộc',		6);
--INSERT INTO XaPhuong VALUES(N'Trung Nhất',	6);
--INSERT INTO XaPhuong VALUES(N'Thạnh Hòa',	6);
--INSERT INTO XaPhuong VALUES(N'Trung Kiên',	6);
--INSERT INTO XaPhuong VALUES(N'Tân Hưng',	6);
--INSERT INTO XaPhuong VALUES(N'Thuận Hưng',	6);

---- Co Do
--INSERT INTO XaPhuong VALUES(N'Thị trấn Cờ Đỏ',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Trung An',		7);
--INSERT INTO XaPhuong VALUES(N'Xã Trung Thạnh',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Phú',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Trung Hưng',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Thới Hưng',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Đông Hiệp',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Đông Thắng',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Thới Đông',	7);
--INSERT INTO XaPhuong VALUES(N'Xã Thới Xuân',	7);

---- Phong Dien
--INSERT INTO XaPhuong VALUES(N'Thị trấn Phong Điền',	4);
--INSERT INTO XaPhuong VALUES(N'Xã Nhơn Ái',			4);
--INSERT INTO XaPhuong VALUES(N'Xã Giai Xuân',		4);
--INSERT INTO XaPhuong VALUES(N'Xã Tân Thới',			4);
--INSERT INTO XaPhuong VALUES(N'Xã Trường Long',		4);
--INSERT INTO XaPhuong VALUES(N'Xã Mỹ Khánh',			4);
--INSERT INTO XaPhuong VALUES(N'Xã Nhơn Nghĩa',		4);

---- Thoi Lai
--INSERT INTO XaPhuong VALUES(N'Thị trấn Thới Lai',	8);
--INSERT INTO XaPhuong VALUES(N'Xã Thới Thạnh',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Tân Thạnh',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Xuân Thắng',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Đông Bình',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Đông Thuận',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Thới Tân',			8);
--INSERT INTO XaPhuong VALUES(N'Xã Trường Thắng',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Định Môn',			8);
--INSERT INTO XaPhuong VALUES(N'Xã Trường Thành',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Trường Xuân',		8);
--INSERT INTO XaPhuong VALUES(N'Xã Trường Xuân A',	8);
--INSERT INTO XaPhuong VALUES(N'Xã Trường Xuân B',	8);

---- Vinh Thanh
--INSERT INTO XaPhuong VALUES(N'Xã Vĩnh Bình',		9);
--INSERT INTO XaPhuong VALUES(N'Thị trấn Thanh An',	9);
--INSERT INTO XaPhuong VALUES(N'Thị trấn Vĩnh Thạnh',	9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Mỹ',			9);
--INSERT INTO XaPhuong VALUES(N'Xã Vĩnh Trinh',		9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh An',			9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Tiến',		9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Thắng',		9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Lợi',		9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Quới',		9);
--INSERT INTO XaPhuong VALUES(N'Xã Thạnh Lộc',		9);

--GO
*/
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
