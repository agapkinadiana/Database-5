--1.	�������� �������, ������� ��������� ���������, ���� �� ������� ��������� ����.
create table Employee
(
	id number primary key,
	fn nvarchar2(50),
  age int,
  salary float,
	CONSTRAINT constraint_fn UNIQUE (fn)
);

--2.	��������� ������� �������� (10 ��.).
insert into Employee values(1, 'Employee 1', 22, 300);
insert into Employee values(2, 'Employee 2', 19, 200);
insert into Employee values(3, 'Employee 3', 35, 900);
insert into Employee values(4, 'Employee 4', 22, 310);
insert into Employee values(5, 'Employee 5', 23, 310);
insert into Employee values(6, 'Employee 6', 24, 420);
insert into Employee values(7, 'Employee 7', 25, 370);
insert into Employee values(8, 'Employee 8', 28, 600);
insert into Employee values(9, 'Employee 9', 27, 630);
insert into Employee values(10, 'Employee 10', 20, 300);

select * from Employee;

--3. �������� BEFORE � ������� ������ ��������� �� ������� INSERT, DELETE � UPDATE.
set serveroutput on;

create or replace trigger before_task3
before insert or update or delete on Employee
begin
  dbms_output.put_line('before_task3');
	if inserting then
      insert into EAUDIT values (CURRENT_DATE, 'inserting', 'before_task3', '������ �� NEW ��� OLD ����������� � ��������� ������ �������');
	elsif updating then
		insert into EAUDIT values (CURRENT_DATE, 'updating', 'before_task3', '������ �� NEW ��� OLD ����������� � ��������� ������ �������');
	elsif deleting then
		insert into EAUDIT values (CURRENT_DATE, 'deleting', 'before_task3', '������ �� NEW ��� OLD ����������� � ��������� ������ �������');
	end if;
end;

update Employee set salary = 750 where id = 3;
select * from eaudit;
drop trigger before_task3;
  
--7.	������������ AFTER-�������� ������ ��������� �� ������� INSERT, DELETE � UPDATE.
create or replace trigger after_task7
after insert or update or delete on Employee
begin
	dbms_output.put_line('after_task7');
  	if inserting then
      insert into EAUDIT values (CURRENT_DATE, 'inserting', 'after_task7', '������ �� NEW ��� OLD ����������� � ��������� ������ �������');
	elsif updating then
		insert into EAUDIT values (CURRENT_DATE, 'updating', 'after_task7', '������ �� NEW ��� OLD ����������� � ��������� ������ �������');
	elsif deleting then
		insert into EAUDIT values (CURRENT_DATE, 'deleting', 'after_task7', '������ �� NEW ��� OLD ����������� � ��������� ������ �������');
	end if;
end;

drop trigger after_task7;

--8.	������������ AFTER-�������� ������ ������ �� ������� INSERT, DELETE � UPDATE.
create or replace trigger after_task8
after insert or update or delete on Employee
for each row
begin
	dbms_output.put_line('after_task8');
    if inserting then
      insert into EAUDIT values (CURRENT_DATE, 'inserting','after_task8', :new.fn || ' ' || :new.age || ' ' || :new.salary);
	elsif updating then
		insert into EAUDIT values (CURRENT_DATE, 'updating', 'after_task8', 'before: ' || :old.salary || 'after: ' || :new.salary);
	elsif deleting then
		insert into EAUDIT values (CURRENT_DATE, 'deleting', 'after_task8', :old.fn || ' ' || :old.age || ' ' || :old.salary);
	end if;
end;

drop trigger after_task8;

--9.	�������� ������� � ������ AUDIT. ������� ������ ��������� ����: OperationDate,
--OperationType (�������� �������, ���������� � ��������),
--TriggerName(��� ��������),
--Data (������ � ���������� ����� �� � ����� ��������).

create table EAUDIT
(
OperationDate DATE,
OperationType nvarchar2(50),
TriggerName nvarchar2(50),
Contant nvarchar2(1000)
);

select * from EAUDIT;
drop table EAUDIT;

--11.	��������� ��������, ���������� ����������� ������� �� ���������� �����. ��������, ��������������� �� ������� ��� �������. ��������� ���������.
insert into Employee values(12, 'Employee 12', 19, 200);

select * from EAUDIT;

--12.������� (drop) �������� �������. ��������� ���������. �������� �������, ����������� �������� �������� �������.
drop table Employee;

create or REPLACE trigger task12
before drop on database
begin
	raise_application_error(-20001, 'No dropping allowed');
end;

drop trigger task12;

--13.
drop table EAUDIT;

select trigger_name, table_name, status from user_triggers;

alter trigger task12 disable;

--14 �������� ������������� ��� �������� ��������. ������������ INSTEADOF INSERT-�������. ������� ������ ��������� ������ � �������.
create view Eview as select * from Employee;

create or REPLACE trigger task14
instead of insert on Eview
for each row
begin
	insert into Employee values(12, 'Employee 12', 19, 200);
end;

insert into Eview values(13, 'Employee 13', 19, 200);

select * from Employee;
select * from Eview;

drop view Eview;