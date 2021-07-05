------------------------------------------------------------------
--- Dang nhap voi quyen SYS trong SQL Plus
-------- connect / as sysdba ----

connect / as sysdba

--- Chay cac lenh sau:
--- alter system set audit_trail = db,extended scope = spfile;
--- shutdown immediate;
--- startup;
-- ALTER SYSTEM SET audit_sys_operations = true scope = spfile;
AUDIT CONNECT;
------------------------------------------------------------------
--- Sau do chay may lenh nay:


----1. Audit thuong

/*audit policy 1: Audit login fail */
AUDIT SESSION WHENEVER NOT SUCCESSFUL;
--- Xem ket qua audit
select username, owner, obj_name, action_name, sql_text from dba_audit_trail;

/*audit policy 2: audit hoat dong cua nguoi dung co quyen dba
*/
create or replace procedure audit_user_dba
is
--DECLARE CustomerID nvarchar2(50)
begin
FOR eachUser IN(
SELECT
   grantee
FROM dba_role_privs where granted_role='DBA')
LOOP 
 if eachUser.grantee !='SYS' AND eachUser.grantee !='SYSTEM' THEN
 
 EXECUTE IMMEDIATE ('AUDIT SELECT TABLE,UPDATE TABLE,DELETE TABLE, INSERT TABLE BY '||eachUser.grantee );
 END IF;
END LOOP;
END audit_user_dba;
/
EXECUTE audit_user_dba;

--- Xem ket qua audit
select username, owner, obj_name, action_name, sql_text from dba_audit_trail;


----2. FGA
/*audit policy 3: audit update salary 
/*
* Table audit luong nhanvien
*/

BEGIN
  DBMS_FGA.ADD_POLICY(
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