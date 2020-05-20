
--Создайте табличное пространство для постоянных данных
create tablespace TS_ADS
    datafile 'TS_ADS.dat'
    size 7M
    autoextend on next 5M maxsize 20M;
    
--Создайте табличное пространство для временных данных
create temporary tablespace TS_ADS_TEMP
    tempfile 'TS_ADS_TEMP.dbf'
    size 5M
    autoextend on next 3M maxsize 30M;