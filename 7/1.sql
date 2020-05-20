-- 1. �������� ������ ������ ������� ���������.
select name, description from v$bgprocess order by name;

-- 2. ���������� ������� ��������, ������� �������� � �������� � ��������� ������.
select name, description from v$bgprocess where paddr!=hextoraw('00') order by name;

-- 3. ����������, ������� ��������� DBWn �������� � ��������� ������.
select name, description from v$bgprocess where name='DBWn' and paddr!=hextoraw('00') order by name;

-- 4. �������� �������� ������� ���������� � �����������.
select * from v$session where username is not null;

-- 5. ���������� ������ ���� ����������.
select username, status, server from v$session where username is not null;

-- 6. ���������� ������� (����� ����������� ����������).
select * from v$services;

-- 7. �������� ��������� ��� ��������� ���������� � �� ��������.
show parameter dispatcher;

-- 8. ������� � ������ Windows-�������� ������, ����������� ������� LISTENER.

-- 9. �������� �������� ������� ���������� � ���������. (dedicated, shared).
select * from v$session where username is not null;

-- 10. ����������������� � �������� ���������� ����� LISTENER.ORA.
-- C:\app\oracle\product\12.1.0\dbhome_1\NETWORK\ADMIN\SAMPLE

-- 11. ��������� ������� lsnrctl � �������� �� �������� �������.
-- lsnrctl - help

-- 12. �������� ������ ����� ��������, ������������� ��������� LISTENER.
-- lsnrctl - services
