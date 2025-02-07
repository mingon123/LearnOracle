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

CREATE OR REPLACE VIEW emp30_view AS
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
SQL> DROP USER user02; --���̺� ������ �־ ���� �Ұ�

USER02 ������ ��ü�� �����ϰ� ���� ��쿡�� CASCADE �ɼ��� �߰��ؼ� ����
SQL> drop user user02 CASCADE; --���⼱ �ȵǴµ� �Ϲ������δ� ����































