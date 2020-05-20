--1
DECLARE
   name AUDITORIUM.AUDITORIUM_NAME%TYPE;
   v_code NUMBER;
   v_errm VARCHAR2(164);
BEGIN
   SELECT AUDITORIUM_NAME INTO name FROM AUDITORIUM WHERE AUDITORIUM = '314-4';
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--2
DECLARE
   name AUDITORIUM.AUDITORIUM_NAME%TYPE;
   v_code NUMBER;
   v_errm VARCHAR2(164);
BEGIN
   SELECT AUDITORIUM_NAME INTO name FROM AUDITORIUM WHERE AUDITORIUM_TYPE = 'À ';
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--3
DECLARE
   name AUDITORIUM.AUDITORIUM_NAME%TYPE;
BEGIN
   SELECT AUDITORIUM_NAME INTO name FROM AUDITORIUM WHERE AUDITORIUM_TYPE = 'À ';
EXCEPTION 
    WHEN TOO_MANY_ROWS
  THEN dbms_output.put_line('TOO_MANY_ROWS');
END;

--4
DECLARE
        b1 boolean;
   name AUDITORIUM.AUDITORIUM_NAME%TYPE;
BEGIN
   SELECT AUDITORIUM_NAME INTO name FROM AUDITORIUM WHERE AUDITORIUM_TYPE = 'À3 ';
   b1 := sql%notfound;
   
   IF b1=true 
      THEN dbms_output.put_line('NO_DATA_FOUND');
   END IF;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--5
declare 
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
    auditorium_curr auditorium%rowtype;
begin
    update auditorium
    set auditorium = '314-1' 
    where auditorium = '301-1';
--rollback;
b1:=sql%found;
b2:=sql%isopen;
b3:=sql%notfound;
n:=sql%rowcount;

dbms_output.put_line(auditorium_curr.auditorium);
if b1 then dbms_output.put_line('b1: true');
else dbms_output.put_line('b1: false');
end if;
if b2 then dbms_output.put_line('b2: true');
else dbms_output.put_line('b2: false');
end if;
if b3 then dbms_output.put_line('b3: true');
else dbms_output.put_line('b3: false');
end if;
dbms_output.put_line('n: ' || n);    
commit;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--6
declare 
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
    auditorium_curr auditorium%rowtype;
begin
    update auditorium
    set auditorium = '236-1' 
    where auditorium = '206-1';
   
select * into auditorium_curr from auditorium where auditorium = '206-1';  
b1:=sql%found;
b2:=sql%isopen;
b3:=sql%notfound;
n:=sql%rowcount;

dbms_output.put_line(auditorium_curr.auditorium);
if b1 then dbms_output.put_line('b1: true');
else dbms_output.put_line('b1: false');
end if;
if b2 then dbms_output.put_line('b2: true');
else dbms_output.put_line('b2: false');
end if;
if b3 then dbms_output.put_line('b3: true');
else dbms_output.put_line('b3: false');
end if;
dbms_output.put_line('n: ' || n);    
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--7
declare 
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
    auditorium_curr auditorium%rowtype;
begin
    insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('207-1',   '207-1', 'À¡- ', 15);
   
select * into auditorium_curr from auditorium where auditorium = '207-1';  
b1:=sql%found;
b2:=sql%isopen;
b3:=sql%notfound;
n:=sql%rowcount;

dbms_output.put_line(auditorium_curr.auditorium);
if b1 then dbms_output.put_line('b1: true');
else dbms_output.put_line('b1: false');
end if;
if b2 then dbms_output.put_line('b2: true');
else dbms_output.put_line('b2: false');
end if;
if b3 then dbms_output.put_line('b3: true');
else dbms_output.put_line('b3: false');
end if;
dbms_output.put_line('n: ' || n);  
rollback;
--commit;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--8
declare 
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
    auditorium_curr auditorium%rowtype;
begin
    insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('206-1',   '206-1', 'À¡- ', 15);
   
select * into auditorium_curr from auditorium where auditorium = '207-1';  
b1:=sql%found;
b2:=sql%isopen;
b3:=sql%notfound;
n:=sql%rowcount;

dbms_output.put_line(auditorium_curr.auditorium);
if b1 then dbms_output.put_line('b1: true');
else dbms_output.put_line('b1: false');
end if;
if b2 then dbms_output.put_line('b2: true');
else dbms_output.put_line('b2: false');
end if;
if b3 then dbms_output.put_line('b3: true');
else dbms_output.put_line('b3: false');
end if;
dbms_output.put_line('n: ' || n);  
rollback;
--commit;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--9
declare 
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
    auditorium_curr auditorium%rowtype;
begin
   delete auditorium where auditorium = '301-1';
   
select * into auditorium_curr from auditorium where auditorium = '301-1';  
b1:=sql%found;
b2:=sql%isopen;
b3:=sql%notfound;
n:=sql%rowcount;

