-- Insert into DONVI
DELETE FROM DONVI CASCADE;
INSERT INTO DONVI (TENDV) VALUES ('Phòng quản lý tài nguyên');
INSERT INTO DONVI (TENDV) VALUES ('Phòng quản lý tài vụ');
INSERT INTO DONVI (TENDV) VALUES ('Phòng quản lý chuyên môn');
INSERT INTO DONVI (TENDV) VALUES ('Phòng tiếp tân và điều phối');
INSERT INTO DONVI (TENDV) VALUES ('Phòng tài vụ');
INSERT INTO DONVI (TENDV) VALUES ('Phòng bán thuốc');
INSERT INTO DONVI (TENDV) VALUES ('Phòng kế toán');
INSERT INTO DONVI (TENDV) VALUES ('Khoa tai mũi họng');
INSERT INTO DONVI (TENDV) VALUES ('Khoa răng hàm mặt');
INSERT INTO DONVI (TENDV) VALUES ('Khoa mắt');
INSERT INTO DONVI (TENDV) VALUES ('Khoa huyết học truyền máu');
INSERT INTO DONVI (TENDV) VALUES ('Khoa nội hô hấp - tiêu hóa');
INSERT INTO DONVI (TENDV) VALUES ('Khoa chấn thương chỉnh hình');
INSERT INTO DONVI (TENDV) VALUES ('Khoa ngoại thần kinh');
INSERT INTO DONVI (TENDV) VALUES ('Khoa y học cổ truyền');
INSERT INTO DONVI (TENDV) VALUES ('Khoa sản');
INSERT INTO DONVI (TENDV) VALUES ('Khoa chẩn đoán hình ảnh');
INSERT INTO DONVI (TENDV) VALUES ('Khoa xét nghiệm');

-- Insert into DICHVU
DELETE FROM DICHVU CASCADE;
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Khám lâm sàn', 50000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Khám sức khỏe tổng quát', 150000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Trám răng 1 cái', 150000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Trồng răng răng 1 cái', 800000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Bọc răng sứ 1 cái', 1500000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Lấy cao răng', 200000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Nâng mũi', 2000000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Điều trị đục thủy tinh thể', 3000000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Sanh thường', 1500000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Sanh mổ', 3000000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Chụp X-quang', 100000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Xét nghiệm máu', 30000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Xét nghiệm nước tiểu', 30000);
INSERT INTO DICHVU (TENDV, DONGIA) VALUES ('Xét nghiệm ADN', 5000000);

-- Insert into THUOC
DELETE FROM THUOC CASCADE;
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Penicillin', 'Vỉ 10 viên', 100000, '', 'Úc', 'Thuốc kháng sinh, điều trị bệnh do vi khuẩn');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Insulin', 'Liêu', 200000, '', 'Canada', 'Điều trị đại tháo đường');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Morphin', 'Liều', 300000, 'Gây nghiện', 'Đức', 'Giảm đau');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Aspirin', 'Viên', 10000, 'Có thể gây ra hiện tượng khó tiêu cho người sử dụng. Để tránh tình trạng này, bạn hãy uống thuốc aspirin với thức ăn', 'Đức', 'Giảm đau, hạ số kháng viêm');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Chlorpromazin', 'Hộp 50 viên', 400000, '', 'Việt Nam', 'An thần, điều trị lo âu, trầm cảm');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Ether', 'Liều', 150000, '', 'Hoa Kỳ', 'Gây mê');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Dexamethasone', 'Viên', 15000, 'Tác dụng phụ tăng glucose trong máu đến suy giảm hệ miễn dịch', 'Việt Nam', 'Chống viêm, giảm nhiễm trùng');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Diclofenac', 'Viên', 12000, 'Chủ yếu sử dụng là thuốc giảm đau khớp và đau răng', 'Việt Nam', 'Chống viêm và là thuốc giảm đau trung bình');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Sibutramine', 'Viên', 10000, 'Có thể làm tăng hoạt động tim mạch, khiến ai đó có nguy cơ bị đau tim hoặc đột quỵ cao hơn', 'Trung Quốc', 'Giảm cân');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Dextrose', 'Chai 500ml', 150000, '', 'Pháp', 'Điều trị huyết áp thấp');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Dexamethasone', 'Liều', 150000, '', 'Hoa Kỳ', 'Gây mê');
INSERT INTO THUOC (TENTHUOC, DVT, DONGIA, LUUY, XUATXU, CONGDUNG)
VALUES ('Dexamethasone', 'Liều', 150000, '', 'Hoa Kỳ', 'Gây mê');

-- Insert NHANVIEN
DELETE FROM NHANVIEN CASCADE;
INSERT INTO NHANVIEN (TENNV, VAITRO, DONVI) VALUES ('Tôi là ad', 'SYSADMIN', 1);
INSERT INTO NHANVIEN (TENNV, VAITRO, DONVI) VALUES ('Tôi là bác sĩ', 'BACSI1', 8);
INSERT INTO NHANVIEN (TENNV, VAITRO, DONVI) VALUES ('Tôi là tiếp tân', 'TIEPTAN1', 4);
INSERT INTO NHANVIEN (TENNV, VAITRO, DONVI) VALUES ('Tôi là tài vụ', 'TAIVU1', 5);
INSERT INTO NHANVIEN (TENNV, VAITRO, DONVI) VALUES ('Tôi bán thuốc', 'BANTHUOC1', 6);