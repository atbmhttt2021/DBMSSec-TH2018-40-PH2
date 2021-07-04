-- CONN BENHVIEN/ADMIN@//localhost:1521/pdb01.localdomain

---- INSERT ----

--insert Don vi
insert into DONVI (TENDV, VAITRO) values ('Admin', 'BENHVIEN'); -- 1
insert into DONVI (TENDV, VAITRO) values ('Phòng quản lý tài nguyên', 'NHANVIEN_QUANLY_TAINGUYEN_NHANSU'); -- 2
insert into DONVI (TENDV, VAITRO) values ('Phòng quản lý tài vụ', 'NHANVIEN_QUANLY_TAIVU'); -- 3
insert into DONVI (TENDV, VAITRO) values ('Phòng quản lý chuyên môn', 'NHANVIEN_QUANLY_CHUYENMON'); -- 4
insert into DONVI (TENDV, VAITRO) values ('Phòng tiếp tân và điều phối', 'NHANVIEN_TIEPTAN_DIEUPHOI'); -- 5
insert into DONVI (TENDV, VAITRO) values ('Phòng tài vụ', 'NHANVIEN_TAIVU'); -- 6
insert into DONVI (TENDV, VAITRO) values ('Phòng bán thuốc', 'NHANVIEN_BANTHUOC'); -- 7
insert into DONVI (TENDV, VAITRO) values ('Phòng kế toán', 'NHANVIEN_KETOAN'); -- 8
insert into DONVI (TENDV, VAITRO) values ('Bác sĩ', 'BACSI_DIEUTRI'); -- 9


--Insert CHINHANHBV
INSERT INTO CHINHANHBV VALUES ('BV001','Bệnh viên Đa khoa khu vực Thủ Đức');
INSERT INTO CHINHANHBV VALUES ('BV002','Bệnh viện Đa khoa Sài Gòn');
INSERT INTO CHINHANHBV VALUES ('BV003','Bệnh viện Nhiệt đới Hồ Chí Minh');


--Insert THONGBAO
INSERT INTO THONGBAO(ID_CHINHANH, ID_DONVI, NOIDUNG) VALUES ('BV001',1,'Ban Giám đốc họp nội bộ về phương án chống dịch vào ngày 1/7/2021 tại Hội trường Nhà điều hành');
INSERT INTO THONGBAO(ID_CHINHANH, ID_DONVI, NOIDUNG) VALUES ('BV001',null,'Xét nghiệm toàn bộ nhân viên hành chính vào lúc 8h00 ngày 1/7/2021');
INSERT INTO THONGBAO(ID_CHINHANH, ID_DONVI, NOIDUNG) VALUES ('BV002',null,'Thực hiện giãn cách toàn bệnh viện từ ngày 01/01/2021 đến khi có thông báo mới');
INSERT INTO THONGBAO(ID_CHINHANH, ID_DONVI, NOIDUNG) VALUES ('BV003',9,'Họp nội bộ Bác sĩ vào ngày 02/07/2021 về việc tiếp nhận bệnh nhân điều trị');



--insert benh nhan

insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Nguyen Van An', TO_DATE('12/02/1984', 'DD/MM/YYYY'),'1 Cong Hoa, Ho Chi Minh','0755586353', 'female');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH)
values ('Tran Kim Ngan', TO_DATE('18/01/1976', 'DD/MM/YYYY'),'485 Huynh Van Banh, Ho Chi Minh','075558785', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Nguyen An Vien', TO_DATE('11/01/1997', 'DD/MM/YYYY'),'173/44/15 Nguyen Khuyen, Ho Chi Minh City','0753749012', 'female');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Nguyen Trung Quang', TO_DATE('17/12/1989', 'DD/MM/YYYY'),'164/22 Nguyen Thi Minh Khai, Ho Chi Minh','0757406826', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Tran Thao Vien', TO_DATE('03/07/1978', 'DD/MM/YYYY'),'7 Le Thi Rieng Street, Ho Chi Minh','0755820572', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Nguyen Van Ni', TO_DATE('17/01/1974', 'DD/MM/YYYY'),'203 Nguyen Van Bi, Ho Chi Minh City','0729407383', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Le Thi Hong Nhung', TO_DATE('30/08/1980', 'DD/MM/YYYY'),'77 Phung Khac Khoan, Ho Chi Minh','0972902747', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH)
values ('Ho Bich Nga', TO_DATE('01/06/1983', 'DD/MM/YYYY'),'94 Nguyen Thi Nho, Ho Chi Minh','0978500037', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Dinh Van Tung', TO_DATE('16/07/1971', 'DD/MM/YYYY'),'99 Vo Van Ngan, Ho Chi Minh','0748305990', 'male');
insert into BENHNHAN (HOTEN, NGAYSINH, DIACHI, SDT,GIOITINH) 
values ('Nguyen Hoai An', TO_DATE('05/01/1960', 'DD/MM/YYYY'),'90 Vo Thi Sau, TP HCM','0327405438', 'male');


--insert NHANVIEN

insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Kim Khanh','',TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Nguyen Van Banh, TP HCM','NVQLTN01',2,'BV001','male'); -- 1
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Ly Thi Hien','',TO_DATE('12/01/1989', 'DD/MM/YYYY'),'68 Kha Van Can, Tp HCM','NVQLTV01',3,'BV001','female'); -- 2
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Minh Trang','',TO_DATE('12/06/1985', 'DD/MM/YYYY'),'15 Ton Duc Thang, tp HCM','NVQLCM01',4,'BV001','female'); -- 3
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Quynh Nhu','',TO_DATE('12/03/1960', 'DD/MM/YYYY'),'24/2 Tran Khac Tran,TP HCM','NVTT01',5,'BV001','female'); -- 4
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Anh Minh','',TO_DATE('14/01/1960', 'DD/MM/YYYY'),'72 Phan Dinh Giot, TP HCM','NVBT01',7,'BV001','male'); -- 5
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Ly Ngoc Binh','',TO_DATE('12/03/1976', 'DD/MM/YYYY'),'107 Hoa Hung,TP HCM','BS01',9,'BV001','male'); -- 6
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Tran Van Quyet','',TO_DATE('19/06/1968', 'DD/MM/YYYY'),'80 Ly Chinh Thang, TP HCM','BS02',9,'BV001','male'); -- 7
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Ngoc Hoa','',TO_DATE('03/12/1968', 'DD/MM/YYYY'),'77 Ly Chinh Thang, TP HCM','NVTV01',6,'BV001','female'); -- 8
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Kim Uyen','',TO_DATE('24/06/1971', 'DD/MM/YYYY'),'99 Phung Khac Khoan, TP HCM','NVKT01',8,'BV001','female'); -- 9
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH)
values ('Ly Van An','',TO_DATE('12/04/1966', 'DD/MM/YYYY'),'7 Ly Thai To, TP HCM','NVKT02',8,'BV001','male'); --
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH)
values ('Ly Van An','',TO_DATE('12/04/1966', 'DD/MM/YYYY'),'7 Ly Thai To, TP HCM','NVKT03',8,'BV001','male');  10

-- chi nhanh 2
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Kim Khanh','',TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Nguyen Van Banh, TP HCM','NVQLTN02',2,'BV002','male'); -- 1
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Ly Thi Hien','',TO_DATE('12/01/1989', 'DD/MM/YYYY'),'68 Kha Van Can, Tp HCM','NVQLTV01',3,'BV002','female'); -- 2
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Minh Trang','',TO_DATE('12/06/1985', 'DD/MM/YYYY'),'15 Ton Duc Thang, tp HCM','NVQLCM02',4,'BV002','female'); -- 3
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Quynh Nhu','',TO_DATE('12/03/1960', 'DD/MM/YYYY'),'24/2 Tran Khac Tran,TP HCM','NVTT02',5,'BV002','female'); -- 4
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Anh Minh','',TO_DATE('14/01/1960', 'DD/MM/YYYY'),'72 Phan Dinh Giot, TP HCM','NVBT02',7,'BV002','male'); -- 5
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Ly Ngoc Binh','',TO_DATE('12/03/1976', 'DD/MM/YYYY'),'107 Hoa Hung,TP HCM','BS03',9,'BV002','male'); -- 6
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Tran Van Quyet','',TO_DATE('19/06/1968', 'DD/MM/YYYY'),'80 Ly Chinh Thang, TP HCM','BS04',9,'BV002','male'); -- 7
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Ngoc Hoa','',TO_DATE('03/12/1968', 'DD/MM/YYYY'),'77 Ly Chinh Thang, TP HCM','NVTV02',6,'BV002','female'); -- 8
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Kim Uyen','',TO_DATE('24/06/1971', 'DD/MM/YYYY'),'99 Phung Khac Khoan, TP HCM','NVKT03',8,'BV002','female'); -- 9

