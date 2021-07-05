-- CONNECT benhvien/admin
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
--VIEWS-------

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; 
--CREATE VIEW TO CHECK ACCOUNT IN TABLE ACCOUNT IN DB
CREATE OR REPLACE VIEW CHECK_ACCOUNT AS
SELECT ID_NHANVIEN,TENNV,VAITRO
FROM NHANVIEN
WHERE VAITRO IN (
SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') 
FROM DUAL)
/
GRANT SELECT ON CHECK_ACCOUNT TO PUBLIC;
/
CREATE OR REPLACE VIEW NHANVIEN_CHAMCONG AS
SELECT *
FROM CHAMCONG WHERE CHAMCONG.ID_NHANVIEN IN (
	SELECT ID_NHANVIEN FROM NHANVIEN WHERE VAITRO IN(
		SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') 
          FROM DUAL
	)
)
/
GRANT INSERT ON CHAMCONG TO PUBLIC;
CREATE OR REPLACE TRIGGER NHANVIEN_CHAMCONG_UPDATE
INSTEAD OF INSERT ON NHANVIEN_CHAMCONG
BEGIN
INSERT INTO CHAMCONG VALUES(:NEW.ID_NHANVIEN,:NEW.THOIGIAN);
END;
/
GRANT SELECT ON NHANVIEN_CHAMCONG TO PUBLIC;
/
CREATE OR REPLACE VIEW NHANVIEN_TIEPTAN_DICHVU AS
SELECT ID_DICHVU, TENDV
FROM DICHVU
/


----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
--PROCEDURES-------
-- Create procedure create role
CREATE OR REPLACE PROCEDURE create_role( role_name IN VARCHAR2 )
AUTHID CURRENT_USER 
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE 'ALTER SESSION set "_ORACLE_SCRIPT"=true';
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
	pi_password IN NVARCHAR2) IS
	
	user_name NVARCHAR2(20)  	:= pi_username;
	pwd NVARCHAR2(20) 		:= pi_password;
   	li_count       INTEGER	:= 0;
   	lv_stmt   VARCHAR2 (1000);
BEGIN
   	SELECT COUNT (1)
     	INTO li_count
     	FROM all_users
   	WHERE username = UPPER ( user_name );
   	IF li_count != 0
   	THEN
	     EXECUTE IMMEDIATE('ALTER SESSION set "_ORACLE_SCRIPT"=true');
		lv_stmt := 'DROP USER '|| user_name || ' CASCADE';      	
		EXECUTE IMMEDIATE ( lv_stmt );
   	END IF;
	     EXECUTE IMMEDIATE('ALTER SESSION set "_ORACLE_SCRIPT"=true');
        lv_stmt := 'CREATE USER ' || user_name || ' IDENTIFIED BY ' || pwd ;
	DBMS_OUTPUT.put_line(lv_stmt);

	EXECUTE IMMEDIATE ( lv_stmt ); 
                                                
        -- ****** Object: Roles for user ******
	lv_stmt := 'GRANT RESOURCE, CONNECT TO ' || user_name;

	EXECUTE IMMEDIATE ( lv_stmt );
	COMMIT;
END create_user;
/
--Procedure insert into table CHAMCONG
CREATE OR REPLACE PROCEDURE insert_cham_cong( id_nhanvien IN VARCHAR2,  THOIGIAN TIMESTAMP)
IS

BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO CHAMCONG VALUES('||id_nhanvien||','||THOIGIAN||')';
 
END insert_cham_cong;
/
GRANT EXECUTE ON insert_cham_cong TO PUBLIC;
--Procedure grant privileges to QUANLY role
CREATE OR REPLACE PROCEDURE grant_quanly_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
BEGIN
  EXECUTE IMMEDIATE 'GRANT SELECT ON DONVI TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON NHANVIEN TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON BENHNHAN TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON HOSOBENHNHAN TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON DICHVU TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON HOSO_DICHVU TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON DONTHUOC TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON THUOC TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON CHITIETDONTHUOC TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON HOADON TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON CTHOADON TO ' || role_name;
  EXECUTE IMMEDIATE 'GRANT SELECT ON CHAMCONG TO ' || role_name;
	-- EXECUTE IMMEDIATE 'GRANT SELECT ON dba_role_privs TO ' || role_name;