dbms_output.put_line(auditorium_curr.auditorium);
if b1 then dbms_output.put_line('b1: true');
else dbms_output.put_line('b1: false');
end if;
if b2 then dbms_output.put_line('b2: true');
else dbms_output.put_line('b2: false');
end if;
if b3 then dbms_output.put_line('b3: true');
else dbms_output.put_line('b3: false');
end if;
dbms_output.put_line('n: ' || n);  
rollback;
--commit;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--10
declare 
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
    auditorium_curr auditorium%rowtype;
begin
    delete auditorium_type where auditorium_type = 'À ';
   
select * into auditorium_curr from auditorium where auditorium = '207-1';  
b1:=sql%found;
b2:=sql%isopen;
b3:=sql%notfound;
n:=sql%rowcount;

dbms_output.put_line(auditorium_curr.auditorium);
if b1 then dbms_output.put_line('b1: true');
else dbms_output.put_line('b1: false');
end if;
if b2 then dbms_output.put_line('b2: true');
else dbms_output.put_line('b2: false');
end if;
if b3 then dbms_output.put_line('b3: true');
else dbms_output.put_line('b3: false');
end if;
dbms_output.put_line('n: ' || n);  
rollback;
--commit;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--11
declare
    cursor curs_teachers is select TEACHER,  TEACHER_NAME, PULPIT from teacher;
    c_teacher teacher.teacher%type;
    c_teacher_name teacher.teacher_name%type;
    c_pulpit teacher.pulpit%type;
begin
    open curs_teachers;
    loop 
        fetch curs_teachers into c_teacher,c_teacher_name, c_pulpit;
    exit when curs_teachers%notfound;
        dbms_output.put_line(curs_teachers%rowcount||'. '
        || c_teacher||'    '
        || c_teacher_name||'    '
        || c_pulpit);
    end loop;
close curs_teachers;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--12
declare
    cursor curs_subject is select SUBJECT, SUBJECT_NAME, PULPIT from SUBJECT;
    rec_subject SUBJECT%rowtype;
begin
    open curs_subject;
    fetch curs_subject into rec_subject;
    WHILE curs_subject%found
    loop 
        dbms_output.put_line(curs_subject%rowcount||'. '
        || rec_subject.subject||'    '
        || rec_subject.subject_name||'    '
        || rec_subject.pulpit);
        fetch curs_subject into rec_subject;
    end loop;
    dbms_output.put_line(curs_subject%rowcount);
close curs_subject;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--13
declare
    cursor curs_pulpit is select PULPIT.PULPIT, TEACHER_NAME,  PULPIT_NAME,  FACULTY from pulpit 
    join teacher on  pulpit.pulpit = teacher.pulpit;
    rec_pulpit curs_pulpit%rowtype;
begin
    for rec_pulpit in curs_pulpit
    loop 
        dbms_output.put_line(curs_pulpit%rowcount||'. '
        || rec_pulpit.PULPIT||'    '
        || rec_pulpit.TEACHER_NAME||'    '
        || rec_pulpit.PULPIT_NAME||'    '
        || rec_pulpit.FACULTY);
    end loop;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--14
declare
    cursor curs_auditorium(capasity auditorium.auditorium_capacity%type) 
    is select AUDITORIUM,   auditorium_capacity from AUDITORIUM
    where AUDITORIUM.auditorium_capacity < capasity;
    aum AUDITORIUM%rowtype;
begin
    for aum in curs_auditorium(20)
    loop 
        dbms_output.put_line(curs_auditorium%rowcount||'. '
        || aum.auditorium||'    '
        || aum.auditorium_capacity);
    end loop;

EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

declare
    cursor curs_auditorium(capasity1 auditorium.auditorium_capacity%type,
                            capasity2 auditorium.auditorium_capacity%type) 
    is select AUDITORIUM,   auditorium_capacity from AUDITORIUM
    where AUDITORIUM.auditorium_capacity > capasity1 and AUDITORIUM.auditorium_capacity < capasity2;
    c_auditorium AUDITORIUM.auditorium%type;
    c_capacity auditorium.auditorium_capacity%type;
begin
    open curs_auditorium(21,30);
    fetch curs_auditorium into c_auditorium, c_capacity;
    while(curs_auditorium%found)
    loop 
        dbms_output.put_line(curs_auditorium%rowcount||'. '
        || c_auditorium||'    '
        || c_capacity);
        fetch curs_auditorium into c_auditorium, c_capacity;
    end loop;

EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;


declare
    cursor curs_auditorium(capasity1 auditorium.auditorium_capacity%type,
                            capasity2 auditorium.auditorium_capacity%type)
    is select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM
    where AUDITORIUM.auditorium_capacity > capasity1 and AUDITORIUM.auditorium_capacity < capasity2;
    c_auditorium auditorium.auditorium%type;
    c_auditorium_type auditorium.auditorium_type%type;
    c_auditorium_capacity auditorium.auditorium_capacity%type;
begin
    open curs_auditorium(31,60);
    loop 
     fetch curs_auditorium into c_auditorium,c_auditorium_type, c_auditorium_capacity;
    exit when curs_auditorium%notfound;
        dbms_output.put_line(curs_auditorium%rowcount||'. '
        || c_auditorium||'    '
        || c_auditorium_capacity);
        fetch curs_auditorium into c_auditorium,c_auditorium_type, c_auditorium_capacity;
    end loop;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;


