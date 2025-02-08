��(VIEW) : �������� �ϳ� �̻��� ���̺� �ִ� �������� �κ� ����

�� ��� ����
1)������ �׼����� �����ϱ� ����
2)������ ���Ǹ� ���� �ۼ��ϱ� ����
3)������ �������� �����ϱ� ����
4)������ �����ͷκ��� �پ��� ����� ��� ����
--sal,comm���� ������ ���� �� ���(���ȿ� ����)

CREATE OR REPLACE VIEW emp10_view
AS SELECT empno id_number,ename name,sal*12 ann_salary
   FROM emp WHERE deptno=10;

SELECT * FROM emp10_view;

CREATE OR REPLACE VIEW emp_info_view 
AS SELECT e.empno,e.ename,d.deptno,d.loc,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno;

SELECT * FROM emp_info_view; --������ ����� ��(������ �ڵ� �ݺ��� ��) �並 ����ؼ� ���ϰ� ������

view�� ���� ������ �����ϱ� --����X
�Ϲ������� view�� ��ȸ������ ���� �������� �Ʒ��� ���� �����͸� ������ �� ����
UPDATE emp10_view SET name='SCOTT' WHERE id_number=7839;
SELECT * FROM emp10_view; --view�� �����ص� emp�� �����Ǿ� ���� �����
SELECT * FROM emp; --emp���̺��� KING->SCOTT �����

INSERT INTO emp10_view (id_number,name,ann_salary) VALUES (8000,'JOHN',19000);
--���� ���� ����� �� ����(�����߻�), �߰� �Ұ�

INSERT INTO emp10_view (id_number,name) VALUES (8000,'JOHN'); --�߰� ����
--���� ���� �����ϸ� ���� ����
SELECT * FROM emp10_view; --��ϵ� �������� deptno�� null�̱� ������ ǥ�� �Ұ� , 10�����̺� �о���� ���̱� ������ JOHN�� �ȳ���(����)
SELECT * FROM emp; --���̺����� ��ϵ� ������ Ȯ�� ����

ROLLBACK;

WITH CHECK OPTION : ���� �÷����� �������� ���ϰ� �ϴ� �ɼ�

REATE OR REPLACE VIEW emp30_view AS
SELECT empno,ename,deptno FROM emp WHERE deptno=30
WITH CHECK OPTION;

SELECT * FROM emp30_view;

UPDATE emp30_view SET deptno=10 WHERE empno=7499;
--���� WITH CHECK OPTION�� ���ǿ� �����. (WHERE deptno=30�� �����Ǿ� �־� deptno ���� �Ұ���)

UPDATE emp30_view SET ename='MARIA' WHERE empno=7499; --deptno�� ������ �������� ���� ����

SELECT * FROM emp30_view;

ROLLBACK;

WITH READ ONLY : �б� ���� �並 �����ϴ� �ɼ�

CREATE OR REPLACE VIEW emp20_view AS
SELECT empno id_number,ename name,sal*12 ann_salary FROM emp WHERE deptno=20
WITH READ ONLY;

SELECT * FROM emp20_view;

UPDATE emp20_view SET name='DAVID' WHERE id_number=7902; --READ ONLY�̱� ������ ���� �Ұ�


�� ����
DROP VIEW emp10_view;



������(SEQUENCE) : ������ ���� �������ִ� ����Ŭ ��ü

CREATE SEQUENCE test_seq
start with 1
increment by 1
maxvalue 100000;

���� ���� 1�̰� 1�� �����ϰ�, �ִ밪�� 100000

currval : ���� ���� ��ȯ
nextval : ���� ������ ���� ���� �� ��ȯ

--�� Ȯ��
SELECT test_seq.nextval FROM dual; --������ �� ���� �� ��ȸ
SELECT test_seq.currval FROM dual; --������ �� ��ȸ, nextval���� currval�� ���� 



�ε���(INDEX) : �ε����� ������ �˻��� ���� �ϱ� ���� ����Ѵ�.
               ���̺��� �÷��� ���� ���� ������ ������ �� Primary Key, Unique �� �����ϸ� Oracle�� �ڵ����� �� �÷��� ���� Unique Index ����
               
�ε��� �����
�ڵ� : ���̺� ���ǿ� Primary Key �Ǵ� Unique ���� ������ �����ϸ� ���� �ε����� �ڵ����� ����
���� : ����ڰ� ���� �������� ���� �ε����� �����Ͽ� �࿡ ���� �׼��� �ð��� ���� �� ����

UNIQUE INDEX : ������ ���� ������ �÷��� �ε��� ����
CREATE UNIQUE INDEX dname_idx ON dept(dname);

NON UNIQUE INDEX : ������ ���� ������ �ʴ� �÷��� �ε��� ����
CREATE INDEX deptno_idx ON emp(deptno);

�ε��� ������ �ʿ��� ���
1)���� �������� ���� ���Ե� ���
2)���� �� ���� ���� ���Ե� ���
3)WHERE �� �Ǵ� ���� ���ǿ��� �ϳ� �̻��� ���� �Բ� ���� ���Ǵ� ���

