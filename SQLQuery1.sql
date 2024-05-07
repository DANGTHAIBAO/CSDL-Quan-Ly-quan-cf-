/* Câu 1*/
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'db_Starbucks_Coffee')
BEGIN
    CREATE DATABASE db_Starbucks_Coffee;
    PRINT 'đã tạo CSDL "db_Starbucks_Coffee" thành công.';
END
ELSE
BEGIN
    PRINT 'CSDL "db_Starbucks_Coffee" đã tồn tại.';
END

/* Câu 2*/

CREATE TABLE NHANVIEN (
    MANV CHAR(5) PRIMARY KEY,
    TENNV NVARCHAR(100),
    MACV CHAR(3) FOREIGN KEY REFERENCES CHUCVU(MACV),
    MACN CHAR(3) FOREIGN KEY REFERENCES CHINHANH(MACN),
    NGAYSINH DATETIME,
    GIOITINH BIT,
    SODT CHAR(10),
    EMAIL NVARCHAR(50),
    DIACHI NVARCHAR(100),
    NGAYVAO DATETIME,
    NGAYNGHI DATETIME,
    CONSTRAINT CHK_NHANVIEN_GIOITINH CHECK (GIOITINH IN (0, 1))
);

CREATE TABLE CHUCVU (
    MACV CHAR(3) PRIMARY KEY,
    TENCV NVARCHAR(100)
);

CREATE TABLE CHINHANH (
    MACN CHAR(3) PRIMARY KEY,
    TENCN NVARCHAR(100),
    SODT CHAR(10),
    DIACHI NVARCHAR(100),
    HESOGIA FLOAT,
    CONSTRAINT CHK_CHINHANH_HESOGIA CHECK (HESOGIA > 0)
);

CREATE TABLE LOAITHUCUONG (
    MALOAI CHAR(5) PRIMARY KEY,
    TENLOAI NVARCHAR(100)
);

CREATE TABLE THUCUONG (
    MATU CHAR(5) PRIMARY KEY,
    MALOAI CHAR(5) FOREIGN KEY REFERENCES LOAITHUCUONG(MALOAI),
    TENTU NVARCHAR(100),
    DONGIA DECIMAL,
    CONSTRAINT CHK_THUCUONG_DONGIA CHECK (DONGIA >= 0)
);

CREATE TABLE KHUVUC (
    MAKV CHAR(3) PRIMARY KEY,
    TENKV NVARCHAR(10),
    HESOGIA FLOAT,
    CONSTRAINT CHK_KHUVUC_HESOGIA CHECK (HESOGIA > 0)
);

CREATE TABLE CONGTHUC (
    MATU CHAR(5) FOREIGN KEY REFERENCES THUCUONG(MATU),
    MANL CHAR(10) FOREIGN KEY REFERENCES NGUYENLIEU(MANL),
    SOLUONG FLOAT,
    CONSTRAINT PK_CONGTHUC PRIMARY KEY (MATU, MANL)
);

CREATE TABLE BAOCAO (
    MABC CHAR(10) PRIMARY KEY,
    MANV CHAR(5) FOREIGN KEY REFERENCES NHANVIEN(MANV),
    TENBC NVARCHAR(100),
    NGAYLAP DATETIME,
    NOIDUNG NVARCHAR(MAX)
);

CREATE TABLE NGUYENLIEU (
    MANL CHAR(10) PRIMARY KEY,
    TENNL NVARCHAR(100),
    SOLUONG FLOAT,
    DONVI NVARCHAR(25),
    CONSTRAINT CHK_NGUYENLIEU_SOLUONG CHECK (SOLUONG >= 0)
);


CREATE TABLE NHACUNGCAP (
    MANCC CHAR(5) PRIMARY KEY,
    TENNCC NVARCHAR(10),
    SODT CHAR(10),
    EMAIL NVARCHAR(50),
    DIACHI NVARCHAR(100),
    CONSTRAINT CHK_NHACUNGCAP_EMAIL CHECK (EMAIL LIKE '%@%.%')
);




CREATE TABLE PHIEUPHUTHU (
    MAPHIEUPT CHAR(10) PRIMARY KEY,
    MANV CHAR(5) FOREIGN KEY REFERENCES NHANVIEN(MANV),
    TENPPT NVARCHAR(100),
    NGAYLAP DATETIME,
    SOTIEN DECIMAL,
    CONSTRAINT CHK_PHIEUPHUTHU_SOTIEN CHECK (SOTIEN >= 0)
);


CREATE TABLE PHIEUCHI (
    MAPC CHAR(10) PRIMARY KEY,
    MANV CHAR(5) FOREIGN KEY REFERENCES NHANVIEN(MANV),
    NOIDUNGCHI NVARCHAR(MAX),
NGAYLAP DATETIME,
    TONGTIEN DECIMAL,
    CONSTRAINT CHK_PHIEUCHI_TONGTIEN CHECK (TONGTIEN >= 0)
);


