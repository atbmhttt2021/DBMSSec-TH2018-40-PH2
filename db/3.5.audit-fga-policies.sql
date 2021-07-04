------------------------------------------------------------------
--- Dang nhap voi quyen SYS trong SQL Plus
-------- connect / as sysdba ----

connect / as sysdba

--- Chay cac lenh sau:
--- alter system set audit_trail = db,extended scope = spfile;
--- shutdown immediate;
--- startup;
ALTER SYSTEM SET audit_sys_operations = true scope = spfile;
AUDIT CONNECT;
------------------------------------------------------------------
--- Sau do chay may lenh nay:

--- Bat audit tren 2 table nay
----1. Audit login fail
/*audit policy 1: audit select on key_salary */
AUDIT SESSION WHENEVER NOT SUCCESSFUL;
/*audit policy 2: audit xoa bang trong database
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
  DBMS_FGA.drop_POLICY(
   object_schema      => 'benhvien',
   object_name        => 'NHANVIEN',
   policy_name        => 'audit_salary',
   enable             =>  TRUE,
   statement_types    => 'INSERT, UPDATE',
   audit_column       => 'LUONGCA',
   audit_trail        =>  DBMS_FGA.DB + DBMS_FGA.EXTENDED);
END;
/

---Kiem tra ket qua audit
SELECT DBUID, LSQLTEXT, NTIMESTAMP# FROM SYS.FGA_LOG$;