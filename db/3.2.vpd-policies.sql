-- CONNECT benhvien/admin


-------- Setup application CONTEXT--------
create or replace context benhvien using context_package;
/

-- create context package
create or replace package context_package
  AUTHID CURRENT_USER
  as
  procedure set_context;
  procedure set_role_context;
end;
/

--create context package body
create or replace package body context_package is 
  procedure set_context is
  schema_owner varchar2(50) := 'benhvien';
  v_user varchar2(50);
  v_id number;
  begin 
    DBMS_session.set_context(schema_owner,'setup','true');
    v_user := sys_context('userenv','session_user');

    begin
      select ID_NHANVIEN
      into v_id
      from NHANVIEN
      where VAITRO=v_user;

      DBMS_session.set_context(schema_owner,'user_id',v_id);
    EXCEPTION
      when NO_DATA_FOUND THEN
      DBMS_session.set_context(schema_owner,'user_id',0);
    end;

    DBMS_session.set_context(schema_owner,'setup','false');
  end set_context;
  
  procedure set_role_context is
  schema_owner varchar2(50) := 'benhvien';
  v_user varchar2(50);
  v_role varchar2(50);
  begin 
    v_user := sys_context('userenv','session_user');

    begin
      select dv.VAITRO
      into v_role
      from DONVI dv join NHANVIEN nv on dv.ID_DONVI = nv.DONVI
      where nv.VAITRO=v_user;

      DBMS_session.set_context(schema_owner,'role',v_role);
    EXCEPTION
      when NO_DATA_FOUND THEN
      DBMS_session.set_context(schema_owner,'role',null);
    end;

  end set_role_context;
end context_package;
/

-- grant context to all user
create or replace public synonym context_package for context_package;
grant execute on context_package to public;
/

--set context
create or replace trigger set_security_context
after logon on database
begin
  context_package.set_context;
  context_package.set_role_context;
end;
/


-------- Setup VPD --------


--create VPD policy 1: NHANVIEN only see their info

-- Grant select to all user
grant select on donvi to public;
grant select on nhanvien to public;

-- create package
create or replace package vpd_security_package 
  AUTHID CURRENT_USER 
  as
  function donvi_on_select_security(owner varchar2, Objname varchar2)
  return varchar2;
  function nhanvien_on_select_security(owner varchar2, Objname varchar2)
  return varchar2;
  function hosobenhan_on_bacsi_select_security(owner varchar2, Objname varchar2)
  return varchar2;

end vpd_security_package;
/

--create package body
create or replace package body vpd_security_package is

  -- Setup policy VPD 1
  function nhanvien_on_select_security(owner varchar2, Objname varchar2)
    return varchar2 is
    v_user varchar2(50);
    v_role varchar2(50);
    predicate varchar2(2000);
    begin
      -- predicate := NULL;
      v_user := sys_context('USERENV','SESSION_USER');
      v_role := sys_context('benhvien','role');
      
      if v_user='BENHVIEN' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_QUANLY_TAINGUYEN_NHANSU' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_QUANLY_TAIVU' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_QUANLY_CHUYENMON' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_KETOAN' THEN
        predicate := NULL;
      elsif sys_context('benhvien','user_id') > 0 THEN
        predicate := 'ID_NHANVIEN=sys_context(''benhvien'',''user_id'')';
      end if;
    return predicate;
  end nhanvien_on_select_security;

  -- Setup policy VPD 2
  function hosobenhan_on_bacsi_select_security(owner varchar2, Objname varchar2)
    return varchar2 is
    predicate varchar2(2000);
    begin
      if sys_context('USERENV','SESSION_USER')='BENHVIEN' THEN
        predicate := NULL;
      elsif sys_context('benhvien','role')='NHANVIEN_QUANLY_TAINGUYEN_NHANSU' THEN
        predicate := NULL;
      elsif sys_context('benhvien','role')='NHANVIEN_QUANLY_TAIVU' THEN
        predicate := NULL;
      elsif sys_context('benhvien','role')='NHANVIEN_QUANLY_CHUYENMON' THEN
        predicate := NULL;
      elsif sys_context('benhvien','role')='NHANVIEN_TAIVU' THEN
        predicate := NULL;
      elsif sys_context('benhvien','role')='NHANVIEN_TIEPTAN_DIEUPHOI' THEN
        predicate := 'MATT=sys_context(''benhvien'',''user_id'')';
      else
        predicate := 'MABS=sys_context(''benhvien'',''user_id'')';
      end if;
    return predicate;
  end hosobenhan_on_bacsi_select_security;

  -- policy 3
  function donvi_on_select_security(owner varchar2, Objname varchar2)
    return varchar2 is
    v_user varchar2(50);
    v_role varchar2(50);
    predicate varchar2(2000);
    begin
      v_user := sys_context('USERENV','SESSION_USER');
      v_role := sys_context('benhvien','role');
      
      if v_user='BENHVIEN' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_QUANLY_TAINGUYEN_NHANSU' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_QUANLY_TAIVU' THEN
        predicate := NULL;
      elsif v_role='NHANVIEN_QUANLY_CHUYENMON' THEN
        predicate := NULL;
      elsif v_role IS NOT NULL THEN
        predicate := 'VAITRO=sys_context(''benhvien'',''role'')';
      end if;
    return predicate;
  end donvi_on_select_security;

end vpd_security_package;
/

-- grant policy to all user
grant execute on vpd_security_package to public;
create or replace public synonym vpd_security_package for vpd_security_package;
/


begin
-- add policy VPD 1
  DBMS_RLS.ADD_POLICY(
    object_schema => 'benhvien',
    object_name => 'nhanvien',
    policy_name => 'nhanvien_on_select_policy',
    function_schema => 'benhvien',
    policy_function => 'vpd_security_package.nhanvien_on_select_security',
    statement_types => 'select');

-- add policy VPD 2
  DBMS_RLS.ADD_POLICY(
    object_schema => 'benhvien',
    object_name => 'hosobenhnhan',
    policy_name => 'hosobenhnhan_on_bacsi_select_policy',
    function_schema => 'benhvien',
    policy_function => 'vpd_security_package.hosobenhan_on_bacsi_select_security',
    statement_types => 'select');

-- add policy VPD 3
  DBMS_RLS.ADD_POLICY(
    object_schema => 'benhvien',
    object_name => 'donvi',
    policy_name => 'donvi_on_select_policy',
    function_schema => 'benhvien',
    policy_function => 'vpd_security_package.donvi_on_select_security',
    statement_types => 'select');
exception
   when others then null;
end;
/