-- 1. Получите список всех файлов табличных пространств (перманентных  и временных).
select tablespace_name, file_name from DBA_DATA_FILES;
select tablespace_name, file_name from DBA_TEMP_FILES;

-- 2. Создайте табличное пространство с именем XXX_QDATA (10m). При создании установите
--его в состояние offline. Затем переведите табличное пространство в состояние online. Выделите 
--пользователю XXX квоту 2m в пространстве XXX_QDATA. От имени XXX в  пространстве XXX_T1создайте таблицу 
--из двух столбцов, один из которых будет являться первичным ключом. В таблицу добавьте 3 строки.
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

-- 3. Получите список сегментов табличного пространства  XXX_QDATA. Определите сегмент таблицы XXX_T1. Определите остальные сегменты.
select * from dba_segments where tablespace_name = 'ADS_QDATA';
select * from dba_segments where tablespace_name = 'ADS_T1';
select * from dba_segments;

-- 4. Удалите (DROP) таблицу XXX_T1. Получите список сегментов табличного пространства  XXX_QDATA. Определите сегмент таблицы XXX_T1.
--Выполните SELECT-запрос к представлению USER_RECYCLEBIN, поясните результат.
drop table ADS_T1;

select * from user_recyclebin;

-- 5. Восстановите (FLASHBACK) удаленную таблицу. ???
flashback table ADS_T1 to before drop;

-- 6. Выполните PL/SQL-скрипт, заполняющий таблицу XXX_T1 данными (10000 строк).
declare N int := 4;
begin 
    for i in 1..10000 loop
    insert into ADS_T1 values (N, concat('stroka',N));
    N := N+1;
    end loop;
end;

select count(*) from ADS_T1;

-- 7. Определите сколько в сегменте таблицы XXX_T1 экстентов, их размер в блоках и байтах. Получите перечень всех экстентов.
select segment_name, extents, blocks, bytes from dba_segments where tablespace_name = 'ADS_QDATA';
select * from dba_extents;

-- 8. Удалите табличное пространство XXX_QDATA и его файл.
drop tablespace ADS_QDATA including contents and datafiles;

-- 9. Получите перечень всех групп журналов повтора. Определите текущую группу журналов повтора.\
select * from V$LOG;
select GROUP# from V$LOG where STATUS = 'CURRENT';

-- 10. Получите перечень файлов всех журналов повтора инстанса.
select * from V$LOGFILE;

-- 11. EX. С помощью переключения журналов повтора пройдите полный цикл переключений. Запишите серверное
--время в момент вашего первого переключения (оно понадобится для выполнения следующих заданий). (19:11)
alter system switch logfile;
select group#,sequence#,bytes,members,status,first_change# from v$log;

-- 12. EX. Создайте дополнительную группу журналов повтора с тремя файлами журнала. Убедитесь в наличии группы и файлов,
--а также в работоспособности группы (переключением). Проследите последовательность SCN.
alter database add logfile group 4 'C:\app\oracle\oradata\orcl\REDO04.LOG' size 50m blocksize 512;
select group#,sequence#,bytes,members,status,first_change# from v$log;

alter database add logfile member 'C:\app\oracle\oradata\orcl\REDO041.LOG' TO GROUP 4;
alter database add logfile member 'C:\app\oracle\oradata\orcl\REDO042.LOG' TO GROUP 4;
alter database add logfile member 'C:\app\oracle\oradata\orcl\REDO043.LOG' TO GROUP 4;

alter system switch logfile;
select group#,sequence#,bytes,members,status,first_change# from v$log;

-- 13. EX. Удалите созданную группу журналов повтора. Удалите созданные вами файлы журналов на сервере.
alter database drop logfile member 'C:\app\oracle\oradata\orcl\REDO041.LOG';
alter database drop logfile member 'C:\app\oracle\oradata\orcl\REDO042.LOG';
alter database drop logfile member 'C:\app\oracle\oradata\orcl\REDO043.LOG';
select group#,sequence#,bytes,members,status,first_change# from v$log;

alter database drop logfile group 4;

-- 14. Определите, выполняется или нет архивирование журналов повтора (архивирование должно быть отключено,
--иначе дождитесь, пока другой студент выполнит задание и отключит).
select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;

-- 15. Определите номер последнего архива.  
select * from v$log;

-- 16. EX. Включите архивирование.
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;

-- 17. EX. Принудительно создайте архивный файл. Определите его номер.
--Определите его местоположение и убедитесь в его наличии. Проследите последовательность SCN в архивах и журналах повтора.
alter system switch logfile;
select * from v$archived_log;
select instance_name, archiver, active_state from v$instance;
select * from v$log;

-- 18. EX. Отключите архивирование. Убедитесь, что архивирование отключено.  
startup mount;
alter database noarchivelog;

-- 19. Получите список управляющих файлов.
show parameter control;
select name from v$controlfile;

-- 20. Получите и исследуйте содержимое управляющего файла. Поясните известные вам параметры в файле.
select type, record_size, records_total from v$controlfile_record_section;

-- 21. Определите местоположение файла параметров инстанса. Убедитесь в наличии этого файла.
select * from v$parameter;

/*C:\app\oracle\admin\orcl\pfile\init.ora file instance*/

-- 22. Сформируйте PFILE с именем XXX_PFILE.ORA. Исследуйте его содержимое. Поясните известные вам параметры в файле.
select name, value from v$parameter where name = 'open_cursors';
alter system set open_cursors=350 scope=spfile;
create pfile = 'ads_pfile.ora.' from spfile = 'SPFILEORCL.ORA';
/*PRIVILEGES. CREATE FROM SERVER C:\app\oracle\product\12.1.0\dbhome_1\database\ads_pfile.ora*/

-- 23. Определите местоположение файла паролей инстанса. Убедитесь в наличии этого файла.
select * from v$pwfile_users;

show parameter remote_login_passwordfile;
/*C:\app\oracle\product\12.1.0\dbhome_1\database\PWDorcl.ora*/

-- 24. Получите перечень директориев для файлов сообщений и диагностики
select * from v$diag_info;

-- 25. EX. Найдите и исследуйте содержимое протокола работы инстанса (LOG.XML), найдите в нем команды переключения журналов которые вы выполняли.
/*C:\app\oracle\diag\rdbms\orcl\orcl\alert\log.xml*/