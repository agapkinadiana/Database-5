-- 1. ���������� ����� ������ ������� SGA.
select sum(value) from v$sga;

-- 2. ���������� ������� ������� �������� ����� SGA.
select * from v$sga_dynamic_components;

-- 3. ���������� ������� ������� ��� ������� ����.
select component, granule_size from v$sga_dynamic_components;

-- 4. ���������� ����� ��������� ��������� ������ � SGA.
set SERVEROUTPUT on;
declare f int:=0;
        c int:=0;
        r int:=0;
begin 
    select sum(value) into f from v$sga;
    select current_size into c from v$sga_dynamic_free_memory;
    r := f-c;
    DBMS_OUTPUT.PUT_LINE(r);
end;

-- 5. ���������� ������� ����� ���P, DEFAULT � RECYCLE ��������� ����.
select COMPONENT,  CURRENT_SIZE  from v$sga_dynamic_components;

-- 6. �������� �������, ������� ����� ���������� � ��� ���P. ����������������� ������� �������.
create table myTable(k int) storage(buffer_pool keep) tablespace users;
insert into myTable values(1);

select SEGMENT_NAME, BUFFER_POOL from user_segments WHERE SEGMENT_NAME = 'MYTABLE' ; 

drop table myTable;

-- 7. �������� �������, ������� ����� ������������ � ���� default. ����������������� ������� �������.
create table myTableDefault(k int) cache storage(buffer_pool default) tablespace users;
insert into myTableDefault values(1);

select SEGMENT_NAME, BUFFER_POO from user_segments where segment_name='MYTABLEDEFAULT';

drop table myTableDefault;

-- 8. ������� ������ ������ �������� �������.
show parameter log_buffer;

-- 9. ������� 10 ����� ������� �������� � ����������� ����.
select * from v$sgastat where pool = 'shared pool'
order by bytes desc
fetch first 10 rows only;

-- 10. ������� ������ ��������� ������ � ������� ����.
set SERVEROUTPUT on;
declare m1 int := 0;
    c1 int := 0;
    f1 int := 0;
begin
    select max_size into m1  from v$sga_dynamic_components where component = 'large pool';
    select current_size into c1 from v$sga_dynamic_components where component = 'large pool';
    f1 := m1-c1;
    DBMS_OUTPUT.PUT_LINE(f1);
end;

-- 11. �������� �������� ������� ���������� � ���������.
-- 12. ���������� ������ ������� ���������� � ��������� (dedicated, shared).
select username, service_name, server, osuser,machine, program from v$session where username is not null;

-- 13. *������� ����� ����� ������������ ������� � ���� ������.

