
--  Encrypt function
DECLARE
BEGIN
DBMS_DDL.CREATE_WRAPPED('
  CREATE OR REPLACE FUNCTION ENCRYPTSALARY_FUNC (USERNAME_IN IN VARCHAR2, SALARY_IN IN VARCHAR2)
    RETURN RAW
  IS
    USER_EXISTS VARCHAR2(100);
    KEY_RAW  RAW(500);
    SALARY_RAW RAW(500);
    ENCRYPTED_RAW  RAW(500);
    ENC_TYPE NUMBER :=  DBMS_CRYPTO.ENCRYPT_AES
          + DBMS_CRYPTO.CHAIN_CBC
          + DBMS_CRYPTO.PAD_PKCS5;
  BEGIN
    SELECT MAX(K_USER) INTO USER_EXISTS FROM K_SALARY WHERE K_USER = USERNAME_IN AND ROWNUM = 1;
    IF USER_EXISTS IS NOT NULL THEN
      DELETE FROM K_SALARY WHERE K_USER = USER_EXISTS;
    END IF;

    KEY_RAW  := DBMS_CRYPTO.RANDOMBYTES(24);
    SALARY_RAW  := UTL_RAW.CAST_TO_RAW(SALARY_IN);

    INSERT INTO K_SALARY(K_USER, K_KEY) VALUES(USERNAME_IN, KEY_RAW);

    ENCRYPTED_RAW :=
      DBMS_CRYPTO.ENCRYPT
      (
        SALARY_RAW,
        ENC_TYPE, 
        KEY_RAW 
      );
    RETURN ENCRYPTED_RAW;
  END;
  ');
END;
/


--  Decrypt function (called when NHAN VIEN select LUONG from NHANVIEN table)
DECLARE
BEGIN
DBMS_DDL.CREATE_WRAPPED('
  CREATE OR REPLACE FUNCTION DECRYPTSALARY_FUNC
    RETURN VARCHAR2
  IS
    V_OSUSER VARCHAR2(100);
    KEY_RAW  VARCHAR2(500);
    SALARY_RAW VARCHAR2(500);
    SALARY_RET VARCHAR2(500);
    DECRYPTED_RAW  RAW(500);
    ENC_TYPE NUMBER :=  DBMS_CRYPTO.ENCRYPT_AES
          + DBMS_CRYPTO.CHAIN_CBC
          + DBMS_CRYPTO.PAD_PKCS5;
  BEGIN
    V_OSUSER := SYS_CONTEXT (''USERENV'', ''SESSION_USER'');
    SELECT MAX(LUONG) INTO SALARY_RAW FROM NHANVIEN WHERE VAITRO = V_OSUSER AND ROWNUM = 1;
    SELECT MAX(K_KEY) INTO KEY_RAW FROM K_SALARY WHERE K_USER = V_OSUSER AND ROWNUM = 1;
          
    IF KEY_RAW IS NULL
      THEN RETURN NULL;
    END IF;

    DECRYPTED_RAW :=
      DBMS_CRYPTO.DECRYPT
      (
        SALARY_RAW,
        ENC_TYPE,
        KEY_RAW
      );
    SALARY_RET := UTL_RAW.CAST_TO_VARCHAR2(DECRYPTED_RAW);
    RETURN SALARY_RET;
  END;
  ');
END;
/


-- create synonym
CREATE OR REPLACE PUBLIC SYNONYM ENCRYPTSALARY_FUNC FOR ENCRYPTSALARY_FUNC;
CREATE OR REPLACE PUBLIC SYNONYM DECRYPTSALARY_FUNC FOR DECRYPTSALARY_FUNC;


-- trigger on save salary

CREATE OR REPLACE TRIGGER encrypt_salary_trigger
BEFORE INSERT OR UPDATE OF LUONG
ON NHANVIEN
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  V_ENC_SALARY RAW(500);
BEGIN
  IF :NEW.VAITRO IS NOT NULL
  THEN
      V_ENC_SALARY := ENCRYPTSALARY_FUNC(:NEW.VAITRO, :NEW.LUONG);
      :NEW.LUONG := V_ENC_SALARY;
  END IF;
END salary_trigger;
/


-- trigger on save sub salary

CREATE OR REPLACE TRIGGER encrypt_salary_trigger
BEFORE INSERT OR UPDATE OF PHUCAP
ON NHANVIEN
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  V_ENC_SALARY RAW(500);
BEGIN
  IF :NEW.VAITRO IS NOT NULL
  THEN
      V_ENC_SALARY := ENCRYPTSALARY_FUNC(:NEW.VAITRO, :NEW.PHUCAP);
      :NEW.PHUCAP := V_ENC_SALARY;
  END IF;
END salary_trigger;
/