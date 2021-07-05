
--Connect lbacsys
conn lbacsys/lbacsys;
grant execute on sa_components to benhvien with grant option;
grant execute on sa_user_admin to benhvien with grant option;
grant execute on sa_label_admin to benhvien with grant option;
grant execute on sa_policy_admin to benhvien with grant option;
grant execute on sa_audit_admin to benhvien with grant option;

grant lbac_dba to benhvien;
grant execute on sa_sysdba to benhvien;
grant execute on to_lbac_data_label to benhvien;

BEGIN
   sa_sysdba.drop_policy(policy_name => 'THONGBAO_ols_pol');
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP ROLE THONGBAO_OLS_POL_DBA';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

EXEC sa_sysdba.create_policy(policy_name => 'THONGBAO_ols_pol', column_name => 'ols_col', default_options => 'all_control');
col policy_options FOR a50 word_wrapped
col column_name FOR a10

GRANT THONGBAO_ols_pol_dba TO benhvien;

--Level
EXEC sa_components.create_level(policy_name => 'THONGBAO_ols_pol', level_num => 5000, short_name => 'P', long_name => 'PUBLIC');
EXEC sa_components.create_level(policy_name => 'THONGBAO_ols_pol', level_num => 6000, short_name => 'C', long_name => 'CONFIDENTIAL');
col long_name FOR a20
--Compartment
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 10, short_name => 'BT', long_name => 'PHONG BAN THUOC');
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 20, short_name => 'TTDP', long_name => 'PHONG TIEP TAN VA DIEU PHOI');
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 30, short_name => 'BS', long_name => 'BAC SI'); 
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 40, short_name => 'TV', long_name => 'PHONG TAI VU');
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 50, short_name => 'KT', long_name => 'PHONG KE TOAN');
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 100, short_name => 'QLCM', long_name => 'PHONG QUAN LY CHUYEN MON');
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 110, short_name => 'QLTV', long_name => 'PHONG QUAN LY TAI VU');
EXEC sa_components.create_compartment(policy_name => 'THONGBAO_ols_pol',comp_num => 120, short_name => 'QLTN', long_name => 'PHONG QUAN LY TAI NGUYEN');

--Group
EXEC sa_components.create_group(policy_name => 'THONGBAO_ols_pol', group_num => 1000, short_name => 'DKTD', long_name => 'BENH VIEN DA KHOA KHU VUC THU DUC');
EXEC sa_components.create_group(policy_name => 'THONGBAO_ols_pol', group_num => 2000, short_name => 'DKSG', long_name => 'BENH VIEN DA KHOA SAI GON');
EXEC sa_components.create_group(policy_name => 'THONGBAO_ols_pol', group_num => 2010, short_name => 'NDHCM', long_name => 'BENH VIEN NHIET DOI HO CHI MINH');
col long_name FOR a30



conn BENHVIEN/ADMIN;
--Label function
CREATE OR REPLACE FUNCTION gen_THONGBAO_label(ID_CHINHANH VARCHAR2, ID_DONVI integer)
RETURN lbacsys.lbac_label
AS
  i_label VARCHAR2(80);
BEGIN
  IF ID_DONVI IS NOT NULL THEN
    i_label := 'C:';

    CASE ID_DONVI
      WHEN 2 THEN i_label := i_label || 'QLTN:';
      WHEN 3 THEN i_label := i_label || 'QLTV:';
      WHEN 4 THEN i_label := i_label || 'QLCM:';
      WHEN 5 THEN i_label := i_label || 'TTDP:';
      WHEN 6 THEN i_label := i_label || 'TV:';
      WHEN 7 THEN i_label := i_label || 'BT:';
      WHEN 8 THEN i_label := i_label || 'KT:';
      WHEN 9 THEN i_label := i_label || 'BS:';
    END CASE;
  ELSE
    i_label := 'P:';
  END IF;

  CASE ID_CHINHANH
	  WHEN 'BV001' THEN i_label := i_label || 'DTKD';
	  WHEN 'BV002' THEN i_label := i_label || 'DKSG';
    WHEN 'BV003' THEN i_label := i_label || 'NDHCM';
  END CASE;
  RETURN to_lbac_data_label('THONGBAO_ols_pol',i_label);
END;
/

BEGIN
sa_policy_admin.apply_table_policy(policy_name => 'THONGBAO_ols_pol', 
schema_name => 'benhvien', 
table_name => 'THONGBAO',
label_function => 'gen_THONGBAO_label(:new.ID_CHINHANH,:new.ID_DONVI)');
END;
/


EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTN01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTN01', read_comps => 'QLTN');
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTN01', read_groups => 'DKTD');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTV01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTV01', read_comps => 'QLTV')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTV01', read_groups => 'DKSG');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTCM01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTCM01', read_comps => 'QLTV')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVQLTCM01', read_groups => 'NDHCM');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVTT01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVTT01', read_comps => 'TTDP')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVTT01', read_groups => 'DKTD');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVBT01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVBT01', read_comps => 'BT')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVBT01', read_groups => 'DKSG');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVTV01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVTV01', read_comps => 'TV')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVTV01', read_groups => 'NDHCM');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'NVKT01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'NVKT01', read_comps => 'KT')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'NVKT01', read_groups => 'DKTD');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'BS01', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'BS01', read_comps => 'BS')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'BS01', read_groups => 'DKSG');

EXEC sa_user_admin.set_levels(policy_name => 'THONGBAO_ols_pol', user_name => 'BS02', max_level => 'C');
EXEC sa_user_admin.set_compartments(policy_name => 'THONGBAO_ols_pol', user_name => 'BS02', read_comps => 'BS')
exec sa_user_admin.set_groups(policy_name => 'THONGBAO_ols_pol', user_name => 'BS02', read_groups => 'NDHCM');