-- chi nhanh3
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Kim Khanh','',TO_DATE('12/01/1960', 'DD/MM/YYYY'),'174 Nguyen Van Banh, TP HCM','NVQLTN03',2,'BV003','male'); -- 1
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Ly Thi Hien','',TO_DATE('12/01/1989', 'DD/MM/YYYY'),'68 Kha Van Can, Tp HCM','NVQLTV03',3,'BV003','female'); -- 2
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Minh Trang','',TO_DATE('12/06/1985', 'DD/MM/YYYY'),'15 Ton Duc Thang, tp HCM','NVQLCM03',4,'BV003','female'); -- 3
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Quynh Nhu','',TO_DATE('12/03/1960', 'DD/MM/YYYY'),'24/2 Tran Khac Tran,TP HCM','NVTT03',5,'BV003','female'); -- 4
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Anh Minh','',TO_DATE('14/01/1960', 'DD/MM/YYYY'),'72 Phan Dinh Giot, TP HCM','NVBT03',7,'BV003','male'); -- 5
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Ly Ngoc Binh','',TO_DATE('12/03/1976', 'DD/MM/YYYY'),'107 Hoa Hung,TP HCM','BS05',9,'BV003','male'); -- 6
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Tran Van Quyet','',TO_DATE('19/06/1968', 'DD/MM/YYYY'),'80 Ly Chinh Thang, TP HCM','BS06',9,'BV003','male'); -- 7
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Nguyen Ngoc Hoa','',TO_DATE('03/12/1968', 'DD/MM/YYYY'),'77 Ly Chinh Thang, TP HCM','NVTV03',6,'BV003','female'); -- 8
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH) 
values ('Phan Kim Uyen','',TO_DATE('24/06/1971', 'DD/MM/YYYY'),'99 Phung Khac Khoan, TP HCM','NVKT05',8,'BV003','female'); -- 9
insert into NHANVIEN (TENNV, LUONGCA, NGAYSINH, DIACHI, VAITRO, DONVI, CHINHANH, GIOITINH)
values ('Ly Van An','',TO_DATE('12/04/1966', 'DD/MM/YYYY'),'7 Ly Thai To, TP HCM','NVKT06',8,'BV003','male'); -- 10


--insert cham cong

insert into CHAMCONG (ID_NHANVIEN, THOIGIAN)
values (1, CURRENT_TIMESTAMP);
insert into CHAMCONG (ID_NHANVIEN, THOIGIAN)
values (2, CURRENT_TIMESTAMP);
insert into CHAMCONG (ID_NHANVIEN, THOIGIAN)
values (3, CURRENT_TIMESTAMP);
insert into CHAMCONG (ID_NHANVIEN, THOIGIAN)
values (4, CURRENT_TIMESTAMP);
insert into CHAMCONG (ID_NHANVIEN, THOIGIAN)
values (5, CURRENT_TIMESTAMP);
insert into CHAMCONG (ID_NHANVIEN, THOIGIAN)
values (6, CURRENT_TIMESTAMP);


--insert THUOC

insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Penicillin', 'Vỉ 10 viên', 100000, '', 'Úc', 'Thuốc kháng sinh, điều trị bệnh do vi khuẩn'); -- 1
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Insulin', 'Liêu', 200000, '', 'Canada', 'Điều trị đại tháo đường'); -- 2
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Morphin', 'Liều', 300000, 'Gây nghiện', 'Đức', 'Giảm đau'); -- 3
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Aspirin', 'Viên', 10000, 'Có thể gây ra hiện tượng khó tiêu cho người sử dụng.', 'Đức', 'Giảm đau, hạ số kháng viêm'); -- 4
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Chlorpromazin', 'Hộp 50 viên', 400000, '', 'Việt Nam', 'An thần, điều trị lo âu, trầm cảm'); -- 5
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Ether', 'Liều', 150000, '', 'Hoa Kỳ', 'Gây mê'); -- 6
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Dexamethasone', 'Viên', 15000, 'Tác dụng phụ tăng glucose trong máu đến suy giảm hệ miễn dịch', 'Việt Nam', 'Chống viêm, giảm nhiễm trùng'); -- 7
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Diclofenac', 'Viên', 12000, 'Chủ yếu sử dụng là thuốc giảm đau khớp và đau răng', 'Việt Nam', 'Chống viêm và là thuốc giảm đau trung bình'); -- 8
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Sibutramine', 'Viên', 10000, 'Có thể làm tăng hoạt động tim mạch, khiến ai đó có nguy cơ bị đau tim hoặc đột quỵ cao hơn', 'Trung Quốc', 'Giảm cân'); -- 9
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Dextrose', 'Chai 500ml', 150000, '', 'Pháp', 'Điều trị huyết áp thấp'); -- 10
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Dexamethasone', 'Liều', 150000, '', 'Hoa Kỳ', 'Gây mê'); -- 11
insert into THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
values ('Dexamethasone', 'Liều', 150000, '', 'Hoa Kỳ', 'Gây mê'); -- 12


