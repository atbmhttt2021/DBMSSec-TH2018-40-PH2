-- SQLPlus
-- connect / as sysdba;

-- or sqldeveloper tool: 
-- connect sys/<password> as sysdba;  
CONNECT sys/oracle AS sysdba;  


-- oracle 12 fix create user issue
ALTER SESSION set "_ORACLE_SCRIPT"=true;


-- Create schema that own all table and data
CREATE USER benhvien IDENTIFIED BY admin QUOTA 10M ON USERS;

-- then grant privileges
GRANT CREATE SESSION TO benhvien WITH ADMIN OPTION;
GRANT CREATE USER TO benhvien WITH ADMIN OPTION;
GRANT CREATE ROLE TO benhvien WITH ADMIN OPTION;
GRANT SELECT ON dba_users TO benhvien WITH GRANT OPTION;
GRANT CREATE TABLE, CREATE SEQUENCE, CREATE PUBLIC SYNONYM TO benhvien;
GRANT CREATE PROCEDURE, CREATE TRIGGER TO benhvien;

GRANT EXECUTE ON DBMS_CRYPTO TO benhvien WITH ADMIN OPTION;

CREATE OR REPLACE PUBLIC SYNONYM DBMS_CRYPTO FOR DBMS_CRYPTO;
-- GRANT ALL PRIVILEGES TO sysadmin;
-- GRANT SELECT ANY DICTIONARY TO sysadmin;