CREATE TABLE PHIEUNHAP (
    MAPN CHAR(10) PRIMARY KEY,
	MANV CHAR(5) FOREIGN KEY REFERENCES NHANVIEN(MANV),
    MANCC CHAR(5) FOREIGN KEY REFERENCES NHACUNGCAP(MANCC),
    NGAYLAP DATETIME,
    TONGTIEN DECIMAL,
    CONSTRAINT CHK_PHIEUNHAP_TONGTIEN CHECK (TONGTIEN >= 0)
);


CREATE TABLE HOADON (
    MAHD NVARCHAR(20) PRIMARY KEY,
    MANV CHAR(5) FOREIGN KEY REFERENCES NHANVIEN(MANV),
    MAKV CHAR(3) FOREIGN KEY REFERENCES KHUVUC(MAKV),
    NGAYLAP DATETIME,
    TONGTIEN DECIMAL,
    CONSTRAINT CHK_HOADON_TONGTIEN CHECK (TONGTIEN >= 0)
);


CREATE TABLE CHITIET_HOADON (
    MATU CHAR(5) FOREIGN KEY REFERENCES THUCUONG(MATU),
    MAHD NVARCHAR(20) FOREIGN KEY REFERENCES HOADON(MAHD),
    SOLUONG FLOAT,
    CONSTRAINT PK_CHITIET_HOADON PRIMARY KEY (MATU, MAHD),
    CONSTRAINT CHK_CHITIET_HOADON_SOLUONG CHECK (SOLUONG >= 0)
);

CREATE TABLE CHITIET_PHIEUNHAP (
    MANL CHAR(10) FOREIGN KEY REFERENCES NGUYENLIEU(MANL),
    MAPN CHAR(10) FOREIGN KEY REFERENCES PHIEUNHAP(MAPN),
    SOLUONG FLOAT,
    CONSTRAINT PK_CHITIET_PHIEUNHAP PRIMARY KEY (MANL, MAPN),
    CONSTRAINT CHK_CHITIET_PHIEUNHAP_SOLUONG CHECK (SOLUONG >= 0)
);

/* Câu 3*/

BULK INSERT dbo.NHANVIEN
FROM 'E:\CSDL\nhanvien.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001' -- UTF-8
);


BULK INSERT CHUCVU
FROM 'E:\CSDL\chucvu.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT LOAITHUCUONG
FROM 'E:\CSDL\loaithucuong.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT THUCUONG
FROM 'E:\CSDL\thucuong.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT KHUVUC
FROM 'E:\CSDL\khuvuc.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT CONGTHUC
FROM 'E:\CSDL/congthuc.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT CHINHANH
FROM 'E:\CSDL\chinhanh.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT BAOCAO
FROM 'E:\CSDL/baocao.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);



