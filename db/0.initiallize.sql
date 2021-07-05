-- Require Oracle 12c <<<
-- Config using Multitenant Architecture
-- Using PDB contaier instead of CDB$root
-- >>> Require to implement OLS:

------- Create pdb container via GUI on window, named pdb01:
------- Or on linux and sqlplus:

-- Or sqldeveloper tool: 
-- Connect sys/<password> as sysdba;  
CONNECT sys/oracle AS sysdba; 
-- SQLPlus:
-- connect / as sysdba;


------ Create file: vi /u01/app/oracle/product/12.2.0/dbhome_1/network/admin/tnsnames.ora 
----to login with user in PDB01 container:
-- PDB01 = (DESCRIPTION =
--     (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521))
--     (CONNECT_DATA =
--     (SERVER = DEDICATED)
--     (SERVICE_NAME = PDB01.localdomain)     )   )
-- -- Finnaly, restart oracle service

------ Create pdb container:
-- CONNECT / AS sysdba; 
-- show pdbs;
-- col NAME format A12;
alter session set container=cdb$root;
create pluggable database pdb01 admin user SYSADMIN identified by ADMIN
file_name_convert = ('pdbseed', 'pdb01');

alter pluggable database pdb01 open;
alter session set container=pdb01;
show con_name;


------- Create schema that own all table and 
BEGIN
  EXECUTE IMMEDIATE 'DROP USER benhvien CASCADE';
  EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLESPACE benhvien_tbs
    DATAFILE ''/u01/app/oracle/tbs_data01.db'' SIZE 100M
    AUTOEXTEND ON NEXT 100M';
  EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE USER BENHVIEN IDENTIFIED BY ADMIN DEFAULT TABLESPACE benhvien_tbs QUOTA 50M ON benhvien_tbs;


------ then grant privileges
GRANT CREATE SESSION TO benhvien WITH ADMIN OPTION;
GRANT CREATE USER TO benhvien WITH ADMIN OPTION;
GRANT CREATE ROLE TO benhvien WITH ADMIN OPTION;
GRANT SELECT ON dba_users TO benhvien WITH GRANT OPTION;
GRANT SELECT ON dba_role_privs TO benhvien WITH GRANT OPTION;
GRANT CREATE TABLE, CREATE SEQUENCE, CREATE PUBLIC SYNONYM TO benhvien;
GRANT CREATE PROCEDURE, CREATE TRIGGER TO benhvien;


-- config Encrypion
GRANT EXECUTE ON DBMS_CRYPTO TO benhvien WITH GRANT OPTION;
CREATE OR REPLACE PUBLIC SYNONYM DBMS_CRYPTO FOR DBMS_CRYPTO;

-- config VPD 
GRANT EXECUTE ON DBMS_RLS TO benhvien WITH GRANT OPTION;

GRANT CREATE ANY CONTEXT TO benhvien;
GRANT ADMINISTER DATABASE TRIGGER TO benhvien;

-- config OLS
EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;
/
alter session set container=cdb$root;
ALTER USER lbacsys IDENTIFIED BY lbacsys ACCOUNT UNLOCK CONTAINER = ALL;
alter session set container=pdb01;



------ Then, login to benhvien to continue
-- Sql developer: connect with Service name: pdb01.localdomain
-- Or sqlplus:
-- CONN BENHVIEN/ADMIN@//localhost:1521/pdb01.localdomain