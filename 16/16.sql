---RANGE(�����������) 
--1. �������� ������� T_RANGE c ����������� ����������������. ����������� ���� ��������������� ���� NUMBER.
CREATE TABLE T_RANGE 
( 
PER NUMBER 
) 
PARTITION BY RANGE (PER) 
( 
PARTITION RANGE1 VALUES LESS THAN (10), 
PARTITION RANGE2 VALUES LESS THAN (20), 
PARTITION RANGE3 VALUES LESS THAN (MAXVALUE) 
); 

-- 5. ������� � ������� ���������� INSERT ������ � ������� T_RANGE, T_INTERVAL, T_HASH, T_LIST. ������ ������ ���� ������, 
--����� ��� ������������ �� ���� �������. ����������������� ��� � ������� SELECT �������.
INSERT INTO T_RANGE VALUES(5); 
INSERT INTO T_RANGE VALUES(15); 
INSERT INTO T_RANGE VALUES(42); 

select * from T_RANGE; 

SELECT * FROM T_RANGE PARTITION (RANGE1A);  
SELECT * FROM T_RANGE PARTITION (RANGE1B);  
SELECT * FROM T_RANGE PARTITION (RANGE1); 
SELECT * FROM T_RANGE PARTITION (RANGE3); 


--6. ����������������� ��� ���� ������ ������� ����������� ����� ����� ��������, ��� ��������� (�������� UPDATE) ����� ���������������.
ALTER TABLE T_RANGE ENABLE ROW MOVEMENT; 
UPDATE T_RANGE PARTITION(RANGE2) 
SET PER=PER-5; 

--9. ��� ����� �� ������ ����������������� �������� ��������� ALTER TABLE EXCHANGE.
ALTER TABLE T_RANGE EXCHANGE PARTITION RANGE3 
WITH TABLE ZZZ WITHOUT VALIDATION; 

CREATE TABLE ZZZ 
( 
Z NUMBER 
);
SELECT * FROM ZZZ; 

INSERT INTO T_RANGE VALUES(9); 

-----SPIT 

--8. ��� ����� �� ������ ����������������� �������� ��������� ALTER TABLE SPLIT.
ALTER TABLE T_RANGE SPLIT PARTITION RANGE1 
AT (8) INTO 
( 
PARTITION RANGE1A, 
PARTITION RANGE1B 
);

----------------� 

---INTERVAL 
--2. �������� ������� T_INTERVAL c ������������ ����������������. ����������� ���� ��������������� ���� DATE.
CREATE TABLE T_INTERVAL 
( 
PER2 DATE 
) 
PARTITION BY RANGE(PER2) 
INTERVAL (NUMTOYMINTERVAL (1,'YEAR')) 
( 
PARTITION INTERVAL1 VALUES LESS THAN ('01.01.2015') 
); 

SELECT * FROM T_INTERVAL;

-- 5. ������� � ������� ���������� INSERT ������ � ������� T_RANGE, T_INTERVAL, T_HASH, T_LIST. ������ ������ ���� ������, 
--����� ��� ������������ �� ���� �������. ����������������� ��� � ������� SELECT �������.
INSERT INTO T_INTERVAL VALUES('05.01.2015'); 
INSERT INTO T_INTERVAL VALUES('25.03.2018'); 

SELECT * FROM T_INTERVAL PARTITION FOR ('05.05.2018'); 
SELECT * FROM T_INTERVAL PARTITION FOR ('20.01.2015'); 


alter table T_INTERVAL 

------HASH
--3. �������� ������� T_HASH c ���-����������������. ����������� ���� ��������������� ���� VARCHAR2.
CREATE TABLE T_HASH 
( 
STR VARCHAR2(15) 
) 
PARTITION BY HASH(STR) 
PARTITIONS 16 

-- 5. ������� � ������� ���������� INSERT ������ � ������� T_RANGE, T_INTERVAL, T_HASH, T_LIST. ������ ������ ���� ������, 
--����� ��� ������������ �� ���� �������. ����������������� ��� � ������� SELECT �������.
INSERT INTO T_HASH VALUES('HELLO'); 
INSERT INTO T_HASH VALUES('WORLD'); 
INSERT INTO T_HASH VALUES('!!!'); 

SELECT * FROM T_HASH;


---LIST
--4. �������� ������� T_LIST �� ��������� ����������������. ����������� ���� ��������������� ���� CHAR.
CREATE TABLE T_LIST 
( 
STR CHAR(15) 
) 
PARTITION BY LIST (STR) 
( 
PARTITION X1 VALUES('A'), 
PARTITION X2 VALUES('AA'), 
PARTITION X3 VALUES(DEFAULT) 
) 

-- 5. ������� � ������� ���������� INSERT ������ � ������� T_RANGE, T_INTERVAL, T_HASH, T_LIST. ������ ������ ���� ������, 
--����� ��� ������������ �� ���� �������. ����������������� ��� � ������� SELECT �������.
INSERT INTO T_LIST VALUES('B'); 
INSERT INTO T_LIST VALUES('ASD'); 
INSERT INTO T_LIST VALUES('AA'); 
INSERT INTO T_LIST VALUES('A'); 



SELECT * FROM T_LIST; 
SELECT * FROM T_LIST PARTITION (X12); 
SELECT * FROM T_LIST PARTITION (X3); 

-- 7. ��� ����� �� ������ ����������������� �������� ��������� ALTER TABLE MERGE.
ALTER TABLE T_LIST MERGE PARTITIONS 
X1, X2 INTO PARTITION X12; 
-------------------
