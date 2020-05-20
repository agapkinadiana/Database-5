-- 1. Получите список всех существующих PDB в рамках экземпляра ORA12W. Определите их текущее состояние.
select * from v$pdbs;

-- 2. Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select * from v$instance;

-- 3. Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии и статус.
select comp_name, version, status from dba_registry;

-- 4. Создайте собственный экземпляр PDB (необходимо подключиться к серверу с серверного компьютера и используйте
--Database Configuration Assistant) с именем XXX_PDB, где XXX – инициалы студента.

-- 5. Получите список всех существующих PDB в рамках экземпляра ORA12W. Убедитесь, что созданная PDB-база данных существует.
select * from v$pdbs;

-- 6. Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты (табличные пространства, роль,
--профиль безопасности, пользователя с именем U1_XXX_PDB).
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
    password_life_time 180 --кол-во дней жизни пароля
    sessions_per_user 3 --кол-во сессий для пользователя
    failed_login_attempts 7 --количество попыток входа
    password_lock_time 1 --кол-во дней блокировки после ошибки
    password_reuse_time 10 --через сколько дней можно повторить пароль
    password_grace_time default --кол-во дней предупреждений о смене пароля
    connect_time 180 --время соединения, минут
    idle_time 30 --кол-во минут простоя
    ;
    
create user U1_ADS_PDB identified by s1234567
    default tablespace TS_ADS_PDB
    temporary tablespace TEMP_ADS_PDB 
    profile PF_ADS_PDB;
    
drop user U1_ADS_PDB;

-- 7. Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, 
--добавьте в нее строки, выполните SELECT-запрос к таблице.
create table ADS_TABLE(
  id int,
  name varchar(15)
);

--ALTER USER U1_ADS_PDB QUOTA UNLIMITED ON USERS;
insert into ADS_TABLE values (1,'Diana');
insert into ADS_TABLE values(2,'Nastya');

select * from ADS_TABLE;

drop table ADS_TABLE;

-- 8. С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные),
--все роли (и выданные им привилегии), профили безопасности, всех пользователей  базы данных XXX_PDB и  назначенные им роли.
select * from ALL_USERS;
select * from DBA_TABLESPACES;
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select * from DBA_ROLES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;
select * from DBA_PROFILES;

drop user U1_ADS_PDB;