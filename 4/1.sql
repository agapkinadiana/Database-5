-- 1. �������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������� �� ������� ���������.
select * from v$pdbs;

-- 2. ��������� ������ � ORA12W, ����������� �������� �������� �����������.
select * from v$instance;

-- 3. ��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������ � ������.
select comp_name, version, status from dba_registry;

-- 4. �������� ����������� ��������� PDB (���������� ������������ � ������� � ���������� ���������� � �����������
--Database Configuration Assistant) � ������ XXX_PDB, ��� XXX � �������� ��������.

-- 5. �������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������, ��� ��������� PDB-���� ������ ����������.
select * from v$pdbs;

-- 6. ������������ � XXX_PDB c ������� SQL Developer �������� ���������������� ������� (��������� ������������, ����,
--������� ������������, ������������ � ������ U1_XXX_PDB).
create tablespace TS_ADS_PDB 
     datafile 'TS_ADS_PDB'
     size 7M reuse
     autoextend on next 5M
     maxsize 20M;
     
create temporary tablespace TEMP_ADS_PDB 
     tempfile 'TEMP_ADS_PDB'
     size 5M 
     autoextend on next 3M
     maxsize 30M;
     
create role RL_ADS_PDB;

create profile PF_ADS_PDB
  limit
    password_life_time 180 --���-�� ���� ����� ������
    sessions_per_user 3 --���-�� ������ ��� ������������
    failed_login_attempts 7 --���������� ������� �����
    password_lock_time 1 --���-�� ���� ���������� ����� ������
    password_reuse_time 10 --����� ������� ���� ����� ��������� ������
    password_grace_time default --���-�� ���� �������������� � ����� ������
    connect_time 180 --����� ����������, �����
    idle_time 30 --���-�� ����� �������
    ;
    
create user U1_ADS_PDB identified by s1234567
    default tablespace TS_ADS_PDB
    temporary tablespace TEMP_ADS_PDB 
    profile PF_ADS_PDB;
    
drop user U1_ADS_PDB;

-- 7. ������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, �������� ������� XXX_table, 
--�������� � ��� ������, ��������� SELECT-������ � �������.
create table ADS_TABLE(
  id int,
  name varchar(15)
);

--ALTER USER U1_ADS_PDB QUOTA UNLIMITED ON USERS;
insert into ADS_TABLE values (1,'Diana');
insert into ADS_TABLE values(2,'Nastya');

select * from ADS_TABLE;

drop table ADS_TABLE;

-- 8. � ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ���  ����� (������������ � ���������),
--��� ���� (� �������� �� ����������), ������� ������������, ���� �������������  ���� ������ XXX_PDB �  ����������� �� ����.
select * from ALL_USERS;
select * from DBA_TABLESPACES;
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select * from DBA_ROLES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;
select * from DBA_PROFILES;

drop user U1_ADS_PDB;