--insert Ho so benh nhan
insert into HOSOBENHNHAN (NGAYKB, MABS, MATT, ID_BENHNHAN,TINHTRANGBD, KETLUANBS)
values (TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,4,1,'Ho nhieu','Viem phoi');
insert into HOSOBENHNHAN (NGAYKB, MABS, MATT, ID_BENHNHAN,TINHTRANGBD, KETLUANBS)
values (TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,4,2,'Dau bung du doi','Dau da day');
insert into HOSOBENHNHAN (NGAYKB, MABS, MATT, ID_BENHNHAN,TINHTRANGBD, KETLUANBS)
values (TO_DATE('12/01/2020', 'DD/MM/YYYY'),7,4,3,'Sut can khong kiem soat','Tieu Duong ');
insert into HOSOBENHNHAN (NGAYKB, MABS, MATT, ID_BENHNHAN,TINHTRANGBD, KETLUANBS)
values (TO_DATE('12/01/2020', 'DD/MM/YYYY'),7,4,4,'Bi ngat','Huyet ap cao');
insert into HOSOBENHNHAN (NGAYKB, MABS, MATT, ID_BENHNHAN,TINHTRANGBD, KETLUANBS)
values (TO_DATE('12/01/2020', 'DD/MM/YYYY'),6,4,5,'Kho tho','Viem phoi');


--insert don thuoc
insert into DONTHUOC (ID_KHAMBENH,NGUOILAP)
values (1,5); -- 1
insert into DONTHUOC (ID_KHAMBENH,NGUOILAP)
values (2,5); -- 2
insert into DONTHUOC (ID_KHAMBENH,NGUOILAP)
values (3,5); -- 3
insert into DONTHUOC (ID_KHAMBENH,NGUOILAP)
values (4,5); -- 4
insert into DONTHUOC (ID_KHAMBENH,NGUOILAP)
values (5,5); -- 5


--insert chi tiet don thuoc

insert into CHITIETDONTHUOC (ID_DONTHUOC,ID_THUOC, SOLUONG, LIEUDUNG, MOTA)
values (1,1,1, '50ml', 'Ngay 2 vien sang chieu sau khi an');
insert into CHITIETDONTHUOC (ID_DONTHUOC,ID_THUOC, SOLUONG, LIEUDUNG, MOTA)
values (1,2,10, '2 vien', 'Uong sang-trua-chieu truoc khi an');
insert into CHITIETDONTHUOC (ID_DONTHUOC,ID_THUOC, SOLUONG, LIEUDUNG, MOTA)
values (2,3,5, '2 vien', 'Uong sang va chieu sau khi an');
insert into CHITIETDONTHUOC (ID_DONTHUOC,ID_THUOC, SOLUONG, LIEUDUNG, MOTA)
values (3,4,6, '2 vien', 'Uong sang va chieu sau khi an');
insert into CHITIETDONTHUOC (ID_DONTHUOC,ID_THUOC, SOLUONG, LIEUDUNG, MOTA)
values (4,5,1, '30ml', 'Sang chieu sau an');


--insert dich vu

