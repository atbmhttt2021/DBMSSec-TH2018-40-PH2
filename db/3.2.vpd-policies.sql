-- CONNECT benhvien/admin


-------- Setup application CONTEXT--------
create or replace context benhvien using context_package;
/

-- create context package
create or replace package context_package as
  procedure set_context;
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
      from benhvien.NHANVIEN
      where VAITRO=v_user;

      DBMS_session.set_context(schema_owner,'user_id',v_id);
    EXCEPTION
      when NO_DATA_FOUND THEN
      DBMS_session.set_context(schema_owner,'user_id',0);
    end;

    DBMS_session.set_context(schema_owner,'setup','false');
  end set_context;
end context_package;
/

-- grant context to all user
create or replace public synonym context_package for context_package;
grant execute on context_package to public;
/

--set context CONNECT sys/password@service AS SYSDBA;
create or replace trigger set_security_context
after logon on database
begin
  context_package.set_context;
end;
/


-------- Setup VPD --------


--create VPD policy 1: NHANVIEN only see their info

-- Grant select to all user
grant select on nhanvien to public;

-- create package
create or replace package vpd_security_package as
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
    predicate varchar2(2000);
    begin
      predicate := '1=2';
      if(sys_context('USERENV','SESSION_USER')='BENHVIEN') THEN
        predicate := NULL;
      elsif(sys_context('sys_session_roles', 'NHANVIEN_QUANLY')='TRUE') THEN
        predicate := NULL;
      elsif(sys_context('sys_session_roles', 'NHANVIEN_KETOAN')='TRUE') THEN
        predicate := NULL;
      else
        predicate := 'ID_NHANVIEN=sys_context(''benhvien'',''user_id'')';
      end if;
    return NULL;
  end nhanvien_on_select_security;

  -- Setup policy VPD 2
  function hosobenhan_on_bacsi_select_security(owner varchar2, Objname varchar2)
    return varchar2 is
    predicate varchar2(2000);
    begin
      predicate := '1=2';
      if(sys_context('USERENV','SESSION_USER')='BENHVIEN') THEN
        predicate := NULL;
      else
        predicate := 'MABS=sys_context(''benhvien'',''user_id'')';
      end if;
    return predicate;
  end hosobenhan_on_bacsi_select_security;


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

exception
   when others then null;
end;
/