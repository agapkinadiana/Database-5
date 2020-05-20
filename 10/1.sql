DROP TABLE FACULTY
CREATE TABLE FACULTY
  (
   FACULTY      CHAR(10)      NOT NULL,
   FACULTY_NAME VARCHAR2(100), 
   CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY) 
  );
     
delete FACULTY;
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('����',   '����������� ���� � ����������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');

--------------------------------------------------------------------------------------------
DROP TABLE PULPIT
CREATE TABLE PULPIT 
(
 PULPIT       CHAR(20)      NOT NULL,
 PULPIT_NAME  VARCHAR2(160), 
 FACULTY      CHAR(10)      NOT NULL, 
 CONSTRAINT FK_PULPIT_FACULTY FOREIGN KEY(FACULTY)   REFERENCES FACULTY(FACULTY), 
 CONSTRAINT PK_PULPIT PRIMARY KEY(PULPIT) 
 ); 
 
delete PULPIT;  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('����',    '������������� ������ � ���������� ',                         '����'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('������', '���������������� ������������ � ������ ��������� ���������� ', '����'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
              values  ('��',      '�����������',                                                 '���') ;         
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',      '������������',                                                 '���') ;   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',      '��������������',                                              '���');           
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('�����',   '���������� � ����������������',                               '���');                
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('������',  '������������ �������������� � ������-��������� �������������','���');                  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',     '���������� ����',                                              '����');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('�����',  '������ ����� � ���������� �������������',                      '����');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',     '������������ �����',                                           '���');            
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                              FACULTY)
             values  ('��������','���������� ���������������� ������� � ����������� ���������� ����������','���');             
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('�������','���������� �������������� ������� � ����� ���������� ���������� ','����');                    
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                                         FACULTY)
             values  ('��������','�����, ���������� ����������������� ����������� � ���������� ����������� �������', '����');
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('����',    '������������� ������ � ����������',                              '���');   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('����',   '����������� � ��������� ������������������',                      '���');    
------------------------------------------------------------------------------------------------------------------------ 
DROP  TABLE TEACHER
CREATE TABLE TEACHER
 ( 
  TEACHER       CHAR(20) NOT  NULL,
  TEACHER_NAME  VARCHAR2(100), 
  PULPIT        CHAR(20) NOT NULL, 
  CONSTRAINT PK_TEACHER  PRIMARY KEY(TEACHER), 
  CONSTRAINT FK_TEACHER_PULPIT FOREIGN   KEY(PULPIT)   REFERENCES PULPIT(PULPIT)
 ) ;
 
 
