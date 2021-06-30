-- CONNECT benhvien/admin

-- oracle 12 fix create user issue
ALTER SESSION set "_ORACLE_SCRIPT"=true;


-- Execute create roles
-- Input: (role name)
EXECUTE create_role('NHANVIEN_QUANLY');
EXECUTE create_role('NHANVIEN_QUANLY_TAINGUYEN_NHANSU');
EXECUTE create_role('NHANVIEN_QUANLY_TAIVU');
EXECUTE create_role('NHANVIEN_QUANLY_CHUYENMON');
EXECUTE create_role('NHANVIEN_TIEPTAN_DIEUPHOI');
EXECUTE create_role('NHANVIEN_BANTHUOC');
EXECUTE create_role('NHANVIEN_TAIVU');
EXECUTE create_role('NHANVIEN_KETOAN');
EXECUTE create_role('BACSI_DIEUTRI');


-- Execute create users
-- Input: (username, password)
EXECUTE create_user('NVQLTN01','NVQLTN01');
EXECUTE create_user('NVQLTV01','NVQLTV01');
EXECUTE create_user('NVQLCM01','NVQLCM01');
EXECUTE create_user('NVTT01','NVTT01');
EXECUTE create_user('NVBT01','NVBT01');
EXECUTE create_user('NVTV01','NVTV01');
EXECUTE create_user('NVKT01','NVKT01');
EXECUTE create_user('BS01','BS01');
EXECUTE create_user('BS02','BS02');



-------RBAC policy----------


-- Execute grant privileges to roles
-- Input: (role name)
EXECUTE grant_quanLy_privs('NHANVIEN_QUANLY');
EXECUTE grant_quanlytainguyen_privs('NHANVIEN_QUANLY_TAINGUYEN_NHANSU');
EXECUTE grant_quanlytaivu_privs('NHANVIEN_QUANLY_TAIVU');
EXECUTE grant_tieptan_privs('NHANVIEN_TIEPTAN_DIEUPHOI');
EXECUTE grant_ban_thuoc_privs('NHANVIEN_BANTHUOC');
EXECUTE grant_taivu_privs('NHANVIEN_TAIVU');
EXECUTE grant_ketoan_privs('NHANVIEN_KETOAN');
EXECUTE grant_bacsi_privs('BACSI_DIEUTRI');

-- Execute grant role to roles
-- Input: (soure name, dest name)
EXECUTE grant_role_to_role_or_user('NHANVIEN_QUANLY', 'NHANVIEN_QUANLY_TAINGUYEN_NHANSU');
EXECUTE grant_role_to_role_or_user('NHANVIEN_QUANLY', 'NHANVIEN_QUANLY_TAIVU');
EXECUTE grant_role_to_role_or_user('NHANVIEN_QUANLY', 'NHANVIEN_QUANLY_CHUYENMON');

-- Execute grant role to users
-- Input: (soure name, dest name)
EXECUTE grant_role_to_role_or_user('NHANVIEN_QUANLY_TAINGUYEN_NHANSU', 'NVQLTN01');
EXECUTE grant_role_to_role_or_user('NHANVIEN_QUANLY_TAIVU', 'NVQLTV01');
EXECUTE grant_role_to_role_or_user('NHANVIEN_QUANLY_CHUYENMON', 'NVQLCM01');
EXECUTE grant_role_to_role_or_user('NHANVIEN_TIEPTAN_DIEUPHOI', 'NVTT01');
EXECUTE grant_role_to_role_or_user('NHANVIEN_BANTHUOC', 'NVBT01');
EXECUTE grant_role_to_role_or_user('NHANVIEN_TAIVU', 'NVTV01');
EXECUTE grant_role_to_role_or_user('NHANVIEN_KETOAN', 'NVKT01');
EXECUTE grant_role_to_role_or_user('BACSI_DIEUTRI', 'BS01');
EXECUTE grant_role_to_role_or_user('BACSI_DIEUTRI', 'BS02');



-------DAC policy----------


EXECUTE create_role('ALLOW_CONNECT');
EXECUTE create_role('ALLOW_UPDATE_SERVICE_PRICE');
EXECUTE grant_login_role_privs('ALLOW_CONNECT');
EXECUTE grant_update_service_price_role_privs('ALLOW_UPDATE_SERVICE_PRICE');


-- Input: (role name, username)
-- Policy 1: allow/deny login
EXECUTE grant_role_with_admin_option('ALLOW_CONNECT', 'NHANVIEN_QUANLY_TAINGUYEN_NHANSU');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'NVQLTV01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'NVQLCM01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'NVTT01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'NVBT01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'NVTV01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'NVKT01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'BS01');
EXECUTE grant_role_to_role_or_user('ALLOW_CONNECT', 'BS02');

-- Policy 2: allow TAIVU update DICHVU(DONGIA) 
EXECUTE grant_role_with_admin_option('ALLOW_UPDATE_SERVICE_PRICE', 'NHANVIEN_QUANLY_TAIVU');
EXECUTE grant_role_to_role_or_user('ALLOW_UPDATE_SERVICE_PRICE', 'NVTV01');
