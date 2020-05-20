-- connect ADS_PDB_admin/Pa$$w0rd@//10.211.55.6:1521/ADS_PDB as sysdba;
-- create user DIANA identified by Pa$$w0rd;
-- grant create session to DIANA;
-- connect DIANA/Pa$$w0rd@//10.211.55.6:1521/ADS_PDB;
drop user DIANA;

grant create sequence to DIANA;
grant create table to DIANA;
grant select any table to DIANA;
grant insert any table to DIANA;
grant update any table to DIANA;
grant delete any table to DIANA;
grant create cluster to DIANA;
grant create synonym to DIANA;
grant create public synonym to DIANA;
grant create view to DIANA;
grant create materialized view to DIANA;



-- 2. �������� ������������������ (- ������ �� ��� ��������� �������� ������������������) S1 (SEQUENCE), �� ���������� ����������������: ��������� �������� 1000; ���������� 10;
--��� ������������ ��������; ��� ������������� ��������; �� �����������; �������� �� ���������� � ������; ���������� �������� �� �������������.
--�������� ��������� �������� ������������������. �������� ������� �������� ������������������.
create sequence S1
start with 1000
increment by 10
nominvalue
nomaxvalue
nocycle
nocache
noorder;

create global temporary table temp(
id int
)

insert into temp values (S1.NEXTVAL);
insert into temp values (S1.NEXTVAL);
insert into temp values (S1.NEXTVAL);

select * from temp;

set SERVEROUTPUT on;
declare v varchar2(254) := S1.CURRVAL;
BEGIN
DBMS_OUTPUT.PUT_LINE(v);
END;

-- 3. �������� ������������������ S2 (SEQUENCE), �� ���������� ����������������: ��������� �������� 10; ���������� 10; ������������ �������� 100;
drop sequence S2;

create sequence S2
start with 10
increment by 10
nominvalue
maxvalue 100
nocycle
nocache
noorder;

-- 4. �� �����������. �������� ��� �������� ������������������. ����������� �������� ��������, ��������� �� ������������ ��������. ������
set SERVEROUTPUT on;
begin
    for i in 10..100
    loop
    DBMS_OUTPUT.PUT_LINE(S2.nextval);
    end loop;
end;

-- 5. �������� ������������������ S3 (SEQUENCE), �� ���������� ����������������: ��������� �������� 10; ���������� -10; ����������� �������� -100; �� �����������;
--������������� ���������� ��������. �������� ��� �������� ������������������. ����������� �������� ��������, ������ ������������ ��������.
drop sequence S3;

create sequence S3
start with 10
increment by -10
minvalue -100
maxvalue 100
nocycle
nocache
order;

set SERVEROUTPUT on;
begin
    for i in 0..12
    loop
    DBMS_OUTPUT.PUT_LINE(S3.nextval);
    end loop;
end;

-- 6. �������� ������������������ S4 (SEQUENCE), �� ���������� ����������������: ��������� �������� 1; ���������� 1; ����������� �������� 10; �����������;
-- ���������� � ������ 5 ��������; ���������� �������� �� �������������. ����������������� ����������� ��������� �������� ������������������� S4.
drop sequence S4;

create sequence S4
start with 10
increment by 1
minvalue 10
maxvalue 100
cycle
cache 5
noorder;

set SERVEROUTPUT on;
begin
    for i in 0..110
    loop
    DBMS_OUTPUT.PUT_LINE(S4.nextval);
    end loop;
end;

-- 7. �������� ������ ���� ������������������� � ������� ���� ������, ���������� ������� �������� ������������ XXX.
select * from user_objects where object_type='SEQUENCE';

-- 8. �������� ������� T1, ������� ������� N1, N2, N3, N4, ���� NUMBER (20), ���������� � ������������� � �������� ���� KEEP.
-- � ������� ��������� INSERT �������� 7 �����, �������� �������� ��� �������� ������ ������������� � ������� ������������������� S1, S2, S3, S4.
create table T1(
N1 NUMBER (20),
N2 NUMBER (20),
N3 NUMBER (20),
N4 NUMBER (20)
)
cache storage(buffer_pool keep);

begin
    for i in 0..6
    loop
    insert into T1 values(S1.NEXTVAL, S2.NEXTVAL,S3.NEXTVAL, S4.NEXTVAL);
    end loop;
end;

select * from T1;

-- 9. �������� ������� (������ ��, ������� ������ �������� ����� �������� ���� ������ -> ���� ������������������) ABC, ������� hash-��� (������ 200) 
--� ���������� 2 ����: X (NUMBER (10)), V (VARCHAR2(12)).
-- hash - ����������� ��� ����������� ��� ������� ������
create cluster ABC( X number(10),Y varchar2(12))
size 200
hashkeys 2;

-- 10. �������� ������� A, ������� ������� XA (NUMBER (10)) � VA (VARCHAR2(12)), ������������� �������� ABC, � ����� ��� ���� ������������ �������.
create table A( XA NUMBER(10),YA VARCHAR2(12), ZA INT)
cluster ABC(XA, YA);

