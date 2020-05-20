-- 1. �������� ������ ���� ������ ��������� ����������� (������������  � ���������).
select tablespace_name, file_name from DBA_DATA_FILES;
select tablespace_name, file_name from DBA_TEMP_FILES;

-- 2. �������� ��������� ������������ � ������ XXX_QDATA (10m). ��� �������� ����������
--��� � ��������� offline. ����� ���������� ��������� ������������ � ��������� online. �������� 
--������������ XXX ����� 2m � ������������ XXX_QDATA. �� ����� XXX �  ������������ XXX_T1�������� ������� 
--�� ���� ��������, ���� �� ������� ����� �������� ��������� ������. � ������� �������� 3 ������.
drop tablespace ADS_QDATA including contents and datafiles;

create tablespace ADS_QDATA  
datafile 'ads_qdata_tablespace' size 10M
OFFLINE;

alter tablespace ADS_QDATA ONLINE;

alter session set "_ORACLE_SCRIPT"=true;

create user ADS identified by s1234567
default tablespace ADS_QDATA quota 2M on ADS_QDATA;

create table ADS_T1
(
id int primary key,
name varchar(15)
)
tablespace ADS_QDATA;

insert into ADS_T1 values (1,'oil');
insert into ADS_T1 values (2,'solt');
insert into ADS_T1 values (3,'milk');

select * from ADS_T1;

-- 3. �������� ������ ��������� ���������� ������������  XXX_QDATA. ���������� ������� ������� XXX_T1. ���������� ��������� ��������.
select * from dba_segments where tablespace_name = 'ADS_QDATA';
select * from dba_segments where tablespace_name = 'ADS_T1';
select * from dba_segments;

-- 4. ������� (DROP) ������� XXX_T1. �������� ������ ��������� ���������� ������������  XXX_QDATA. ���������� ������� ������� XXX_T1.
--��������� SELECT-������ � ������������� USER_RECYCLEBIN, �������� ���������.
drop table ADS_T1;

select * from user_recyclebin;

-- 5. ������������ (FLASHBACK) ��������� �������. ???
flashback table ADS_T1 to before drop;

-- 6. ��������� PL/SQL-������, ����������� ������� XXX_T1 ������� (10000 �����).
declare N int := 4;
begin 
    for i in 1..10000 loop
    insert into ADS_T1 values (N, concat('stroka',N));
    N := N+1;
    end loop;
end;

select count(*) from ADS_T1;

-- 7. ���������� ������� � �������� ������� XXX_T1 ���������, �� ������ � ������ � ������. �������� �������� ���� ���������.
select segment_name, extents, blocks, bytes from dba_segments where tablespace_name = 'ADS_QDATA';
select * from dba_extents;

-- 8. ������� ��������� ������������ XXX_QDATA � ��� ����.
drop tablespace ADS_QDATA including contents and datafiles;

-- 9. �������� �������� ���� ����� �������� �������. ���������� ������� ������ �������� �������.\
select * from V$LOG;
select GROUP# from V$LOG where STATUS = 'CURRENT';

-- 10. �������� �������� ������ ���� �������� ������� ��������.
select * from V$LOGFILE;

-- 11. EX. � ������� ������������ �������� ������� �������� ������ ���� ������������. �������� ���������
--����� � ������ ������ ������� ������������ (��� ����������� ��� ���������� ��������� �������). (19:11)
alter system switch logfile;
select group#,sequence#,bytes,members,status,first_change# from v$log;

-- 12. EX. �������� �������������� ������ �������� ������� � ����� ������� �������. ��������� � ������� ������ � ������,
--� ����� � ����������������� ������ (�������������). ���������� ������������������ SCN.
alter database add logfile group 4 'C:\app\oracle\oradata\orcl\REDO04.LOG' size 50m blocksize 512;
select group#,sequence#,bytes,members,status,first_change# from v$log;

alter database add logfile member 'C:\app\oracle\oradata\orcl\REDO041.LOG' TO GROUP 4;
alter database add logfile member 'C:\app\oracle\oradata\orcl\REDO042.LOG' TO GROUP 4;
alter database add logfile member 'C:\app\oracle\oradata\orcl\REDO043.LOG' TO GROUP 4;

alter system switch logfile;
select group#,sequence#,bytes,members,status,first_change# from v$log;

-- 13. EX. ������� ��������� ������ �������� �������. ������� ��������� ���� ����� �������� �� �������.
alter database drop logfile member 'C:\app\oracle\oradata\orcl\REDO041.LOG';
alter database drop logfile member 'C:\app\oracle\oradata\orcl\REDO042.LOG';
alter database drop logfile member 'C:\app\oracle\oradata\orcl\REDO043.LOG';
select group#,sequence#,bytes,members,status,first_change# from v$log;

alter database drop logfile group 4;

-- 14. ����������, ����������� ��� ��� ������������� �������� ������� (������������� ������ ���� ���������,
--����� ���������, ���� ������ ������� �������� ������� � ��������).
select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;

-- 15. ���������� ����� ���������� ������.  
select * from v$log;

-- 16. EX. �������� �������������.
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;

-- 17. EX. ������������� �������� �������� ����. ���������� ��� �����.
--���������� ��� �������������� � ��������� � ��� �������. ���������� ������������������ SCN � ������� � �������� �������.
alter system switch logfile;
select * from v$archived_log;
select instance_name, archiver, active_state from v$instance;
select * from v$log;

-- 18. EX. ��������� �������������. ���������, ��� ������������� ���������.  
startup mount;
alter database noarchivelog;

-- 19. �������� ������ ����������� ������.
show parameter control;
select name from v$controlfile;

-- 20. �������� � ���������� ���������� ������������ �����. �������� ��������� ��� ��������� � �����.
select type, record_size, records_total from v$controlfile_record_section;

-- 21. ���������� �������������� ����� ���������� ��������. ��������� � ������� ����� �����.
select * from v$parameter;

/*C:\app\oracle\admin\orcl\pfile\init.ora file instance*/

-- 22. ����������� PFILE � ������ XXX_PFILE.ORA. ���������� ��� ����������. �������� ��������� ��� ��������� � �����.
select name, value from v$parameter where name = 'open_cursors';
alter system set open_cursors=350 scope=spfile;
create pfile = 'ads_pfile.ora.' from spfile = 'SPFILEORCL.ORA';
/*PRIVILEGES. CREATE FROM SERVER C:\app\oracle\product\12.1.0\dbhome_1\database\ads_pfile.ora*/

-- 23. ���������� �������������� ����� ������� ��������. ��������� � ������� ����� �����.
select * from v$pwfile_users;

show parameter remote_login_passwordfile;
/*C:\app\oracle\product\12.1.0\dbhome_1\database\PWDorcl.ora*/

-- 24. �������� �������� ����������� ��� ������ ��������� � �����������
select * from v$diag_info;

-- 25. EX. ������� � ���������� ���������� ��������� ������ �������� (LOG.XML), ������� � ��� ������� ������������ �������� ������� �� ���������.
/*C:\app\oracle\diag\rdbms\orcl\orcl\alert\log.xml*/