delete  TEACHER;
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT )
                       values  ('����',    '������ �������� �������������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',    '�������� ��������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',    '���������� ������ ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',    '������ ���� �����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',    '������� �������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',    '�������� ������ ���������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '����� ��������� ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '������� ��������� �����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '��������� ����� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',     '��������� ������� ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',  '����������� ������� ����������', '����' );
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('?',     '�����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                      values  ('���',     '����� ������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '����� ������� �������������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '���������� ��������� �������������',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',   '������� ������ ����������',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '����������� ��������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������� ��������� ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������ ������ ��������',  '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����', '������� ������ ����������',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '���������� �������� ��������',  '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',   '������ ���������� ������������',  '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',   '��������� �������� ���������',  '�����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '���������� �������� ����������',  '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '��������� ������� ���������',  '��������'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',   '�������� ������ ����������',  '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',   '����� ������ ��������',  '�����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������ ������� ���������',  '�������'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������� ���� ����������',  '��������'); 
---------------------------------------------------------------------------------------------------------------------
DROP TABLE SUBJECT 
CREATE TABLE SUBJECT
    (
     SUBJECT      CHAR(20)     NOT NULL, 
     SUBJECT_NAME VARCHAR2(100)  NOT NULL,
     PULPIT       CHAR(20)     NOT NULL,  
     CONSTRAINT PK_SUBJECT PRIMARY KEY(SUBJECT),
     CONSTRAINT FK_SUBJECT_PULPIT FOREIGN  KEY(PULPIT)  REFERENCES PULPIT(PULPIT)
    );

delete SUBJECT;
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '������� ���������� ������ ������',                   '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('��',     '���� ������',                                        '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '�������������� ����������',                          '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',  '������ �������������� � ����������������',            '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������',       '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '��������������� ������� ����������',                 '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',     '������������� ������ ��������� ����������',        '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '�������������� �������������� ������',              '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',      '������������ ��������� ',                           '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('�����',   '��������������� ������, �������� � �������� �����', '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '������������ �������������� �������',               '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '����������� ���������������� ������������',         '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                            PULPIT)
               values ('��',   '���������� ���������',                     '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('��',   '�������������� ����������������',          '����');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('����', '���������� ������ ���',                     '����');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '��������� ������������������',                       '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '������������� ������',                               '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('������OO','�������� ������ ������ � ���� � ���. ������.',      '��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('�������','������ ��������������� � ������������� ���������',  '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '���������� �������� ',                              '��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',    '�����������',                                        '�����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',    '������������ �����',                                 '��');   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '���������� ��������� �������',                      '��������'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '������ ��������� ����',                             '��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '���������� � ������������ �������������',           '�����'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '���������� ���������� �������� ���������� ',        '�������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '���������� ������������',                           '��������');          
---------------------------------------------------------------------------------------------------------------------
DROP TABLE AUDITORIUM_TYPE 
create table AUDITORIUM_TYPE 
(
  AUDITORIUM_TYPE   char(20) constraint AUDITORIUM_TYPE_PK  primary key,  
  AUDITORIUM_TYPENAME  varchar2(60) constraint AUDITORIUM_TYPENAME_NOT_NULL not null         
);

delete AUDITORIUM_TYPE;
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��',   '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-�',   '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-�', '���������� � ���. ������������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-X', '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-��', '����. ������������ �����');
---------------------------------------------------------------------------------------------------------------------
-- DROP TABLE AUDITORIUM 
create table AUDITORIUM 
(
 AUDITORIUM           char(20) primary key,  -- ��� ���������
 AUDITORIUM_NAME      varchar2(200),          -- ��������� 
 AUDITORIUM_CAPACITY  number(4),              -- �����������
 AUDITORIUM_TYPE      char(20) not null      -- ��� ���������
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE)  
);

delete  AUDITORIUM;
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('206-1',   '206-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
                       values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('236-1',   '236-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('313-1',   '313-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('324-1',   '324-1', '��',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('423-1',   '423-1', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('408-2',   '408-2', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('103-4',   '103-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('105-4',   '105-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('107-4',   '107-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('110-4',   '110-4', '��',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('111-4',   '111-4', '��',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                      values  ('114-4',   '114-4', '��-�',  90 );
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('132-4',   '132-4', '��',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('02�-4',   '02�-4', '��',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('229-4',   '229-4', '��',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('304-4',   '304-4','��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('314-4',   '314-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('320-4',   '320-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('429-4',   '429-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                        values  ('?',   '???', '��',  90);
-----------------------------------------------------------------------------------------------------------------------
-- PL/SQL ��� ���������������� �������� ��������. �� ������������ � ��������

-- ������ ��������� (������ ������ ����������). �� ������
-- ������ ���������� - ��� ���������� ����������, ��������, ��������� ������. �� ������
-- ����������� ������ - �������. ������
-- ������ ���������� - �� ���������. �� ������

-- ��������� ���� - ���� � �����, ������������ ������� ��������� � �������� ��������� ����. ��������� ������ �����

-- PL/SQL - Oracle + ���� �����

-- ��������� �������� � Oracle - �������� ��������� - ������ ��������������� ��� ������������������ ���� �� ���������.
-- ���������� - ����-�� �������� (nls_length_semantics)

-- ���������� Oracle: char, nchar, varchar2, nvarchar2, long, row(n), long row, clob, nlob, blob, bfile
-- ���������� PL/SQL: char (���� ������� CHARACTER � STRING), varchar2 (���� ������ VARCHAR) + Oracle

-- �������� Oracle: number (n, s)
-- �������� PL/SQL: number (n, s) (���� ������� DEC, DECIMAL, DOUBLE, PRECISION, FLOAT, INT, INTEGER, NUMERIC, REAL � SMALLINT)
-- � Oracle Database 10^ ��������� ��� ��� �������� ���� � ��������� ������: BINARY_FLOAT � BINARY_DOUBLE. 

-- show parameters plsql;

-- ����������� ������������� ������� ���� ������, �������� ���������� ��������� PL/SQL: show parameters nls;

-- 1.	������������ ���������� ��������� ���� (�� ������� �����, ��� ���������, �� �� ������ �� ������� �����) PL/SQL (��), �� ���������� ����������. 
begin -- ������ �����
        -- ������ ������ ����������� ������
  null;
        -- ����� ������ ����������� ������
end; -- �����

-- 2. ������������ ��, ��������� �Hello World!�. ��������� ��� � SQLDev � SQL+.
set serveroutput on;

begin
  dbms_output.put_line('Hello world!');
end;

-- 3. ����������������� ������ ���������� � ���������� ������� sqlerrm, sqlcode.
declare
   n AUDITORIUM.AUDITORIUM_NAME%type; -- ����������� ���������� �� ������ ���� � �������
begin
   select AUDITORIUM_NAME into n from AUDITORIUM where AUDITORIUM_TYPE = '��';
   exception when others then dbms_output.put_line('code = ' || sqlcode || ', error = ' || sqlerrm); -- || - ������������
end;

-- 4. ������������ ��������� ����. ����������������� ������� ��������� ���������� �� ��������� ������.
declare
  x integer := 1;
  y integer := 0;
  z integer := 0;
begin
  dbms_output.put_line('x = ' || x || ', y = ' || y);
  begin
    z := x / y;
    dbms_output.put_line('z = ' || z);
    exception when others then dbms_output.put_line('code = ' || sqlcode || ', error = ' || sqlerrm);
  end;
  dbms_output.put_line('z = ' || z);
end;

-- 5. ��������, ����� ���� �������������� ����������� �������������� � ������ ������.
show parameter plsql_warnings;

-- 6. ������������ ������, ����������� ����������� ��� ����������� PL/SQL.
select keyword from v$reserved_words where length = 1 and keyword != 'A';

-- 7. ������������ ������, ����������� ����������� ��� �������� �����  PL/SQL.
select keyword from v$reserved_words where length > 1 order by keyword;

-- 8. ������������ ������, ����������� ����������� ��� ��������� Oracle Server, ��������� � PL/SQL. ����������� ��� �� ��������� � ������� SQL+-������� show.
select name, value from v$parameter where name like 'plsql%';
-- show parameters plsql;

-- 9. ������������ ��������� ����, ��������������� (��������� � �������� ��������� ����� ����������) ���������� � ������������� ����� number-����������;
declare
  x integer := 1;
begin
  dbms_output.put_line('x = ' || x);
end;

-- 11. �������������� �������� ��� ����� ������ number-����������, ������� ������� � ��������;
declare
  x    number := 8;
  y    number := 10;
  summ number := 0;
  div  number := 0;
  mul  number := 0;
  dif  number := 0;
  res  number := 0;
begin
  summ := x + y;
  div := y / x;
  mul := x * y;
  dif := y - x;
  res := mod(x, y);
  dbms_output.put_line('x = ' || x || ', y = ' || y || ', sum = ' || summ || ', div = ' || div || ', dif = ' || dif || ', res = ' || res);
end;

-- 12. ���������� � ������������� number-���������� � ������������� ������;
declare
  X number(5, 2) := 123.23; -- ��� A � ����� ���������� �������� ���� � �����,
                  -- � B � ���������� ���� ������ (������������� ��������) ��� ����� (������������� ��������) �� ���������� �������.
begin
  dbms_output.put_line(X);
end;

-- 13. ���������� � ������������� number-���������� � ������������� ������ � ������������� ��������� (����������);
declare
  X number(5, 2) := 123.2399999;
begin
  dbms_output.put_line(X);
end;

-- 14. ���������� � ������������� BINARY_FLOAT-����������;
declare
  X binary_float := 123.2399999;
begin
  dbms_output.put_line(X);
end;

-- 15. ���������� � ������������� BINARY_DOUBLE-����������;
declare
  X binary_double := 123.2399999;
begin
  dbms_output.put_line(X);
end;

-- 16. ���������� number-���������� � ������ � ����������� ������� E (������� 10) ��� �������������/����������;
declare
  X number(25, 0) := 123.2e10;
begin
  dbms_output.put_line(X);
end;

-- 17. ���������� � ������������� BOOLEAN-����������.
declare
  X boolean := true;
begin
  if not X
    then dbms_output.put_line('false');
  end if;
  if X
    then dbms_output.put_line('true');
  end if;
end;

-- 18. ������������ ��������� ���� PL/SQL ���������� ���������� �������� (VARCHAR2, CHAR, NUMBER). �����������������  ��������� �������� �����������.  
declare
  X constant varchar2(20) := 'varchar2';
  Y constant char not null default 'f';
  Z constant number not null := 12;
begin
  X := '2'; -- ������, ��� �������
  dbms_output.put_line(Z);
  exception when others then dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
end;

-- 19. ������������ ��, ���������� ���������� � ������ %TYPE. ����������������� �������� �����.
declare
   name AUDITORIUM.AUDITORIUM_NAME%TYPE;
begin
   select AUDITORIUM_NAME into name from AUDITORIUM where AUDITORIUM = '206-1';
   dbms_output.put_line(name);
end;

-- 20. ������������ ��, ���������� ���������� � ������ %ROWTYPE. ����������������� �������� �����.
declare
  p PULPIT%ROWTYPE; -- ����������� ��������� ������ �� ������ ������� ��� �������
begin
  p.PULPIT_NAME := '����';
  p.PULPIT := 'DW';
  dbms_output.put_line(p.PULPIT_NAME || ' ' || p.PULPIT);
end;

-- 21. ������������ ��, ��������������� ��� ��������� ����������� ��������� IF .
declare
  pulpit integer := 11;
begin
  if pulpit > 10
    then dbms_output.put_line('pulpit > 10');
    else dbms_output.put_line('else');
  end if;
end;

-- 23. ������������ ��, ��������������� ������ ��������� CASE.
declare
  x integer := 9;
begin
  case
    when x > 10 then dbms_output.put_line('x > 10');
    when x < 10 then dbms_output.put_line('x < 10');
    else dbms_output.put_line('else');
  end case;
end;

--22.	������������ ��, ��������������� ������ ��������� LOOP.
declare
  x integer := 0;
begin
  loop
    dbms_output.put_line(x);
    exit when x > 5;
    x := x + 1;
  end loop;
end;

--23.	������������ ��, ��������������� ������ ��������� WHILE.
declare
  x integer := 0;
begin
  while (x < 10)
  loop
    x := x + 1;
    dbms_output.put_line(x);
  end loop;
end;

--24.	������������ ��, ��������������� ������ ��������� FOR.
begin
  for k in 1..10
  loop
    dbms_output.put_line(k);
  end loop;
end;