�ε����� �������� �ʾƾ� �� ���
1)���̺��� ���� ���
2)���� ������ �������� ���� ������ �ʴ� ���
3)���̺��� ���� ���ŵǴ� ���



���Ǿ� : ��ü�� �ٸ� �̸�. ��ü �׼����� �ܼ�ȭ
1)�ٸ� ����ڰ� ������ ���̺��� ���� ����
2)�� ��ü �̸� ª�� ����

CREATE SYNONYM emp20
FOR emp20_view;

SELECT * FROM emp20; --EMP20_VIEW �ܼ� ȣ��

DROP SYNONYM emp20;


����

������ ������ ����� ����

������ ������ ���� : �����ͺ��̽��� ������ ������ ����ϴ� �������� �����̸� �����ͺ��̽� ��ü�� ����,����,���� ���� �۾��� ����
����� ������ ���� : ����� ������ �����ͺ��̽��� �����Ͽ� �����͸� ����(����,����,����,�˻�)�ϰ� �����ϴ� ���� ����


����� ����
[����Ŭ 11����]
RUN SQL Command Line ����

SQL>conn sys/1234(��й�ȣ) as sysdba;
SQL>create user user02 identified by 1234(��й�ȣ); <-- ���� ����
SQL>GRANT resource,connect To user02; <-- ���� ���� �ο�

��й�ȣ(��ȣ) ����
SQL> conn sys/1234 as sysdba
SQL> ALTER USER user02 identified by 5678;


����� ����

[����]������ ���ӵ� ���¿����� ������ �Ұ�����
SQL> DROP USER user02; --���̺� ������ �־ ���� �Ұ�

USER02 ������ ��ü�� �����ϰ� ���� ��쿡�� CASCADE �ɼ��� �߰��ؼ� ����
SQL> drop user user02 CASCADE;







--PL/SQL : ���ǹ�,�ݺ���,������ ��� ���� �� ��� + SQL ��� ����
--[����]�����Ϸ��� ���� ���� �� �����ؾ���

PL/SQL�� Procedural language extension to Structured Query Language(SQL)�� ����, SQL�� Ȯ���� ������ ó�� ���

PL/SQL�� �⺻ ������ ���(block)
1)�����(declarative part) : ����� ������ ����� ����(����ο��� ������ ��� ���� ����)
2)�����(executable part) : ���� ó���� ������ ����ϴ� �κ�
3)����ó����(eception-building part) : ����ο��� ������ ó���ϴ� �� �߻��� �� �ִ� ���� �����鿡 ���� ó��

�⺻ ����

begin
    dbms_output.put_line('Hello World');
end;

�޽��� ���
*SQL Developer���� ��� �޽��� ���
�޴�>����>DBMS���>DBMS���â���� + �������� Ŭ���ϰ� ����

���� ���

declare
 --������ ������ �� �ִ� �����
 message varchar2(100);                     --���� �ڿ� �ڷ��� �Է�
begin
 --����ο��� ������ ������ ���� ����
 message := 'Hello World';                  --:=�� �Է�(����) =�� �񱳿�����
 dbms_output.put_line(message);
end;

declare
 message varchar2(100) := 'HELLO ORACLE';   --����ο��� �ٷ� �Է� ����
begin
 dbms_output.put_line(message);
end;

declare
 counter integer;                           --�ʱ�ȭ���ϸ� null�� �ν�
begin
 counter := counter + 1;
 if counter is null then                    --null�̸� �� �� ����
    dbms_output.put_line('Result : counter is null');
 end if;
end;

������ 2�� ���
declare
 counter integer;
 i integer;
begin
 for i in 1..9 loop
    counter := 2 * i;
    dbms_output.put_line('2 * ' || i || ' = ' || counter);
 end loop;
end;

����ó����

declare
 counter integer;
begin
 counter := 10;
 counter := counter/0; --���� �߻�
 dbms_output.put_line(counter);
 exception when others then
  dbms_output.put_line('errors');
end;


--�迭(�ݷ���,��ø���̺�,�����迭). �߾����� ����, �ڷ����� �ٸ��� ����� �� ���� ����, ���ڵ带 ���� �����- �ڷ����� �޶� ��� ����
�ݷ���

varray : variable array�� ���ڷ� ���� ����(fixed number)�� ���� �迭

declare
 type varray_test is varray(3) of integer;
 varray1 varray_test; --������ ������ varray_test Ÿ�� ����
begin
 varray1 := varray_test(10,20,30);
 
 dbms_output.put_line(varray1(1));
 dbms_output.put_line(varray1(2));
 dbms_output.put_line(varray1(3));
end;


��ø ���̺� : varray�� ��������� ��ø ���̺��� ���� �ÿ� ��ü ũ�⸦ ����� �ʿ䰡 ����

declare
 type nested_test is table of varchar2(10);
 nested1 nested_test; --������ ������ nested_test Ÿ�� ���� ����
begin
 nested1 := nested_test('A','B','C','D');
 
 --�Ұ�
 --NESTED1(5) := 'E'; --�ѹ� ���� ������ ũ��� �� �þ�� ����, �迭�� �Ȱ���

 dbms_output.put_line(nested1(2)); --B ���
