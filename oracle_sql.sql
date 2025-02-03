�����ͺ��̽�(Database) : ���������� ����Ǵ� ������ ������ ����

SQL(Standard Query Language) : SQL�� �����ͺ��̽����� �����͸� �˻�,����,����,������ �� �ִ� ǥ�� ���

SELECT�� : �����ͺ��̽��κ��� ����Ǿ� �ִ� �����͸� �˻��ϴµ� ���

��ü ���̺� ��
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno FROM emp;
SELECT * FROM emp; -- *�� ��� �÷��� �ǹ���

Ư�� �� ����
SELECT ename,job,sal FROM emp;

�ּ�
SELECT * /*�ּ�*/ FROM emp; --�ּ�     sql�� �ȿ����� /* */, �ۿ����� --���

dual : �Լ� �� ����� ����� �� �� ����� �� �ִ� ����(Public) ���̺�
SELECT SYSDATE FROM dual;
SELECT 7 + 10 FROM dual;
SELECT ASCII('A') FROM dual;
SELECT ASCII(0) FROM dual;

�����:���������(+,-,*,/)�� ����Ͽ� ���� �� ��¥ �����ͷ� ǥ������ �ۼ�
SELECT ename,sal,sal + 300 FROM emp;

������ �켱����
SELECT ename,sal,(sal + 300) * 12 FROM emp;

NULL ���� ���� : NULL�� ����� �� ���ų�, �Ҵ���� �ʾҰų�, �� �� ���ų�, ������ �� ���� ��(NULL�� 0�̳� ������� �ٸ�)
SELECT empno,ename,job,comm FROM emp;

������� null�� : null���� �����ϴ� ������� null�� ���
SELECT ename, comm + 100 FROM emp;

--null�� �Է� ��ü�� ���� �ʴ� ��, 0�̳� ������ �Էµ� ��. null�� ������ �ȵȴ�. null�� ���
--SQL ������ ���ڿ� ���ڿ� ��� ''��������ǥ�� ���

�� ALIAS : �� �̸��� �ٲ�
�� �̸� �ٷ� �ڿ� ����. �� �̸��� ALIAS ���̿� ���� ������ AS Ű���尡 �� ���� ����
�˸��ƽ��� ū����ǥ�� ����ϴ� ���
 - ��ҹ��� ������ ���� ��
 - ���� ���Խ�
 - _,# �� Ư������ ����(_�� "" ���� �߰����� �� �� ������ �� �տ� ���� ���� �߻�)
 - ���ڷ� ������ ���

SELECT sal*12 Asal FROM emp; --�ٷεڿ� ��ĭ ��� ��Ī �Է�
SELECT sal*12 AS Asal FROM emp;
SELECT sal*12 "Annual Salary" FROM emp; --������ ������ ������ ����, ū����ǥ�� ����ϸ� �Է°� �״�� ���

���� ������
���̳� ���ڿ��� �ٸ� ���� ����
�� ���� ���μ�(||)���� ��Ÿ�� --java������ +�� ���� ���

select ename || ' has $' || sal FROM emp;

distinct : �ߺ��� ����
SELECT deptno FROM emp;
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT(deptno) FROM emp; --DISTINCT�� ���̺�� �տ� �������

describe : ���̺��� ���� ǥ��
DESCRIBE emp;
DESC emp;

WHERE�� : ������ ����Ͽ� �� ����
10�� �μ����� ���ϴ� ����� ���� �б�
SELECT * FROM emp WHERE deptno=10;

SMITH ���� �б�
SELECT * FROM emp WHERE ename='SMITH'; --�Էµ� �����ʹ� ��ҹ��� ����O

��¥ ���� �б�
SELECT * FROM emp WHERE hiredate > '81/12/03'; --��¥�� ('/, -')���� ���� , �񱳿����� ��� ����

[����] where�������� �˸��ƽ�(ALIAS)�� ����� �� ����
SELECT ename,sal,sal*12 ansal FROM emp WHERE sal*12 > 15000; --where������ ansal�� �Է��ϸ� ����

�� �������� ���
SELECT * FROM emp WHERE hiredate = '81/12/03'; --����
SELECT * FROM emp WHERE hiredate != '81/12/03'; --�����ʴ�
SELECT * FROM emp WHERE hiredate <> '81/12/03'; --�����ʴ�
SELECT * FROM emp WHERE hiredate ^= '81/12/03'; --�����ʴ�

�̻� ~ ����
SELECT * FROM emp WHERE sal>=1000 AND sal<=1500;

BETWEEN ~ AND ~ : �� �� ����(������ �� ����)
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 1500;
SELECT * FROM emp WHERE sal NOT BETWEEN 1000 AND 1500; --������

IN : �� ��� ���� ���� ��ġ
SELECT * FROM emp WHERE sal IN (1300,2450,3000);
SELECT * FROM emp WHERE sal NOT IN (1300,2450,3000); --����
SELECT ename,mgr,deptno FROM emp WHERE ename IN ('ALLEN', 'FORD');

LIKE : �����ڸ� ����Ͽ� ���� ��ġ�� ������ �о��
 %�� 0�� �̻��� ���ڸ� ��Ÿ��
 _�� �� ���ڸ� ��Ÿ��





