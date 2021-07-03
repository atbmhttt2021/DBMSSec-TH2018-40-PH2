------------------------------------------------------------------
--- Dang nhap voi quyen SYS trong SQL Plus
--- Chay cac lenh sau:
--- alter system set audit_trail = db,extended scope = spfile;
--- shutdown immediate;
--- startup;
ALTER SYSTEM SET audit_sys_operations = true scope = spfile;
AUDIT CONNECT;
------------------------------------------------------------------
--- Sau do chay may lenh nay:

--- Bat audit tren 2 table nay
----1. Audit thuong
/*audit policy 1: audit select on key_salary */
   
AUDIT INSERT,DELETE,UPDATE,SELECT on key_salary BY ACCESS WHENEVER SUCCESSFUL;
/*audit policy 3: audit xoa bang trong database
*/
AUDIT DELETE ANY TABLE WHENEVER NOT SUCCESSFUL;
--- Xem ket qua audit
select username, owner, obj_name, action_name, sql_text from dba_audit_trail;


----2. FGA
/*audit policy 3: audit update salary 
/*
* Table audit luong nhanvien
*/
BEGIN
  DBMS_FGA.ADD_POLICY(
   object_name        => 'NHANVIEN',
   policy_name        => 'audit_salary',
   enable             =>  TRUE,
   statement_types    => 'INSERT, UPDATE, DELETE',
   audit_column       => 'LUONG',
   audit_trail        =>  DBMS_FGA.DB + DBMS_FGA.EXTENDED);
END;
/

---Kiem tra ket qua audit
SELECT DBUID, LSQLTEXT, NTIMESTAMP# FROM SYS.FGA_LOG$;