declare
    cursor curs_auditorium(capasity1 auditorium.auditorium_capacity%type,
                            capasity2 auditorium.auditorium_capacity%type)
    is select AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM
    where AUDITORIUM.auditorium_capacity > capasity1 and AUDITORIUM.auditorium_capacity < capasity2;
    aum auditorium%rowtype;
begin
    for aum in curs_auditorium(61,100)
    loop 
        dbms_output.put_line(curs_auditorium%rowcount||'. '
        || aum.auditorium||'    '
        || aum.auditorium_capacity);
    end loop;
EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

declare
    cursor curs_auditorium(capasity1 auditorium.auditorium_capacity%type) 
    is select AUDITORIUM,   auditorium_capacity from AUDITORIUM
    where AUDITORIUM.auditorium_capacity > capasity1;
    c_auditorium AUDITORIUM.auditorium%type;
    c_capacity auditorium.auditorium_capacity%type;
begin
    open curs_auditorium(90);
    fetch curs_auditorium into c_auditorium, c_capacity;
    while(curs_auditorium%found)
    loop 
        dbms_output.put_line(curs_auditorium%rowcount||'. '
        || c_auditorium||'    '
        || c_capacity);
        fetch curs_auditorium into c_auditorium, c_capacity;
    end loop;

EXCEPTION   WHEN OTHERS THEN
  dbms_output.put_line('Code: ' || SQLCODE || ' Error: ' || SQLERRM);
END;

--15
variable x refcursor;
declare 
  type curs_subject is ref cursor return subject%rowtype;
  xcurs curs_subject;
  rec_subject subject%rowtype;
begin
  open xcurs for select * from subject;
  :x := xcurs;
  fetch xcurs into rec_subject;
  loop
    dbms_output.put_line(rec_subject.subject);
    fetch xcurs into rec_subject;
  exit when xcurs%notfound;
end loop;  
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;

--16
declare
  cursor curs_aut is select auditorium_type,
                          cursor(
                          select auditorium from auditorium aum
                          where aut.auditorium_type = aum.auditorium_type)
               from auditorium aut;

  curs_aum sys_refcursor;
  aut auditorium.auditorium_type%type;
  txt varchar2(200);
  aum auditorium.auditorium%type;
begin
  open curs_aut;
  fetch curs_aut into aut, curs_aum;
  while (curs_aut%found)
  loop
    txt:=RTRIM(aut) || ':';
    loop
    fetch curs_aum into aum;
    EXIT when curs_aum%notfound;
    txt:= txt||', '|| rtrim(aum);
    end loop;
  dbms_output.put_line(txt);
  fetch curs_aut into aut, curs_aum;
end loop;
  close curs_aut;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;

--17
declare
cursor cs is select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY > 40 and AUDITORIUM.AUDITORIUM_CAPACITY < 80 for update;
bufline AUDITORIUM%rowtype;
nrow int;
begin
 select count(*) into nrow from auditorium where auditorium_capacity > 40 and auditorium_capacity < 80;
 dbms_output.put_line('nrow: '|| nrow);
open cs;
loop
fetch cs into bufline;
exit when cs%notfound;
update AUDITORIUM set AUDITORIUM.AUDITORIUM_CAPACITY = AUDITORIUM.AUDITORIUM_CAPACITY - 10 where current of cs;
dbms_output.put_line('update: '|| sql%rowcount);
end loop;

close cs;
rollback;
end;

--18.
declare
cursor cs is select * from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY < 20 for update;
bufline AUDITORIUM%rowtype;
nrow int;
begin
 select count(*) into nrow from auditorium where auditorium_capacity < 20;
 dbms_output.put_line('nrow: '|| nrow);
open cs;
loop
fetch cs into bufline;
exit when cs%notfound;
delete AUDITORIUM where current of cs;
dbms_output.put_line('update: '|| sql%rowcount);
end loop;
close cs;
rollback;
end;

--19
declare
cursor cs is select auditorium_capacity, rowid from AUDITORIUM  where auditorium_capacity > 0 and auditorium_capacity < 50 for update;
bufline number(3);
buff rowid;
begin
open cs;
loop
fetch cs into bufline, buff;
exit when cs%notfound;
dbms_output.put_line(bufline || '||' || buff);
delete AUDITORIUM where current of cs;
end loop;
close cs;
rollback;
end;

--20
declare
cursor customCursor2 is select * from teacher;
buffer boolean;
counter number(10):= 0;
n teacher%rowtype;
begin
open customCursor2;
if customCursor2%notfound = true
then
buffer := true;
else
buffer := false;
end if;
while  buffer = false
loop
counter := counter + 1;
fetch customCursor2 into n;
if customCursor2%notfound = true
then
buffer := true;
else
buffer := false;
end if;
dbms_output.put_line('teacher = ' || n.teacher_name);
if mod(counter, 3) = 0
then
dbms_output.put_line('-------------');
end if;
end loop;
close customCursor2;
end;
