-- SQLPlus
-- connect / as sysdba;

-- or sqldeveloper tool: 
-- connect sys/<password> as sysdba;  
--CONNECT sys/oracle AS sysdba;  


-- oracle 12 fix create user issue
ALTER SESSION set "_ORACLE_SCRIPT"=true;


-- Create schema that own all table and 
BEGIN
  EXECUTE IMMEDIATE 'DROP USER benhvien CASCADE';
  EXCEPTION WHEN OTHERS THEN NULL;
END;
/
CREATE USER benhvien IDENTIFIED BY admin QUOTA 10M ON USERS;

-- then grant privileges
GRANT CREATE SESSION TO benhvien WITH ADMIN OPTION;
GRANT CREATE USER TO benhvien WITH ADMIN OPTION;
GRANT CREATE ROLE TO benhvien WITH ADMIN OPTION;
GRANT DBA TO benhvien;
GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE PUBLIC SYNONYM TO benhvien;
GRANT CREATE PROCEDURE, CREATE TRIGGER TO benhvien;

-- grant encrypion package
--GRANT EXECUTE ON DBMS_CRYPTO TO benhvien WITH GRANT OPTION;
CREATE OR REPLACE PUBLIC SYNONYM DBMS_CRYPTO FOR DBMS_CRYPTO;
-- grant vpd package
--GRANT EXECUTE ON DBMS_RLS TO benhvien WITH GRANT OPTION;
GRANT CREATE ANY CONTEXT TO benhvien;
GRANT ADMINISTER DATABASE TRIGGER TO benhvien;