insert into DICHVU (TENDV, DONGIA)
values ('Kham Tong Quat','150.000');
insert into DICHVU (TENDV, DONGIA)
values ('Sieu am 3D','250.000');
insert into DICHVU (TENDV, DONGIA)
values ('Chup XQuang','230.000');
insert into DICHVU (TENDV, DONGIA)
values ('Kham so sinh','150.000');
insert into DICHVU (TENDV, DONGIA)
values ('Dinh luong cholesterol','240.000');
insert into DICHVU (TENDV, DONGIA) values ('Trám răng cái', 150000);
insert into DICHVU (TENDV, DONGIA) values ('Trồng răng răng cái', 800000);
insert into DICHVU (TENDV, DONGIA) values ('Bọc răng sứ cái', 1500000);
insert into DICHVU (TENDV, DONGIA) values ('Lấy cao răng', 200000);
insert into DICHVU (TENDV, DONGIA) values ('Nâng mũi', 2000000);
insert into DICHVU (TENDV, DONGIA) values ('Điều trị đục thủy tinh thể', 3000000);
insert into DICHVU (TENDV, DONGIA) values ('Sanh thường', 1500000);
insert into DICHVU (TENDV, DONGIA) values ('Sanh mổ', 3000000);
insert into DICHVU (TENDV, DONGIA) values ('Xét nghiệm máu', 30000);
insert into DICHVU (TENDV, DONGIA) values ('Xét nghiệm nước tiểu', 30000);
insert into DICHVU (TENDV, DONGIA) values ('Xét nghiệm ADN', 5000000);


--insert ho so dich vu

insert into HOSO_DICHVU (ID_KHAMBENH, ID_DICHVU, NGUOITHUCHIEN, NGAYGIO,KETLUAN)
values (1,2,1, TO_DATE('15/01/2021', 'DD/MM/YYYY'), 'Khong co van de');
insert into HOSO_DICHVU (ID_KHAMBENH, ID_DICHVU, NGUOITHUCHIEN, NGAYGIO,KETLUAN)
values (2,1,1, TO_DATE('15/01/2021', 'DD/MM/YYYY'), 'Khong co van de');
insert into HOSO_DICHVU (ID_KHAMBENH, ID_DICHVU, NGUOITHUCHIEN, NGAYGIO,KETLUAN)
values (3,3,1, TO_DATE('15/01/2021', 'DD/MM/YYYY'), 'Bi viem phoi');
insert into HOSO_DICHVU (ID_KHAMBENH, ID_DICHVU, NGUOITHUCHIEN, NGAYGIO,KETLUAN)
values (4,3,2, TO_DATE('15/01/2021', 'DD/MM/YYYY'), 'Bi viem tai');
insert into HOSO_DICHVU (ID_KHAMBENH, ID_DICHVU, NGUOITHUCHIEN, NGAYGIO,KETLUAN)
values (5,4,2, TO_DATE('15/01/2021', 'DD/MM/YYYY'), 'Bi viem da');


--insert Hoa Don

insert into HOADON (ID_KHAMBENH, NGAYHD, NGUOIPT,TONGTIEN)
values (1, TO_DATE('12/01/2020', 'DD/MM/YYYY'),5,300000);
insert into HOADON (ID_KHAMBENH, NGAYHD, NGUOIPT,TONGTIEN)
values (2, TO_DATE('12/01/2020', 'DD/MM/YYYY'),5,150000);
insert into HOADON (ID_KHAMBENH, NGAYHD, NGUOIPT,TONGTIEN)
values (3, TO_DATE('12/01/2020', 'DD/MM/YYYY'),5,150000);
insert into HOADON (ID_KHAMBENH, NGAYHD, NGUOIPT,TONGTIEN)
values (4, TO_DATE('12/01/2020', 'DD/MM/YYYY'),5,150000);
insert into HOADON (ID_KHAMBENH, NGAYHD, NGUOIPT,TONGTIEN)
values (5, TO_DATE('12/01/2020', 'DD/MM/YYYY'),5,0);


--insert chi tiet hoa don

insert into CTHOADON (ID_HOADON, ID_DICHVU)
values (1, 1);
insert into CTHOADON (ID_HOADON, ID_DICHVU)
values (1, 2);
insert into CTHOADON (ID_HOADON, ID_DICHVU)
values (2, 1);
insert into CTHOADON (ID_HOADON, ID_DICHVU)
values (3, 1);
insert into CTHOADON (ID_HOADON, ID_DICHVU)
values (4, 1);


--insert luong thang
insert into LUONGTHANG (THANG, NAM, ID_NHANVIEN, NGUOILAP, TONGTIEN)
values (1,2021,6,9,15000000);
insert into LUONGTHANG (THANG, NAM, ID_NHANVIEN, NGUOILAP, TONGTIEN)
values (1,2021,7,9,12000000);
insert into LUONGTHANG (THANG, NAM, ID_NHANVIEN, NGUOILAP, TONGTIEN)
values (2,2021,6,9,18000000);
insert into LUONGTHANG (THANG, NAM, ID_NHANVIEN, NGUOILAP, TONGTIEN)
values (2,2021,7,9,9000000);