-- 11. �������� ������� B, ������� ������� XB (NUMBER (10)) � VB (VARCHAR2(12)), ������������� �������� ABC, � ����� ��� ���� ������������ �������.
create table B( XB NUMBER(10),YB VARCHAR2(12), ZB INT)
cluster ABC(XB, YB);

-- 12. �������� ������� �, ������� ������� X� (NUMBER (10)) � V� (VARCHAR2(12)), ������������� �������� ABC, � ����� ��� ���� ������������ �������.
create table C( XC NUMBER(10),YC VARCHAR2(12), ZC INT)
cluster ABC(XC, YC);

-- 13. ������� ��������� ������� � ������� � �������������� ������� Oracle.
select * from USER_OBJECTS;

-- ������� � ��� �������������� ��� �������. ���� ������ ������� ��� �������, �� ��� SQL ������� � ������� ����� ����������� ��������� ��������� ��� ��� �������.
-- ���� ����� ����� ���� �������� �������� � �������� ������� ��������, ����� ��� �������������.
-- ��� �������, �� ����������� ��������, ����� �������������� ������ � ������� �� ������ �����, � �� �� ������, ����� ������������ ������������ � ���, � ����� ����� ��������� ������.
-- ��� ������������ (���!) ����� ������������ ������ ����select * from (��� ��������);
-- ����� �������� ����� �������������� ����� ������������� ���� ��������� �������������� ����� ��� ������������� ����� �����.
-- ��� ����� ���� ��� � ������� �����, ��� �������������� ������ � ������ �����.

-- 14. �������� ������� ������� ��� ������� XXX.� � ����������������� ��� ����������.
drop SYNONYM SYN_FOR_C;

CREATE  SYNONYM SYN_FOR_C  FOR C;
SELECT * FROM SYN_FOR_C;

-- 15. �������� ��������� ������� ��� ������� XXX.B � ����������������� ��� ����������.
drop public synonym SYN_FOR_B;

CREATE  PUBLIC SYNONYM SYN_FOR_B  FOR B;
insert into SYN_FOR_B  VALUES(500,'DF',6);
SELECT * FROM SYN_FOR_B;

-- create user u1 identified by q12345678;
-- drop user u1;

-- 16. �������� ��� ������������ ������� A � B (� ��������� � ������� �������), ��������� �� �������,
--�������� ������������� V1, ���������� �� SELECT... FOR A inner join B. ����������������� ��� �����������������.
create table b1(
id int primary key,
name varchar(20)
);

create table a1(
id int primary key,
product_name varchar(20),
manufactor_id int,
constraint fk_manufactor foreign key (manufactor_id) references b1(id)
);

drop table a1;
drop table b1;

insert into b1 values(1,  'samsung');
insert into b1 values(2,  'apple');

insert into a1 values(1,  'phone1', 1);
insert into a1 values(2,  'phone2', 1);
insert into a1 values(3,  'phone1', 2);
insert into a1 values(4,  'laptop1', 1);
insert into a1 values(5,  'laptop1', 2);
insert into a1 values(6,  'laptop2', 2);

drop view apple_items;
create view apple_items as
select a1.product_name, b1.name from a1
join b1 on a1.manufactor_id = b1.id
where b1.name = 'apple';

select * from apple_items;

drop materialized view MV;
drop table temp;

create table temp(A int);

-- 17. �� ������ ������ A � B �������� ����������������� ������������� MV, ������� ����� ������������� ���������� 2 ������. ����������������� ��� �����������������.
-- ����������������� ��� - ������� �� �����, ���������� �������������� ����� ������� � ������������ ����������� �� ������ ����������� �������.
-- ������������� - ������, ������� ��������� ������ �� ������� �������
create materialized view MV 
refresh complete start with (sysdate) next (sysdate+2/1440)
as select *  from temp;

begin
      for i in 1..10 loop
         insert into temp values (i+1);
      end loop;
end;
commit;

select count(*) from temp;
select count(*) from MV;

EXEC DBMS_MVIEW.REFRESH(list=> 'MV',method => 'C', ATOMIC_REFRESH => FALSE);

-- ������ ���, ����� ����� ������ � �������������, Oracle ������ ��������� ������,�� �������� ���������� �������������, � ������� ���������. 
-- ���� ������� ���������� ������������� ���������� ����������� ������������� (view resolution) � �� ����������� ��� ������ ��������� ������������ � �������������.
-- ���� �� ������ ���� � ��������������� � ���������� ����������� JOIN � GROUP BY, �� ���� ������� ���������� ������������� ����� ����������� ����� ����������� �������. 
-- ���� ����� ����� ���������� � �������������, ����� ������ ������������ ������ ��� ��������� ���������� �������������.

-- ����������������� ������������� Oracle ���������� ����� �� ����� �����������.���������� ������������� ����� ������������ ��� ������������������ �������������, 
-- � ������� �� ������� �������������, ������� ���������� ����������. ��� �������� ����� � ������� �������� ������� ������� ��������. ����������������� �������������
-- ����� ���� �������������� � ��� ������������� ��������� �� ��� �������.