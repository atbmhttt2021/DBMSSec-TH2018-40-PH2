-- Create procedure create role
CREATE OR REPLACE PROCEDURE create_role( role_name IN VARCHAR2 )
AUTHID CURRENT_USER 
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
EXCEPTION
  WHEN OTHERS THEN
    -- ORA-01921: If The role name exists, ignore the error.
    IF SQLCODE <> -01921 THEN
      RAISE;
    END IF;
END create_role;
/

--create procedure create user
CREATE OR REPLACE PROCEDURE create_user(
	pi_username IN NVARCHAR2,
	pi_password IN NVARCHAR2  ) IS
	
	user_name NVARCHAR2(20)  	:= pi_username;
	pwd NVARCHAR2(20) 		:= pi_password;
   	li_count       INTEGER	:= 0;
    lv_stmt   VARCHAR2 (1000);
BEGIN
   	SELECT COUNT (1)
     	INTO li_count
     	FROM dba_users
   	WHERE username = UPPER ( user_name );

   	IF li_count != 0
   	THEN
		lv_stmt := 'DROP USER '|| user_name || ' CASCADE';      	
		EXECUTE IMMEDIATE ( lv_stmt );
   	END IF;
        lv_stmt := 'CREATE USER ' || user_name || ' IDENTIFIED BY ' || pwd || 'QUOTA 10M ON USERS';
	DBMS_OUTPUT.put_line(lv_stmt);

	EXECUTE IMMEDIATE ( lv_stmt ); 
                                                
        -- ****** Allow create session ******
	lv_stmt := 'GRANT CREATE SESSION TO ' || user_name;

	EXECUTE IMMEDIATE ( lv_stmt );
	COMMIT;
END create_user;
/ 

--Procedure grant privileges to QUANLY role
CREATE OR REPLACE PROCEDURE grant_quanLy_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT ON DONVI ' || ' TO ' || role_name
    || '; GRANT SELECT ON NHANVIEN ' || ' TO ' || role_name
    || '; GRANT SELECT ON BENHNHAN ' || ' TO ' || role_name
    || '; GRANT SELECT ON HOSOBENHNHAN ' || ' TO ' || role_name
    || '; GRANT SELECT ON DICHVU ' || ' TO ' || role_name
    || '; GRANT SELECT ON HOSO_DICHVU ' || ' TO ' || role_name
    || '; GRANT SELECT ON DONTHUOC ' || ' TO ' || role_name
    || '; GRANT SELECT ON THUOC ' || ' TO ' || role_name
    || '; GRANT SELECT ON CHITIETDONTHUOC ' || ' TO ' || role_name
    || '; GRANT SELECT ON HOADON ' || ' TO ' || role_name
    || '; GRANT SELECT ON CTHOADON ' || ' TO ' || role_name
    || '; GRANT SELECT ON CHAMCONG ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_quanLy_privs;
/

--Procedure grant privileges to NHANVIEN_QUANLY_TAINGUYEN_NHANSU role
CREATE OR REPLACE PROCEDURE grant_quanlytainguyen_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT INSERT, UPDATE, DELETE ON PHONGBAN ' || ' TO ' || role_name
    || '; GRANT INSERT, UPDATE, DELETE ON NHANVIEN ' || ' TO ' || role_name
    || '; GRANT INSERT, UPDATE, DELETE ON CHAMCONG ' || ' TO ' || role_name
    || '; EXECUTE create_role ' || ' TO ' || role_name
    || '; EXECUTE create_user ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_quanlytainguyen_privs;
/

--Procedure grant privileges to NHANVIEN_QUANLY_TAIVU role
CREATE OR REPLACE PROCEDURE grant_quanlytaivu_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT INSERT, UPDATE, DELETE ON DICHVU ' || ' TO ' || role_name
    || '; GRANT INSERT, UPDATE, DELETE ON THUOC ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_quanlytaivu_privs;
/

--NHANVIEN_QUANLY_CHUYENMON role has no more privileges
------------------------------------------------


--Procedure grant privileges to NHANVIEN_TIEPTAN_DIEUPHOI role
CREATE OR REPLACE PROCEDURE grant_tieptan_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT, INSERT, UPDATE, DELETE ON BENHNHAN ' || ' TO ' || role_name
    || '; GRANT SELECT, INSERT, UPDATE, DELETE ON HOSOBENHNHAN ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_tieptan_privs;
/

--Procedure grant privileges to NHANVIEN_BANTHUOC role
CREATE OR REPLACE PROCEDURE grant_ban_thuoc_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT ON THUOC ' || ' TO ' || role_name
    || '; GRANT SELECT ON DONTHUOC ' || ' TO ' || role_name
    || '; GRANT SELECT ON CHITIETDONTHUOC ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_ban_thuoc_privs;
/

--Procedure grant privileges to NHANVIEN_TAIVU role
CREATE OR REPLACE PROCEDURE grant_taivu_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT ON HOSOBENHNHAN ' || ' TO ' || role_name
    || '; GRANT SELECT, UPDATE ON DICHVU ' || ' TO ' || role_name
    || '; GRANT SELECT ON HOSO_DICHVU ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_taivu_privs;
/

--Procedure grant privileges to NHANVIEN_KETOAN role
CREATE OR REPLACE PROCEDURE grant_ketoan_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT ON NHANVIEN ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_ketoan_privs;
/

--Procedure grant privileges to BACSI_DIEUTRI role
CREATE OR REPLACE PROCEDURE grant_bacsi_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT, UPDATE ON HOSOBENHNHAN ' || ' TO ' || role_name
    || '; GRANT SELECT, CREATE ON DONTHUOC ' || ' TO ' || role_name
    || '; GRANT SELECT, CREATE, UPDATE ON CHITIETDONTHUOC ' || ' TO ' || role_name
    || ';';
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_bacsi_privs;
/

--Procedure grant role to role or user 
CREATE OR REPLACE PROCEDURE grant_role_to_role_or_user( pi_rolename IN NVARCHAR2, pi_dest IN NVARCHAR2) IS
	role_name NVARCHAR2(20) := pi_rolename;
	role_or_user_name NVARCHAR2(20) := pi_dest;
  lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT ' || role_name || ' TO ' || role_or_user_name;
	EXECUTE IMMEDIATE ( lv_stmt ); 
END grant_role_to_role_or_user;
/