BULK INSERT NHACUNGCAP
FROM 'E:\CSDL/nhacungcap.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT PHIEUPHUTHU
FROM 'E:\CSDL/phieuphuthu.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT PHIEUCHI
FROM 'E:\CSDL/phieuchi.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT PHIEUNHAP
FROM 'E:\CSDL/phieunhap.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT HOADON
FROM 'E:\CSDL/hoadon.csv'
WITH
(
FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT CHITIET_HOADON
FROM 'E:\CSDL/chitiethoadon.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);


BULK INSERT CHITIET_PHIEUNHAP
FROM 'E:\CSDL/chitietphieunhap.csv'
WITH
(
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

BULK INSERT NGUYENLIEU
FROM 'E:\CSDL/nguyenlieu.csv'
WITH
(
    FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = '65001' -- UTF-8
);

/*Câu 4*/
INSERT INTO HOADON (MAHD, MANV, MAKV, NGAYLAP, TONGTIEN)
VALUES ('HD101', 'NV1', 'KV1', '2024-02-12', 83000.0);


/* Câu 5*/
INSERT INTO CHITIET_HOADON (MAHD, MATU, SOLUONG)
VALUES ('HD101', 'TU10', 1);


/* Câu 6 Viết câu lệnh thêm vào bảng PHIEUCHI có mã phiếu chi là PC51, mã nhân viên là
NV5, nội dung chi là ‘rút doanh thu ngày’, ngày lập: 11/2/2024 và tổng tiền: 
15000000. */

INSERT INTO PHIEUCHI (MAPC, MANV, NOIDUNGCHI, NGAYLAP, TONGTIEN)
VALUES ('PC51', 'NV5', N'rút doanh thu ngày', '2024-02-11', 15000000);

/* Câu 7 Viết câu lệnh thêm vào bảng PHIEUNHAP có mã phiếu nhập là PN55, mã nhân 
viên là NV3, mã nhà cung cấp là NCC1, ngày lập 12/1/2024 và tổng tiền là 1200000. */

INSERT INTO PHIEUNHAP (MAPN, MANV, MANCC, NGAYLAP, TONGTIEN)
VALUES ('PN55', 'NV3', 'NC1', '2024-01-12', 1200000);

/* câu 8 Viết câu lệnh thêm vào PHIEUPHUTHU có mã phiếu phụ thu PTT63, mã nhân viên
là NV2, tên phiếu phụ thu là ‘Khách làm vỡ ly’, ngày lập 11/20/2024, số tiền phụ 
thu là 30000.*/

INSERT INTO PHIEUPHUTHU (MAPHIEUPT, MANV, TENPPT, NGAYLAP, SOTIEN)
VALUES ('PPT63', 'NV2', 'Khách làm vỡ ly', '2024-11-20', 30000.00);

/* Câu 9 Viết câu lệnh sửa tất cả mã nhân viên trong bảng PHIEUPHUTHU thành 'NV2' trong 
duy nhất ngày 14/02/2024*/
UPDATE PHIEUPHUTHU
SET MANV = 'NV2'
WHERE NGAYLAP = '2024-02-14';

/*Câu 10 Viết câu lệnh sửa TENPPT của nhân viên có mã NV3 trong ngày 30/01/2024 thành 
'Quay phim'.*/

UPDATE PHIEUPHUTHU
SET TENPPT = 'Quay phim'
WHERE MANV = 'NV3' AND CONVERT(date, NGAYLAP) = '2024-01-30';

/*Câu 11 Tăng hệ số giá thêm 1 cho khu vực có nhiều người uống nhất.*/

/* Câu 12 .Giảm 20% giá các thức uống không bán được trong tháng 1/2024.*/
UPDATE THUCUONG
SET DONGIA = DONGIA * 0.8
WHERE MATU IN (
    SELECT MATU
    FROM CHITIET_HOADON CH
    JOIN HOADON HD ON CH.MAHD = HD.MAHD
    WHERE MONTH(HD.NGAYLAP) = 1 AND YEAR(HD.NGAYLAP) = 2024
)
SELECT * FROM THUCUONG;
/* Câu 13.Tăng thêm 50% giá các thức uống bán chạy nhất.*/
UPDATE THUCUONG
SET DONGIA = DONGIA * 1.5
WHERE MATU IN (
    SELECT TOP 1 MATU
    FROM CHITIET_HOADON
    GROUP BY MATU
    ORDER BY COUNT(*) DESC
)

/*Câu 14 Viết câu lệnh xóa báo cáo của một nhân viên với MANV=NV5 vào ngày 31/01/2024*/
DELETE FROM BAOCAO
WHERE MANV = 'NV5' AND CONVERT(date, NGAYLAP) = '2024-01-31'


/* Câu 15  Viết câu lệnh xóa phiếu phụ thu của nhân viên có mã là NV3 đã lập vào ngày 
21/09/2023.*/
DELETE FROM PHIEUPHUTHU
WHERE MANV = 'NV3' AND CONVERT(date, NGAYLAP) = '2023-09-21'

/* Câu 16 Xuất ra danh sách các thức uống có loại là Tea (mã: tea)*/
SELECT *
FROM THUCUONG
WHERE MALOAI = 'tea';


/*17.Xuất ra danh sách thức uống không chứa nguyên liệu sữa đặc.*/
SELECT *
FROM THUCUONG
WHERE MATU NOT IN (SELECT MATU FROM NGUYENLIEU WHERE TENNL = 'Sữa đặc');

/*18.Xuất ra danh sách những loại thức uống có giá thấp hơn 50 ngàn.*/
SELECT *
FROM THUCUONG
WHERE DONGIA < 50000;

/*19.Hãy lọc ra những nguyên liệu được cung cấp bởi nhà cung cấp NCC1.*/
SELECT *
FROM NGUYENLIEU
WHERE MANCC = 'NC1';

/*20.Viết câu lệnh thống kê toàn bộ những nhà cung cấp đang cấp hàng cho hệ thống.*/
SELECT DISTINCT MANCC
FROM PHIEUNHAP;

/*21.Hãy liệt kê danh sách nhân viên theo chi nhánh 1, 2, 3.*/
SELECT *
FROM NHANVIEN
WHERE MACN IN ('CN1', 'CN2', 'CN3');


/*22.Viết câu lệnh để liệt kê thức uống bán nhiều nhất.*/
SELECT TOP 1 *
FROM THUCUONG
ORDER BY DONGIA DESC;

/*23.Viết câu lệnh tìm khu vực khách hàng chọn nhiều nhất.*/
SELECT TOP 1 MAKV
FROM HOADON
GROUP BY MAKV
ORDER BY COUNT(*) DESC;


/*24.Viết câu lệnh thống kê tổng chi theo từng quý.*/
SELECT DATEPART(QUARTER, NGAYLAP) AS QUARTER,
       SUM(TONGTIEN) AS TOTAL_EXPENSE
FROM PHIEUCHI
GROUP BY DATEPART(QUARTER, NGAYLAP);

/*25.Viết câu lệnh để thống kê tổng phụ thu.*/
SELECT SUM(SOTIEN) AS TOTAL_SURCHARGE
FROM PHIEUPHUTHU;

/*26.Viết câu lệnh để tính doanh thu toàn hệ thống năm 2023.*/
SELECT SUM(TONGTIEN) AS TOTAL_REVENUE
FROM HOADON
WHERE YEAR(NGAYLAP) = 2023;

/*27.Viết câu lệnh để tính doanh thu toàn hệ thống của quý 1 năm 2024.*/
SELECT SUM(TONGTIEN) AS TOTAL_REVENUE
FROM HOADON
WHERE YEAR(NGAYLAP) = 2024 AND DATEPART(QUARTER, NGAYLAP) = 1;

/*28.Tính lợi nhuận toàn hệ thống năm 2023.*/
SELECT (SELECT SUM(TONGTIEN) FROM HOADON WHERE YEAR(NGAYLAP) = 2023) - (SELECT SUM(TONGTIEN) FROM PHIEUCHI WHERE YEAR(NGAYLAP) = 2023) AS PROFIT_2023;

/*29.Tính lợi nhuận theo từng chi nhánh.*/

/*30.Thống kê số lượng tồn của tất cả các nguyên liệu còn dưới mức quy định.*/


/*31.Liệt kê loại nguyên liệu được sử dụng nhiều nhất.*/
SELECT MANL, COUNT(*) AS USAGE_COUNT
FROM CHITIET_PHIEUNHAP
GROUP BY MANL
ORDER BY COUNT(*) DESC;

/*32.Hãy viết thủ tục thêm một nhân viên mới vào bảng NHANVIEN với tham số truyền 
vào là mã nhân viên, tên nhân viên, mã chức chức vụ, mã chi nhánh, giới tính, ngày 
vào, ngày nghĩ (có thể null). Kiểm tra ngày vào phải lớn hơn ngày thành lập hệ thống
(01/01/2020) và ràng buộc tồn tại các mã chức vụ, mã chi nhánh. */

/*33.Viết thủ tục thêm một thức uống vào bảng THUCUONG với tham số truyền vào là 
mã thức uống, mã loại thức uống, tên thức uống, đơn giá. Kiểm tra tham số vào 
(kiểm tra tồn tại mã loại thức uống). */
CREATE PROCEDURE ThemThucUong 
    @MATU CHAR(5),
    @MALOAI CHAR(5),
    @TENTU NVARCHAR(100),
    @DONGIA DECIMAL(18, 2)
AS
BEGIN
    -- Kiểm tra tồn tại của mã loại thức uống
    IF NOT EXISTS (SELECT * FROM LOAITHUCUONG WHERE MALOAI = @MALOAI)
    BEGIN
        PRINT 'Mã loại thức uống không tồn tại.';
        RETURN;
    END

    -- Thêm thức uống vào bảng THUCUONG
    INSERT INTO THUCUONG (MATU, MALOAI, TENTU, DONGIA)
    VALUES (@MATU, @MALOAI, @TENTU, @DONGIA);

    PRINT 'Thêm thức uống thành công.';
END;

/*34.Viết thủ tục thêm mới một loại thức uống mới vào bảng LOAITHUCUONG với 
tham số truyền vào là mã loại, tên loại thức uống. */
CREATE PROCEDURE ThemLoaiThucUong 
    @MALOAI CHAR(5),
    @TENLOAI NVARCHAR(100)
AS
BEGIN
    -- Thêm loại thức uống vào bảng LOAITHUCUONG
    INSERT INTO LOAITHUCUONG (MALOAI, TENLOAI)
    VALUES (@MALOAI, @TENLOAI);

    PRINT 'Thêm loại thức uống thành công.';
END;

/*35. Viết thủ tục thêm mới một nguyên vào bảng NGUYENLIEU với tham số đầu vào 
là mã nguyên liệu, tên nguyên liệu, số lượng, đơn vị. */
CREATE PROCEDURE ThemNguyenLieu 
    @MANL CHAR(10),
    @TENNL NVARCHAR(100),
    @SOLUONG FLOAT,
    @DONVI NVARCHAR(25)
AS
BEGIN
    -- Thêm nguyên liệu vào bảng NGUYENLIEU
    INSERT INTO NGUYENLIEU (MANL, TENNL, SOLUONG, DONVI)
    VALUES (@MANL, @TENNL, @SOLUONG, @DONVI);

    PRINT 'Thêm nguyên liệu thành công.';
END;

/*36.Viết thủ tục để cập nhật thông tin của một thức uống trong bảng THUCUONG với 
tham số đầu vào là mã thức uống, mã loại thức uống, tên thức uống, đơn giá. Kiểm 
tra ràng buộc tồn tại thức uống và mã loại thức uống.*/
CREATE PROCEDURE CapNhatThucUong 
    @MATU CHAR(5),
    @MALOAI CHAR(5),
    @TENTU NVARCHAR(100),
    @DONGIA DECIMAL
AS
BEGIN
    -- Kiểm tra xem thức uống và mã loại thức uống tồn tại
    IF EXISTS (SELECT 1 FROM THUCUONG WHERE MATU = @MATU AND MALOAI = @MALOAI)
    BEGIN
        -- Cập nhật thông tin thức uống
        UPDATE THUCUONG
        SET TENTU = @TENTU,
            DONGIA = @DONGIA
        WHERE MATU = @MATU;

        PRINT 'Cập nhật thông tin thức uống thành công.';
    END
    ELSE
    BEGIN
        PRINT 'Thức uống hoặc mã loại thức uống không tồn tại.';
    END;
END;


/*37.Viết thủ tục liệt kê các thức uống thuộc một loại thức uống bất kì, với tham số truyền 
vào là tên loại. Kiểm tra ràng buộc tồn tại tên loại. */
CREATE PROCEDURE LietKeThucUongTheoLoai 
    @TENLOAI NVARCHAR(100)
AS
BEGIN
    -- Kiểm tra xem tên loại thức uống tồn tại
    IF EXISTS (SELECT 1 FROM LOAITHUCUONG WHERE TENLOAI = @TENLOAI)
    BEGIN
        -- Liệt kê các thức uống thuộc loại thức uống có tên là @TENLOAI
        SELECT T.*
        FROM THUCUONG T
        INNER JOIN LOAITHUCUONG L ON T.MALOAI = L.MALOAI
        WHERE L.TENLOAI = @TENLOAI;

        PRINT 'Danh sách các thức uống thuộc loại ' + @TENLOAI;
    END
    ELSE
    BEGIN
        PRINT 'Loại thức uống không tồn tại.';
    END;
END;

/*38.Viết thủ tục liệt kê thông tin tất cả các nguyên liệu (tên nguyên liệu, số lượng tồn 
kho, đơn vị) của một thức uống bất kì, với tham số truyền vào là tên thức uống. Kiểm 
tra ràng buộc tồn tại tên thức uống. */


/*39.Viết thủ tục dùng để tìm những thức uống không bán được của chi nhánh bất kì trong 
khoảng thời gian nào đó. Với tham số đầu vào là tên chi nhánh, thời gian bắt đầu và 
thời gian kết thúc. */
CREATE PROCEDURE TimThucUongKhongBanDuoc 
    @TEN_CN NVARCHAR(100),
    @NGAY_BAT_DAU DATETIME,
    @NGAY_KET_THUC DATETIME
AS
BEGIN
    -- Tìm những thức uống không bán được của chi nhánh trong khoảng thời gian
    SELECT DISTINCT TU.TENTU
    FROM THUCUONG TU
    LEFT JOIN CHITIET_HOADON CT ON TU.MATU = CT.MATU
    LEFT JOIN HOADON HD ON CT.MAHD = HD.MAHD
    LEFT JOIN CHINHANH CN ON HD.MANV = CN.MACN -- Điều chỉnh tên cột tham gia
    WHERE CN.TENCN = @TEN_CN
    AND (HD.NGAYLAP BETWEEN @NGAY_BAT_DAU AND @NGAY_KET_THUC)
    AND CT.MATU IS NULL;

    PRINT 'Danh sách thức uống không bán được của chi nhánh ' + @TEN_CN + ' trong khoảng từ ' + CONVERT(NVARCHAR(20), @NGAY_BAT_DAU, 103) + ' đến ' + CONVERT(NVARCHAR(20), @NGAY_KET_THUC, 103);
END;

/*40.Viết thủ tục liệt kê tên các nguyên liệu của một nhà cung cấp bất kì, với tham số đầu 
vào là tên nhà cung cấp, kiểm tra ràng buộc tồn tại tên nhà cung cấp. */

CREATE PROCEDURE LietKeNguyenLieuCuaNhaCungCap 
    @TEN_NCC NVARCHAR(100)
AS
BEGIN
    -- Kiểm tra xem tên nhà cung cấp có tồn tại không
    IF NOT EXISTS (SELECT * FROM NHACUNGCAP WHERE TENNCC = @TEN_NCC)
    BEGIN
        PRINT 'Tên nhà cung cấp không tồn tại.';
        RETURN;
    END;

    -- Liệt kê tên các nguyên liệu của nhà cung cấp
    SELECT NL.TENNL
    FROM NGUYENLIEU NL
    WHERE NL.MANL = (SELECT MANCC FROM NHACUNGCAP WHERE TENNCC = @TEN_NCC);

    PRINT 'Danh sách các nguyên liệu của nhà cung cấp ' + @TEN_NCC;
END;

/*41.Viết thủ tục tăng giá của một thức uống bất kì với tham số truyền vào là tên thức 
uống và hệ số giá. Điều kiện tên thức uống tồn tại và hệ số tăng giá phải nhỏ hơn 1
đồng thời không nhỏ hơn -0.5.*/
CREATE PROCEDURE TangGiaThucUong 
    @TEN_THUC_UONG NVARCHAR(100),
    @HE_SO_GIA DECIMAL
AS
BEGIN
    -- Kiểm tra hệ số giá hợp lệ
    IF @HE_SO_GIA >= -0.5 AND @HE_SO_GIA < 1
    BEGIN
        -- Tăng giá của thức uống
        UPDATE THUCUONG
        SET DONGIA = DONGIA * (1 + @HE_SO_GIA)
        WHERE TENTU = @TEN_THUC_UONG;
        
        PRINT 'Đã cập nhật giá cho thức uống thành công.';
    END
    ELSE
    BEGIN
        PRINT 'Hệ số giá không hợp lệ.';
    END
END;
/*42.Viết thủ tục tính tổng tiền phụ thu của một chi nhánh bất kì trong thời gian bất kì. 
Với tham số truyền vào là tên chi nhánh, thời gian bắt đầu và thời gian kết thúc. Điều 
kiện ràng buộc thời gian bắt đầu phải trước thời gian kết thúc. */
CREATE PROCEDURE TinhTongTienPhuThu 
    @TEN_CHI_NHANH NVARCHAR(100),
    @THOI_GIAN_BAT_DAU DATETIME,
    @THOI_GIAN_KET_THUC DATETIME
AS
BEGIN
    -- Kiểm tra thời gian bắt đầu phải trước thời gian kết thúc
    IF @THOI_GIAN_BAT_DAU < @THOI_GIAN_KET_THUC
    BEGIN
        -- Tính tổng tiền phụ thu của chi nhánh trong khoảng thời gian
        SELECT SUM(SOTIEN) AS TONG_TIEN_PHU_THU
        FROM PHIEUPHUTHU P
        INNER JOIN NHANVIEN NV ON P.MANV = NV.MANV
        INNER JOIN CHINHANH CN ON NV.MACN = CN.MACN
        WHERE CN.TENCN = @TEN_CHI_NHANH
        AND P.NGAYLAP BETWEEN @THOI_GIAN_BAT_DAU AND @THOI_GIAN_KET_THUC;
    END
    ELSE
    BEGIN
        PRINT 'Thời gian bắt đầu phải trước thời gian kết thúc.';
    END
END;

/*43.Viết thủ tục tính lợi nhuận của hệ thống trong khoảng thời gian bất kì. Với tham số 
đầu vào là thời gian bắt đầu, thời gian kết thúc. Tham sô đầu ra là tổng lợi nhuận của 
hệ thống (lợi nhuận = tổng doanh thu - tổng chi). */
CREATE PROCEDURE TinhLoiNhuanHeThong 
    @THOI_GIAN_BAT_DAU DATETIME,
    @THOI_GIAN_KET_THUC DATETIME,
    @LOI_NHUAN DECIMAL OUTPUT
AS
BEGIN
    -- Khai báo biến để lưu tổng doanh thu và tổng chi
    DECLARE @TONG_DOANH_THU DECIMAL;
    DECLARE @TONG_CHI DECIMAL;

    -- Tính tổng doanh thu trong khoảng thời gian
    SELECT @TONG_DOANH_THU = ISNULL(SUM(TONGTIEN), 0)
    FROM HOADON
    WHERE NGAYLAP BETWEEN @THOI_GIAN_BAT_DAU AND @THOI_GIAN_KET_THUC;

    -- Tính tổng chi trong khoảng thời gian
    SELECT @TONG_CHI = ISNULL(SUM(TONGTIEN), 0)
    FROM PHIEUCHI
    WHERE NGAYLAP BETWEEN @THOI_GIAN_BAT_DAU AND @THOI_GIAN_KET_THUC;

    -- Tính lợi nhuận
    SET @LOI_NHUAN = @TONG_DOANH_THU - @TONG_CHI;
END;

/*44.Viết thủ tục tìm thức uống bán chạy nhất của chi nhánh bất kì trong khoảng thời gian 
bất kì, với tham số truyền vào là tên chi nhánh, thời gian bắt đầu và thời gian kết
thúc. Điều kiện thời gian bắt đầu trước thời gian kết thúc. */
CREATE PROCEDURE TimThucUongBanChayNhatCuaChiNhanh
    @TenChiNhanh NVARCHAR(100),
    @ThoiGianBatDau DATETIME,
    @ThoiGianKetThuc DATETIME,
    @MaThucUongBanChay NVARCHAR(10) OUTPUT,
    @SoLuongBanChay INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 @MaThucUongBanChay = TU.MATU, @SoLuongBanChay = SUM(CT.SOLUONG)
    FROM CHITIET_HOADON CT
    JOIN HOADON HD ON CT.MAHD = HD.MAHD
    JOIN THUCUONG TU ON CT.MATU = TU.MATU
    JOIN CHINHANH CN ON HD.MAKV = CN.MACN
    WHERE CN.TENCN = @TenChiNhanh
        AND HD.NGAYLAP BETWEEN @ThoiGianBatDau AND @ThoiGianKetThuc
    GROUP BY TU.MATU
    ORDER BY SUM(CT.SOLUONG) DESC;

    IF (@MaThucUongBanChay IS NULL OR @SoLuongBanChay IS NULL)
    BEGIN
        SET @MaThucUongBanChay = NULL;
        SET @SoLuongBanChay = 0;
    END
END;

/*45.Viết thủ tục tính tổng số tiền doanh thu của hệ thống trong một ngày bất kì với tham 
số đầu vào là ngày và tham số đầu ra là tổng doanh thu của ngày đó.*/
CREATE PROCEDURE TinhTongDoanhThuTrongMotNgay
    @Ngay DATETIME,
    @TongDoanhThu DECIMAL OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @TongDoanhThu = SUM(TONGTIEN)
    FROM HOADON
    WHERE CONVERT(DATE, NGAYLAP) = CONVERT(DATE, @Ngay);

    IF @TongDoanhThu IS NULL
    BEGIN
        SET @TongDoanhThu = 0;
    END
END;

/*46.Viết thủ tục tìm thức uống bán chạy nhất của hệ thống trong khoảng thời gian bất kì, 
với tham số truyền vào là thời gian bắt đầu và thời gian kết thúc. Điều kiện thời gian 
bắt đầu trước thời gian kết thúc.*/
CREATE PROCEDURE TimThucUongBanChayNhatTrongKhoangThoiGian
    @ThoiGianBatDau DATETIME,
    @ThoiGianKetThuc DATETIME,
    @MaThucUongBanChay NVARCHAR(10) OUTPUT,
    @SoLuongBanChay INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 @MaThucUongBanChay = TU.MATU, @SoLuongBanChay = SUM(CT.SOLUONG)
    FROM CHITIET_HOADON CT
    JOIN HOADON HD ON CT.MAHD = HD.MAHD
    JOIN THUCUONG TU ON CT.MATU = TU.MATU
    WHERE HD.NGAYLAP BETWEEN @ThoiGianBatDau AND @ThoiGianKetThuc
    GROUP BY TU.MATU
    ORDER BY SUM(CT.SOLUONG) DESC;

    IF @MaThucUongBanChay IS NULL
    BEGIN
        SET @SoLuongBanChay = 0;
    END
END;

/*47.Viết thủ tục liệt kê các loại nguyên liệu (tên, số lượng tồn, đơn vị) của một phiếu 
nhập bất kì, với tham số đầu vào là mã phiếu nhập.*/
CREATE PROCEDURE LietKeNguyenLieuCuaPhieuNhap 
    @MAPN CHAR(10)
AS
BEGIN
    -- Liệt kê các loại nguyên liệu của phiếu nhập
    SELECT NL.TENNL, PN.SOLUONG, NL.DONVI
    FROM NGUYENLIEU NL
    INNER JOIN CHITIET_PHIEUNHAP PN ON NL.MANL = PN.MANL
    WHERE PN.MAPN = @MAPN;
END;
/*48.Viết thủ tục tính tổng doanh thu của hệ thống trong khoảng thời gian bất kì. Với 
tham số đầu vào là thời gian bắt đầu, thời gian kết thúc. Tham sô đầu ra là tổng 
doanh thu của hệ thống (doanh thu= tổng tiền hóa đơn + tổng tiền phụ thu).*/
CREATE PROCEDURE TinhTongDoanhThu 
    @NgayBatDau DATETIME,
    @NgayKetThuc DATETIME,
    @TongDoanhThu DECIMAL OUTPUT
AS
BEGIN
    -- Tính tổng tiền hóa đơn trong khoảng thời gian
    DECLARE @TongTienHoaDon DECIMAL;
    SELECT @TongTienHoaDon = SUM(TONGTIEN)
    FROM HOADON
    WHERE NGAYLAP BETWEEN @NgayBatDau AND @NgayKetThuc;

    -- Tính tổng tiền phụ thu trong khoảng thời gian
    DECLARE @TongTienPhuThu DECIMAL;
    SELECT @TongTienPhuThu = SUM(SOTIEN)
    FROM PHIEUPHUTHU
    WHERE NGAYLAP BETWEEN @NgayBatDau AND @NgayKetThuc;

    -- Tổng doanh thu là tổng tiền hóa đơn cộng với tổng tiền phụ thu
    SET @TongDoanhThu = ISNULL(@TongTienHoaDon, 0) + ISNULL(@TongTienPhuThu, 0);
END;

/*49.Viết thủ tục tính tổng chi tiêu của hệ thống trong khoảng thời gian bất kì. Với tham 
số đầu vào là thời gian bắt đầu, thời gian kết thúc. Tham sô đầu ra là tổng tiền chi 
của hệ thống (tổng chi= tổng tiền phiếu nhập + tổng tiền phiếu chi).*/
CREATE PROCEDURE TinhTongChiTieu 
    @NgayBatDau DATETIME,
    @NgayKetThuc DATETIME,
    @TongChiTieu DECIMAL OUTPUT
AS
BEGIN
    -- Tính tổng tiền phiếu nhập trong khoảng thời gian
    DECLARE @TongTienPhieuNhap DECIMAL;
    SELECT @TongTienPhieuNhap = SUM(TONGTIEN)
    FROM PHIEUNHAP
    WHERE NGAYLAP BETWEEN @NgayBatDau AND @NgayKetThuc;

    -- Tính tổng tiền phiếu chi trong khoảng thời gian
    DECLARE @TongTienPhieuChi DECIMAL;
    SELECT @TongTienPhieuChi = SUM(TONGTIEN)
    FROM PHIEUCHI
    WHERE NGAYLAP BETWEEN @NgayBatDau AND @NgayKetThuc;

    -- Tổng chi tiêu là tổng tiền phiếu nhập cộng với tổng tiền phiếu chi
    SET @TongChiTieu = ISNULL(@TongTienPhieuNhap, 0) + ISNULL(@TongTienPhieuChi, 0);
END;

/*50.Viết một thủ tục với tùy chọn ‘with encryption’, mã hóa không cho người dùng xem 
được nội dung của thủ tục.*/
CREATE PROCEDURE TenThuTuc
WITH ENCRYPTION
AS
BEGIN
    -- Nội dung của thủ tục ở đây
    -- Ví dụ:
    SELECT * FROM TableName;
END;

/*51.Viết Trigger bắt lỗi cho lệnh Insert vào bảng CHITIET_HOADON. Khi thêm chi 
tiết hóa đơn thì kiểm tra trùng mã, kiểm tra nhập số lượng âm, thông báo không đủ 
nguyên liệu nếu hết và phải giảm số lượng tồn của nguyên liệu nếu thỏa các điều 
kiện còn lại.*/

/*52.Viết Trigger bắt lỗi cho lệnh Update vào bảng CHITIET_HOADON. Khi sửa số
lượng thức uống trong chi tiết hóa đơn thì phải sửa số lượng tồn của nguyên liệu.*/
CREATE TRIGGER Trig_Update_CHITIET_HOADON
ON CHITIET_HOADON
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra chỉ số lượng thức uống trong chi tiết hóa đơn được sửa
    IF UPDATE(SOLUONG)
    BEGIN
        -- Cập nhật số lượng tồn của nguyên liệu tương ứng
        UPDATE NGUYENLIEU
        SET SOLUONG = SOLUONG + (SELECT SOLUONG FROM inserted) - (SELECT SOLUONG FROM deleted)
        WHERE MANL IN (SELECT MANL FROM inserted);
    END
END;

/*53.Viết Trigger bắt lỗi cho lệnh Delete vào bảng CHITIET_HOADON. Khi xóa chi tiết 
hóa đơn thì phải tăng số lượng tồn của nguyên liệu kiểm tra nếu xóa hết mã hóa đơn 
đó thì xóa lun bên bảng hóa đơn.*/

/*54.Viết Trigger bắt lỗi cho lệnh Insert vào bảng CHITIET_PHIEUNHAP. Khi thêm chi 
tiết nhập thì kiểm tra trùng mã, bắt không được nhập số âm phải tăng số lượng tồn 
của nguyên liệu (nhập hàng).*/
/*55.Viết Trigger bắt lỗi cho lệnh Update vào bảng CHITIET_PHIEUNHAP. Khi sửa số 
lượng nguyên liệu trong chi tiết phiếu nhập thì: không được sửa số âm, phải sửa số 
lượng tồn của nguyên liệu./*
/*56.Viết Trigger bắt lỗi cho lệnh Delete vào bảng CHITIET_PHIEUNHAP. Khi xóa chi 
tiết nhập thì phải giảm số lượng tồn của nguyên liệu, kiểm tra chi tiết phiếu nhập của 
Mã phiếu nhập vừa xóa còn trong bảng chi tiết phiếu nhập hay không, nếu không thì 
xóa phiếu nhập đó bên bảng PHIEUNHAP.*/
/*57.Viết Trigger cho lệnh Delete của bảng NHANVIEN. Khi xóa nhân viên thì tự động 
xóa các bảng có liên quan ( chỉ xóa nhân viên đã nghĩ hơn 12 tháng).*/
/*58.Viết Trigger bắt lỗi tuổi nhân viên khi Insert và khi Update bảng NHANVIEN. Điều 
kiện nhân viên phải trên 18 tuổi.*/
/*59.Viết Trigger bắt lỗi dữ liệu không âm cho các trường số lượng , tổng tiền,.. (kiểu số) 
có các bảng dữ liệu.*/
/*60.Hệ thống có 4 nhóm quyền: BANHANG, KIEMKHO, QUANLY, GIAMDOC. Hãy 
phân quyền cho từng nhóm này theo mô tả ở Phần II.*/

