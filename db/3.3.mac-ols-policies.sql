-- -- Check if OLS is active on your database:
-- SELECT VALUE FROM v$option WHERE parameter = 'Oracle Label Security';

EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

create user ols_test IDENTIFIED by ols123 default tablespace users temporary tablespace temp;
grant connect, resource, select_catalog_role to ols_test;
ALTER USER lbacsys IDENTIFIED BY tannguyen1011 account unlock;
--Connect lbacsys
conn lbacsys/tannguyen1011
grant execute on sa_components to ols_test with grant option;
grant execute on sa_user_admin to ols_test with grant option;
grant execute on sa_label_admin to ols_test with grant option;
grant execute on sa_policy_admin to ols_test with grant option;
grant execute on sa_audit_admin to ols_test with grant option;

grant lbac_dba to ols_test;
grant execute on sa_sysdba to ols_test;
grant execute on to_lbac_data_label to ols_test;

EXEC sa_sysdba.create_policy(policy_name => 'HOSO_DICHVU_ols_pol', column_name => 'ols_col', default_options => 'all_control');
col policy_options FOR a50 word_wrapped
col column_name FOR a10

GRANT HOSO_DICHVU_ols_pol_dba TO ols_test;
--Level
EXEC sa_components.create_level(policy_name => 'HOSO_DICHVU_ols_pol', level_num => 10, short_name => 'P', long_name => 'PUBLIC');
EXEC sa_components.create_level(policy_name => 'HOSO_DICHVU_ols_pol', level_num => 20, short_name => 'C', long_name => 'CONFIDENTIAL');
col long_name FOR a20
--Compartment
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '10', short_name => 'KTQ', long_name => 'KHAM TONG QUAT');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '20', short_name => 'SA3D', long_name => 'SIEU AM 3D');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '30', short_name => 'XQ', long_name => 'CHUP X QUANG');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '40', short_name => 'SS', long_name => 'KHAM SO SINH');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '50', short_name => 'DLCHO', long_name => 'DINH LUONG CHOLESTEROL');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '60', short_name => 'TRC', long_name => 'TRAM RANG CAI');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '70', short_name => 'TRRC', long_name => 'TRONG RANG RANG CAI');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '80', short_name => 'BR', long_name => 'BOC RANG SU CAI');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '90', short_name => 'LCR', long_name => 'LAY CAO RANG');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '100', short_name => 'NM', long_name => 'NANG MUI');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '110', short_name => 'DTTT', long_name => 'DIEU TRI DUC THUY TINH THE');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '120', short_name => 'ST', long_name => 'SANH THUONG');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '130', short_name => 'SM', long_name => 'SANH MO');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '140', short_name => 'XNM', long_name => 'XET NGHIEM MAU');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '150', short_name => 'XNNT', long_name => 'XET NGHIEM NUOC TIEU');
EXEC sa_components.create_compartment(policy_name => 'HOSO_DICHVU_ols_pol',comp_num => '160', short_name => 'ADN', long_name => 'XET NGHIEM ADN');
--Group
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 1000, short_name => 'NKK', long_name => 'NGUYEN KIM KHANH');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 2000, short_name => 'LTH', long_name => 'LY THI HIEN');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 2010, short_name => 'PMT', long_name => 'PHAN MINH TRANG');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 2020, short_name => 'NQN', long_name => 'NGUYEN QUYNH NHU');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 2030, short_name => 'PAM', long_name => 'PHAN ANH MINH');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 3000, short_name => 'LNB', long_name => 'LY NGOC BINH');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 3010, short_name => 'TVQ', long_name => 'TRAN VAN QUYET');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 3020, short_name => 'NNH', long_name => 'NGUYEN NGOC HOA');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 3030, short_name => 'PKU', long_name => 'PHAN KIM UYEN');
EXEC sa_components.create_group(policy_name => 'HOSO_DICHVU_ols_pol', group_num => 3040, short_name => 'LVA', long_name => 'LY VAN AN');
col long_name FOR a30
--Label function
CREATE OR REPLACE FUNCTION gen_HOSO_DICHVU_label(ID_KHAMBENH integer, ID_DICVU integer, NGAYGIO timestamp, KETLUAN NVARCHAR2(100),NGUOITHUCHIEN integer)
RETURN lbacsys.lbac_label
AS
  i_label VARCHAR2(80);
BEGIN
  IF ID_DICHVU='1' || ID_DICHVU='3' || ID_DICHVU='5' || ID_DICHVU='7' || ID_DICHVU='9' || ID_DICHVU='11' || ID_DICHVU='13' || ID_DICHVU='15' THEN
    i_label := 'C:';
  ELSE
    i_label := 'P:';
  END IF;
  CASE ID_DICHVU
	  WHEN '1' THEN i_label := i_label || 'KTQ:';
	  WHEN '2' THEN i_label := i_label || 'SA3D:';
      WHEN '3' THEN i_label := i_label || 'XQ:';
	  WHEN '4' THEN i_label := i_label || 'SS:';
      WHEN '5' THEN i_label := i_label || 'DLCHO:';
      WHEN '6' THEN i_label := i_label || 'TRC:';
      WHEN '7' THEN i_label := i_label || 'TRRC:';
      WHEN '8' THEN i_label := i_label || 'BR:';
      WHEN '9' THEN i_label := i_label || 'LCR:';
      WHEN '10' THEN i_label := i_label || 'NM:';
      WHEN '11' THEN i_label := i_label || 'DTTT:';
      WHEN '12' THEN i_label := i_label || 'ST:';
      WHEN '13' THEN i_label := i_label || 'SM:';
      WHEN '14' THEN i_label := i_label || 'XNM:';
      WHEN '15' THEN i_label := i_label || 'XNNT:';
      WHEN '16' THEN i_label := i_label || 'ADN:';
  END CASE;
  CASE NGUOITHUCHIEN
	  WHEN '1' THEN i_label := i_label || 'NKK';
	  WHEN '2' THEN i_label := i_label || 'LTH';
	  WHEN '3' THEN i_label := i_label || 'PMT';
	  WHEN '4' THEN i_label := i_label || 'NQN';
	  WHEN '5' THEN i_label := i_label || 'PAM';
      WHEN '6' THEN i_label := i_label || 'LNB';
      WHEN '7' THEN i_label := i_label || 'TVQ';
      WHEN '8' THEN i_label := i_label || 'NNH';
      WHEN '9' THEN i_label := i_label || 'PKU';
      WHEN '10' THEN i_label := i_label || 'LVA';
  END CASE;
 
  RETURN to_lbac_data_label('HOSO_DICHVU_ols_pol',i_label);
END;
--
EXEC sa_policy_admin.apply_table_policy(policy_name => 'HOSO_DICHVU_ols_pol', 
schema_name => 'ols_test', 
table_name => 'HOSO_DICHVU',
table_options => 'all_control', 
label_function => 'app.gen_HOSO_DICHVU_label(:new.ID_DICHVU,:new.NGUOITHUCHIEN)');

