COMMIT;
END grant_quanly_privs;
/

--Procedure grant privileges to NHANVIEN_QUANLY_TAINGUYEN_NHANSU role
EXECUTE grant_role_with_admin_option('ALLOW_UPDATE_SERVICE_PRICE', 'NHANVIEN_QUANLY_TAIVU');
-- EXECUTE grant_role_to_role_or_user('ALLOW_UPDATE_SERVICE_PRICE', 'NVTV01');

CREATE OR REPLACE PROCEDURE grant_quanlytainguyen_privs( pi_rolename IN VARCHAR2) IS
	role_name VARCHAR2(50) := pi_rolename;
BEGIN
	EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON DONVI TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON NHANVIEN TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON CHAMCONG TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT ON LUONGTHANG TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT EXECUTE ON create_role TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT EXECUTE ON create_user TO ' || role_name;
	-- EXECUTE IMMEDIATE 'GRANT SELECT ON dba_users TO ' || role_name;
--	EXECUTE IMMEDIATE 'GRANT CREATE USER TO ' || role_name;
--	EXECUTE IMMEDIATE 'GRANT CREATE ROLE TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT EXECUTE ON grant_role_to_role_or_user TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT EXECUTE ON revoke_role TO ' || role_name;
COMMIT;
END grant_quanlytainguyen_privs;
/

--Procedure grant privileges to NHANVIEN_QUANLY_TAIVU role
CREATE OR REPLACE PROCEDURE grant_quanlytaivu_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
BEGIN
	EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON DICHVU TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON THUOC TO ' || role_name;
COMMIT;
END grant_quanlytaivu_privs;
/

--NHANVIEN_QUANLY_CHUYENMON role has no more privileges
------------------------------------------------


--Procedure grant privileges to NHANVIEN_TIEPTAN_DIEUPHOI role
CREATE OR REPLACE PROCEDURE grant_tieptan_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
BEGIN
	EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON BENHNHAN TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON HOSOBENHNHAN TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT ON NHANVIEN_TIEPTAN_DICHVU TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT ON HOSO_DICHVU TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT UPDATE(NGUOITHUCHIEN) ON HOSO_DICHVU TO ' || role_name;
COMMIT;
END grant_tieptan_privs;
/

--Procedure grant privileges to NHANVIEN_BANTHUOC role
CREATE OR REPLACE PROCEDURE grant_ban_thuoc_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
BEGIN
	EXECUTE IMMEDIATE 'GRANT SELECT ON THUOC TO ' || role_name; 
	EXECUTE IMMEDIATE 'GRANT SELECT ON DONTHUOC TO ' || role_name; 
	EXECUTE IMMEDIATE 'GRANT SELECT ON CHITIETDONTHUOC TO ' || role_name; 
COMMIT;
END grant_ban_thuoc_privs;
/

--Procedure grant privileges to NHANVIEN_TAIVU role
CREATE OR REPLACE PROCEDURE grant_taivu_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
BEGIN
	EXECUTE IMMEDIATE 'GRANT SELECT ON HOSOBENHNHAN TO ' || role_name; 
	EXECUTE IMMEDIATE 'GRANT SELECT ON DICHVU TO ' || role_name; 
	EXECUTE IMMEDIATE 'GRANT SELECT ON HOSO_DICHVU TO ' || role_name; 
COMMIT;
END grant_taivu_privs;
/

