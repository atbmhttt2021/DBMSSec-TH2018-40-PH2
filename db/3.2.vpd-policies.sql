grant excute on DBMS_RLS to public;
create user admin identified by admin;
alter user admin quota unlimited on users;
create context admin using admin.context_package;
create or replace package context_package as
procedure set_context;
end;

create or replace package body context_package is 
procedure set_context is
v_user varchar2(50);
v_id number;
begin 

DBMS_session.set_context('admin','setup','true');
v_user := sys_context('userenv','session_user');
begin

select ID_NHANVIEN
into v_id
from NHANVIEN
where tennv=v_user;
DBMS_session.set_context('admin','user_id',v_id);

EXCEPTION
when NO_DATA_FOUND THEN
DBMS_session.set_context('admin','user_id',0);
end;
DBMS_session.set_context('admin','setup','false');
end set_context;
end context_package;

grant excute on admin.context_package to public;
create or replace public synonym context_package for admin.context_package;

create or replace trigger admin.set_security_context
after logon on database
begin
admin.context_package.set_context;
end;

create or replace package security_package as
function stock_trx_insert_security(owner varchar2, Objname varchar2)
return varchar2;
function stock_trx_select_security(owner varchar2, Objname varchar2)
return varchar2;
end security_package;

create or replace package body security_package is
function stock_trx_select_security(owner varchar2, Objname varchar2)
return varchar2 is
predicate varchar2(2000);
begin
predicate := '1=2';
if(sys_context('userenv','session_user')='admin') THEN
predicate := NULL;
else
predicate := 'account = sys_context("admin","user_id")';
end if;
return predicate;
end stock_trx_select_security;
function stock_trx_insert_security(owner varchar2, Objname varchar2)
return varchar2 is
predicate varchar2(2000);
begin
predicate := '1=2';
if(sys_context('userenv','session_user')='admin') THEN
predicate := NULL;
else
predicate := 'account = sys_context("admin","user_id")';
end if;
return predicate;
end stock_trx_insert_security;
end security_package;

grant excute on admin.security_package to public;
create or replace public synonym security_package for admin.security_package;

begin
DBMS_RLS.ADD_POLICY('admin','stock_trx','stock_trx_insert_policy','admin','security_package.stock_trx_insert_security','insert',true);
DBMS_RLS.ADD_POLICY('admin','stock_trx','stock_trx_select_policy','admin','security_package.stock_trx_select_security','select');
end;