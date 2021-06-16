-- SQLPlus
-- connect / as sysdba;
GRANT EXECUTE DBMS_CRYPTO TO SYSTEM WITH ADMIN OPTION;

CONNECT / as sysdba;

-- oracle 12 fix create user issue
alter session set "_ORACLE_SCRIPT"=true;  

  -- CREATE USER sysadmin IDENTIFIED BY admin QUOTA 10M ON USERS;
-- GRANT ALL PRIVILEGES TO sysadmin;
-- GRANT SELECT ANY DICTIONARY TO sysadmin;