--Procedure grant privileges to NHANVIEN_KETOAN role
CREATE OR REPLACE PROCEDURE grant_ketoan_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
    lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT SELECT ON NHANVIEN TO ' || role_name;
	EXECUTE IMMEDIATE ( lv_stmt ); 
	EXECUTE IMMEDIATE 'GRANT SELECT ON CHAMCONG TO ' || role_name; 
	EXECUTE IMMEDIATE 'GRANT INSERT,SELECT,UPDATE,DELETE ON LUONGTHANG TO ' || role_name; 
	
COMMIT;
END grant_ketoan_privs;
/

--Procedure grant privileges to BACSI_DIEUTRI role
CREATE OR REPLACE PROCEDURE grant_bacsi_privs( pi_rolename IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
BEGIN
     EXECUTE IMMEDIATE 'GRANT SELECT ON THUOC TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON HOSOBENHNHAN TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT, INSERT ON DONTHUOC TO ' || role_name;
	EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON CHITIETDONTHUOC TO ' || role_name;
COMMIT;
END grant_bacsi_privs;
/


--Procedure grant role to role or user 
CREATE OR REPLACE PROCEDURE grant_role_to_role_or_user( pi_rolename IN NVARCHAR2, pi_dest IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
	role_or_user_name NVARCHAR2(50) := pi_dest;
  lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT ' || role_name || ' TO ' || role_or_user_name;
	EXECUTE IMMEDIATE ( lv_stmt ); 
COMMIT;
END grant_role_to_role_or_user;
/


--------DAC--------
--Procedure grant login role or user 
-- CREATE OR REPLACE PROCEDURE grant_login_role_privs( pi_role_or_user_name IN NVARCHAR2) IS
-- 	role_or_user_name NVARCHAR2(50) := pi_role_or_user_name;
--   lv_stmt   VARCHAR2 (1000);
-- BEGIN
--   lv_stmt:='GRANT CREATE SESSION TO ' || role_or_user_name;
-- 	EXECUTE IMMEDIATE ( lv_stmt ); 
-- COMMIT;
-- END grant_login_role_privs;
-- /

--Procedure grant update service price to role or user 
CREATE OR REPLACE PROCEDURE grant_update_service_price_role_privs( pi_role_or_user_name IN NVARCHAR2) IS
	role_or_user_name NVARCHAR2(50) := pi_role_or_user_name;
  lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT UPDATE(DONGIA) ON DICHVU TO ' || role_or_user_name;
	EXECUTE IMMEDIATE ( lv_stmt ); 
COMMIT;
END grant_update_service_price_role_privs;
/

--Procedure grant role to user with admin option
CREATE OR REPLACE PROCEDURE grant_role_with_admin_option( pi_rolename IN NVARCHAR2, pi_username IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
	user_name NVARCHAR2(50) := pi_username;
  lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='GRANT ' || role_name || ' TO ' || user_name || ' WITH ADMIN OPTION';
	EXECUTE IMMEDIATE ( lv_stmt ); 
COMMIT;
END grant_role_with_admin_option;
/

--Procedure revoke role from user
CREATE OR REPLACE PROCEDURE revoke_role( pi_rolename IN NVARCHAR2, pi_username IN NVARCHAR2) IS
	role_name NVARCHAR2(50) := pi_rolename;
	user_name NVARCHAR2(50) := pi_username;
  lv_stmt   VARCHAR2 (1000);
BEGIN
  lv_stmt:='REVOKE ' || role_name || ' FROM ' || user_name;
	EXECUTE IMMEDIATE ( lv_stmt ); 
COMMIT;
EXCEPTION
  WHEN OTHERS THEN NULL;
END revoke_role;
/


-- Create synonyms
CREATE OR REPLACE PUBLIC SYNONYM create_role FOR create_role;
CREATE OR REPLACE PUBLIC SYNONYM create_user FOR create_user;
CREATE OR REPLACE PUBLIC SYNONYM grant_role_to_role_or_user FOR grant_role_to_role_or_user;
CREATE OR REPLACE PUBLIC SYNONYM revoke_role FOR revoke_role;
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------


