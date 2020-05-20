select * from pulpit;
select * from faculty;
select * from teacher;
select * from subject;

--  1. Разработайте локальную процедуру GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE) Процедура должна выводить список преподавателей из таблицы TEACHER
--(в стандартный серверный вывод), работающих на кафедре заданной кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
declare procedure get_teachers(pcode teacher.pulpit%type)
is
cursor cs is select * from teacher where lower(pulpit) like lower('%' || pcode || '%') ;
buffer teacher%rowtype;
begin
open cs;
loop
fetch cs into buffer;
exit when cs%notfound;
dbms_output.put_line(buffer.teacher_name);
end loop;
close cs;
end;

begin
get_teachers('ИСиТ');
end;

--2. Разработайте локальную функцию GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) RETURN NUMBER Функция должна выводить количество преподавателей
--из таблицы TEACHER, работающих на кафедре заданной кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
declare res number;
function get_num_teachers(pcode char) return number
is
buff number;
begin
select count(*) into buff from teacher where lower(pulpit) like lower('%' || pcode || '%') ;
return buff;
end get_num_teachers;
begin
res := get_num_teachers('ИСиТ');
dbms_output.put_line('result = ' || res);
end;

-- 3. Разработайте процедуры:
--GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)Процедура должна выводить список преподавателей из таблицы TEACHER
--(в стандартный серверный вывод), работающих на факультете, заданным кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
--GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) Процедура должна выводить список дисциплин из таблицы SUBJECT, закрепленных за кафедрой, заданной
--кодом кафедры в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
declare procedure get_teachers(fcode pulpit.FACULTY%type)
is
cursor cs
is
select TEACHER.TEACHER_NAME, pulpit.FACULTY from teacher, pulpit
where teacher.pulpit = pulpit.pulpit and lower(pulpit.faculty) like lower('%' || fcode || '%');
tname teacher.TEACHER_NAME%type;
fname pulpit.faculty%type;
begin
open cs;
loop
  fetch cs into tname, fname;
  exit when cs%notfound;
  dbms_output.put_line(tname);
end loop;
close cs;
end;
begin
  get_teachers('ИДиП');
end;

-- 

declare procedure GET_SUBJECTS(pcode pulpit.pulpit%type)
is
cursor cs is select * from subject where lower(pulpit) like lower('%' || pcode || '%') ;
buffer SUBJECT%rowtype;
begin
  open cs;
  loop
    fetch cs into buffer;
    exit when cs%notfound;
    dbms_output.put_line(buffer.subject_name);
  end loop;
  close cs;
  end;
begin
  GET_SUBJECTS('ИСиТ');
end;

-- 4. Разработайте локальную функцию 
--GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER Функция должна выводить количество преподавателей из таблицы TEACHER,
--работающих на факультете, заданным кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
--GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER Функция должна выводить количество дисциплин из таблицы SUBJECT, закрепленных
--за кафедрой, заданной кодом кафедры параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
declare res number;
function get_num_teachers(fcode FACULTY.FACULTY%TYPE) return number
is
buff number;
begin
select count(*) into buff from teacher , pulpit
where teacher.pulpit = pulpit.pulpit and lower(pulpit.faculty) like lower('%' || fcode || '%');
return buff;
end get_num_teachers;
begin
res := get_num_teachers('ИДиП');
dbms_output.put_line('result = ' || res);
end;


declare res number;
function get_num_subjects(pcode pulpit.pulpit%TYPE) return number
is
buff number;
begin
select count(*) into buff from subject where lower(pulpit) like lower('%' || pcode || '%');
return buff;
end get_num_subjects;
begin
res := get_num_subjects('ИСиТ');
dbms_output.put_line('result = ' || res);
end;

-- 5. Разработайте пакет TEACHERS, содержащий процедуры и функции:
--GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
--GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
--GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER
CREATE OR REPLACE PACKAGE TEACHERS IS
  procedure get_teachers(pcode teacher.pulpit%type);
  procedure GET_SUBJECTS(pcode pulpit.pulpit%type);
  function get_num_teachers(fcode FACULTY.FACULTY%TYPE) return number;
  function get_num_subjects(pcode pulpit.pulpit%TYPE) return number;
END;

CREATE OR REPLACE PACKAGE BODY TEACHERS IS

    PROCEDURE get_teachers(pcode teacher.pulpit%type) IS
    cursor cs is select * from teacher where lower(pulpit) like lower('%' || pcode || '%') ;
    buffer teacher%rowtype;
    begin
    open cs;
    loop
    fetch cs into buffer;
    exit when cs%notfound;
    dbms_output.put_line(buffer.teacher_name);
    end loop;
    close cs;
    end;
    
    procedure GET_SUBJECTS(pcode pulpit.pulpit%type)
    IS
    cursor cs is select * from subject where lower(pulpit) like lower('%' || pcode || '%') ;
    buffer SUBJECT%rowtype;
    begin
    open cs;
    loop
      fetch cs into buffer;
    exit when cs%notfound;
    dbms_output.put_line(buffer.subject_name);
  end loop;
  close cs;
  end;
  
function get_num_teachers(fcode FACULTY.FACULTY%TYPE) return number
is
buff number;
begin
select count(*) into buff from teacher , pulpit
where teacher.pulpit = pulpit.pulpit and lower(pulpit.faculty) like lower('%' || fcode || '%');
return buff;
end get_num_teachers;

function get_num_subjects(pcode pulpit.pulpit%TYPE) return number
IS
buff number;
begin
select count(*) into buff from subject where lower(pulpit) like lower('%' || pcode || '%');
return buff;
end get_num_subjects;

END TEACHERS;

--6. Разработайте анонимный блок и продемонстрируйте выполнение процедур и функций пакета TEACHERS.
declare
res number;
res2 number;
begin
  dbms_output.put_line('*****TEACHERS*****');
  TEACHERS.get_teachers('ИСиТ');
  dbms_output.put_line('*****SUBJECTS*****');
  TEACHERS.get_subjects('ИСиТ'); 
  dbms_output.put_line('*****COUNT OF TEACERS*****');
  res := TEACHERS.get_num_teachers('ИДиП');
  dbms_output.put_line(res);
  dbms_output.put_line('*****COUNT OF SUBJECTS*****');
  res2 := TEACHERS.get_num_subjects('ИСиТ');
  dbms_output.put_line(res2);
end;


-- тип PL/SQL-записи (record) - стр-ра данных, составленная из нескольких частей информации
-- Что такое локальные процедуры и функции PL/SQL? определяются в разделе объявлений блока PL/SQL (анонимного или именованного)
-- процдура выполняет специфической действие
-- функция вычисляет какое-то значение
-- пакетные переменные сохраняют свое состояние от одной транзакции к другой и являются глобальными данными
-- пакет - коллекция объектов, сгруппированных вместе