end;


Associative array(index-by table) : �����迭�� index-by table�̶�� �ϸ� Ű�� ���� ������ ����.

declare
 type assoc_type is table of number index by pls_integer;
 assoc1 assoc_type;--������ ������ assoc_type Ÿ�� ����
begin
 assoc1(3) := 33; --key�� 3, value�� 33
 dbms_output.put_line(assoc1(3));
end;


���ڵ�
�ݷ��ǿ� �ش��ϴ� varray,��ø ���̺�,associative array�� ��� ���α׷��� ���� ����ϴ� �迭 ������ ����.
�����ϴ� ��ҵ��� ������ Ÿ���� ��� ����.
���� �ٸ� ������ ������ Ÿ������ �����ϰ� ������ ���ڵ� ���

declare
 --TYPE���� ���ڵ� ����
 type record1 is record (deptno number not null:=50, --deptno�� primary key�̹Ƿ� �ѹ� �� �����ϸ� �ߺ��Ǿ� ���� �߻�
                         dname varchar2(14),
                         loc varchar2(13));
 --������ ������ record1�� �޴� ���� ����
 rec1 record1;
begin
 rec1.dname := 'RECORD';
 rec1.loc := 'SEOUL';
 
 --rec1 ���ڵ� ���� dept ���̺� insert
 INSERT INTO dept VALUES rec1; 
 COMMIT;
 exception when others then 
  ROLLBACK;
  dbms_output.put_line('errors');
end;
--���� �߻� �� ROLLBACK(����) �ƴϸ� COMMIT

declare
 grade char(1);
begin
 grade := 'B';
 
 if grade = 'A' then
  dbms_output.put_line('EXCELLENT');
 elsif grade = 'B' then                 --[����]else if�ƴ� elsif
  dbms_output.put_line('Good');
 elsif grade = 'C' then
  dbms_output.put_line('Fair');
 elsif grade = 'D' then
  dbms_output.put_line('Poor');
 end if;                                --end if����ؼ� if�� ���������� ���� �Ȼ��� , else�� ���� ����
end;


CASE��

declare
 grade char(1);
begin
 grade := 'B';
 
 case grade 
 when 'A' then
  dbms_output.put_line('Excellent');   
 when 'B' then                 --[����]else if�ƴ� elsif
  dbms_output.put_line('Good');
 when 'C' then
  dbms_output.put_line('Fair');
 when 'D' then
  dbms_output.put_line('Poor');
 else
  dbms_output.put_line('Not Found');
 end case;                              --end case�� ����Ͽ� ��������
end;           


LOOP��
--while���� ����
declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 
 loop                               
    result_num := 2 * test_number;
    if result_num > 20 then
     exit; --��� ����
    else
     dbms_output.put_line(result_num);
    end if;
    test_number := test_number + 1; --[����]test_number�� �������� ������ ��� ���ѷ���
 end loop;
end;

�� �ڵ� �� ���̱�
declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 
 loop
  result_num := 2* test_number;
  
  exit when result_num > 20;
  
  dbms_output.put_line(result_num);
  test_number := test_number + 1;  
 end loop;
end;


WHILE-LOOP��

declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 result_num := 0;
 
 while result_num < 20 loop
  result_num := 2 * test_number;
  dbms_output.put_line(result_num);
  test_number := test_number + 1;       --���� �߰����� ������ ���ѷ���
 end loop;
end;


FOR..LOOP��

declare
 test_number integer;
 result_num integer;
begin
 for test_number in 1..10 loop
  result_num := 2 * test_number;
  dbms_output.put_line(result_num);
 end loop;
end;



[����]���� ���� ����� Ǯ���
JOIN 3����
1.������ SALESMAN�� �����ȣ,����̸�,�μ���,���� ���
SELECT e.empno,e.ename,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.job='SALESMAN';

2.�����ں��� ������ ���� ����� �̸�,�޿�,Ŀ�̼� ���
SELECT e.ename,e.sal,NVL(e.comm,0) comm1 FROM emp e,emp m WHERE e.mgr=m.empno AND e.sal>m.sal;

3.����((sal+comm)*12)�� ���� ���� ����� ����̸�,����,����,Ŀ�̼�,����,��� ���
SELECT e.ename,e.job,NVL(e.comm,0) Ŀ�̼�,(e.sal+NVL(e.comm,0))*12 ����, s.grade
FROM emp e,salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal
AND (e.sal+NVL(e.comm,0))*12=(SELECT MIN((sal+NVL(comm,0))*12) FROM emp);


�������� 3����
1.���� ���� ������ �޴� ����� �����ȣ,�̸� ���
SELECT empno,ename FROM emp WHERE sal=(SELECT MAX(sal) FROM emp);

2.�μ��� �޿��� ����̻��� ����� ���� ���
SELECT COUNT(*) FROM emp WHERE sal>=(SELECT AVG(sal) FROM emp);

3.������ ���� ���� ����� �Ի����� ���� ����� ���
SELECT empno,ename,hiredate,sal FROM emp WHERE sal=(SELECT MIN(sal) FROM emp);




