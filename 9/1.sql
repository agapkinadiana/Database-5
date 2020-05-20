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



-- 2. Создайте последовательность (- объект бд для генерации числовой последовательности) S1 (SEQUENCE), со следующими характеристиками: начальное значение 1000; приращение 10;
--нет минимального значения; нет максимального значения; не циклическая; значения не кэшируются в памяти; хронология значений не гарантируется.
--Получите несколько значений последовательности. Получите текущее значение последовательности.
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

-- 3. Создайте последовательность S2 (SEQUENCE), со следующими характеристиками: начальное значение 10; приращение 10; максимальное значение 100;
drop sequence S2;

create sequence S2
start with 10
increment by 10
nominvalue
maxvalue 100
nocycle
nocache
noorder;

-- 4. не циклическую. Получите все значения последовательности. Попытайтесь получить значение, выходящее за максимальное значение. НЕЛЬЗЯ
set SERVEROUTPUT on;
begin
    for i in 10..100
    loop
    DBMS_OUTPUT.PUT_LINE(S2.nextval);
    end loop;
end;

-- 5. Создайте последовательность S3 (SEQUENCE), со следующими характеристиками: начальное значение 10; приращение -10; минимальное значение -100; не циклическую;
--гарантирующую хронологию значений. Получите все значения последовательности. Попытайтесь получить значение, меньше минимального значения.
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

-- 6. Создайте последовательность S4 (SEQUENCE), со следующими характеристиками: начальное значение 1; приращение 1; минимальное значение 10; циклическая;
-- кэшируется в памяти 5 значений; хронология значений не гарантируется. Продемонстрируйте цикличность генерации значений последовательностью S4.
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

-- 7. Получите список всех последовательностей в словаре базы данных, владельцем которых является пользователь XXX.
select * from user_objects where object_type='SEQUENCE';

-- 8. Создайте таблицу T1, имеющую столбцы N1, N2, N3, N4, типа NUMBER (20), кэшируемую и расположенную в буферном пуле KEEP.
-- С помощью оператора INSERT добавьте 7 строк, вводимое значение для столбцов должно формироваться с помощью последовательностей S1, S2, S3, S4.
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

-- 9. Создайте кластер (объект бд, который хранит значения общих столбцов неск таблиц -> выше производительность) ABC, имеющий hash-тип (размер 200) 
--и содержащий 2 поля: X (NUMBER (10)), V (VARCHAR2(12)).
-- hash - хеширование для определения где хранить строку
create cluster ABC( X number(10),Y varchar2(12))
size 200
hashkeys 2;

-- 10. Создайте таблицу A, имеющую столбцы XA (NUMBER (10)) и VA (VARCHAR2(12)), принадлежащие кластеру ABC, а также еще один произвольный столбец.
create table A( XA NUMBER(10),YA VARCHAR2(12), ZA INT)
cluster ABC(XA, YA);

-- 11. Создайте таблицу B, имеющую столбцы XB (NUMBER (10)) и VB (VARCHAR2(12)), принадлежащие кластеру ABC, а также еще один произвольный столбец.
create table B( XB NUMBER(10),YB VARCHAR2(12), ZB INT)
cluster ABC(XB, YB);

-- 12. Создайте таблицу С, имеющую столбцы XС (NUMBER (10)) и VС (VARCHAR2(12)), принадлежащие кластеру ABC, а также еще один произвольный столбец.
create table C( XC NUMBER(10),YC VARCHAR2(12), ZC INT)
cluster ABC(XC, YC);

-- 13. Найдите созданные таблицы и кластер в представлениях словаря Oracle.
select * from USER_OBJECTS;

-- Синоним – это альтернативное имя объекта. Если создан синоним для объекта, то все SQL команды к объекту могут выполняться используя настоящее имя или синоним.
-- Этот метод может быть особенно полезным с длинными именами объектов, таких как представления.
-- Как правило, вы используете синонимы, когда предоставляете доступ к объекту из другой схемы, и вы не хотите, чтобы пользователи беспокоились о том, к какой схеме относится объект.
-- все пользователи (все!) могут использовать запрос видаselect * from (имя синонима);
-- Общие синонимы могут использоваться любым пользователем кому назначены соответсвующие права без использования имени схемы.
-- Они могут быть или в текущей схеме, или использоваться вместе с именем схемы.

-- 14. Создайте частный синоним для таблицы XXX.С и продемонстрируйте его применение.
drop SYNONYM SYN_FOR_C;

CREATE  SYNONYM SYN_FOR_C  FOR C;
SELECT * FROM SYN_FOR_C;

-- 15. Создайте публичный синоним для таблицы XXX.B и продемонстрируйте его применение.
drop public synonym SYN_FOR_B;

CREATE  PUBLIC SYNONYM SYN_FOR_B  FOR B;
insert into SYN_FOR_B  VALUES(500,'DF',6);
SELECT * FROM SYN_FOR_B;

-- create user u1 identified by q12345678;
-- drop user u1;

-- 16. Создайте две произвольные таблицы A и B (с первичным и внешним ключами), заполните их данными,
--создайте представление V1, основанное на SELECT... FOR A inner join B. Продемонстрируйте его работоспособность.
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

-- 17. На основе таблиц A и B создайте материализованное представление MV, которое имеет периодичность обновления 2 минуты. Продемонстрируйте его работоспособность.
-- Материализованный вид - таблица на диске, содержащая результирующий набор запроса и периодически обновляются на основе определения запроса.
-- Представление - запрос, который извлекает данные из базовой таблицы
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

-- Всякий раз, когда нужен доступ к представлению, Oracle должен выполнить запрос,по которому определено представление, и вернуть результат. 
-- Этот процесс наполнения представления называется разрешением представления (view resolution) и он повторяется при каждом обращении пользователя к представлению.
-- Если вы имеете дело с представлениями с множеством конструкций JOIN и GROUP BY, то этот процесс разрешения представления может потребовать очень длительного времени. 
-- Если нужно часто обращаться к представлению, будет весьма неэффективно каждый раз повторять разрешение представления.

-- Материализованные представления Oracle предлагают выход из этого затруднения.Упомянутые представления можно воспринимать как специализированные представления, 
-- в отличие от обычных представлений, имеющие физическое воплощение. Они занимают место и требуют хранения подобно обычным таблицам. Материализованные представления
-- можно даже секционировать и при необходимости создавать на них индексы.