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

����� S�� ���Ե� ��� ���� �б�
SELECT * FROM emp WHERE ename LIKE '%S%';

������� S�� �����ϴ� ��� ���� �б�
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename NOT LIKE 'S%'; --����

�Ի����� 22�� ������ �� �Ի��� ��� ���� �б�
SELECT * FROM emp WHERE hiredate LIKE '%22'; --��¥�� ã�� �� ����, ���ڿ��� �Է�

����̸��� FOR ������ �ѱ��ڷ� ������ �̸��� ���� ��� ���� �б�
SELECT * FROM emp WHERE ename LIKE 'FOR_';

NULL ���� ���
SELECT * FROM emp WHERE comm = NULL; -- comm = null�� �Ұ�
SELECT * FROM emp WHERE comm IS NULL; --�̷��� �Է��ؾ���
SELECT * FROM emp WHERE comm IS NOT NULL; -- comm != null�� �Ұ�

[�ǽ�����]
1.emp���̺��� �����ȣ(empno),����̸�(ename),����(sal)�� ����Ͻÿ�
SELECT empno,ename,sal FROM emp;

2.emp���̺��� ����̸��� ������ ����ϴµ� �÷����� "�� ��", "�� ��"���� �ٲ㼭 ����Ͻÿ�.
SELECT ename "�� ��", sal "�� ��" FROM emp;

3.emp���̺��� �����ȣ,����̸�,����,������ ���ϰ� ���� �÷����� "�����ȣ","����̸�","����","����"���� ����Ͻÿ�.
SELECT empno �����ȣ,ename ����̸�,sal ����,sal*12 ���� FROM emp;

4.emp���̺��� �����ȣ�� 7698�� ����� �̸�,����(job),�޿��� ����Ͻÿ�
SELECT ename,job,sal FROM emp WHERE empno=7698;

5.emp���̺��� ����̸��� SMITH�� ����� �̸��� ����,�μ���ȣ(deptno)�� ���Ͻÿ�.
SELECT ename,sal,deptno FROM emp WHERE ename='SMITH';

6.������ 2500�̻� 3500�̸��� ����� �̸�,�Ի���,������ ���Ͻÿ�.
SELECT ename,hiredate,sal FROM emp WHERE sal>=2500 AND sal<3500;

7.�޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸�,����,�޿��� ����Ͻÿ�.
SELECT ename,job,sal FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
SELECT ename,job,sal FROM emp WHERE not (sal>=2000 AND sal<=3000);

8.81��05��01�ϰ� 81��12��03�� ���̿� �Ի��� ����� �̸�,�޿�,�Ի����� ����Ͻÿ�.
SELECT ename,sal,hiredate FROM emp WHERE hiredate BETWEEN '81/05/01' AND '81/12/03'; --��¥���� ''�ʼ�!
SELECT ename,sal,hiredate FROM emp WHERE hiredate BETWEEN '81-05-01' AND '81-12-03';
SELECT ename,sal,hiredate FROM emp WHERE hiredate>='81/05/01' AND hiredate<='81/12/03';

9.�����ȣ�� 7566,7782,7934�� ����� ������ ������� �����ȣ,�̸�,������ ����Ͻÿ�.
SELECT empno,ename,sal FROM emp WHERE empno NOT IN(7566,7782,7934);

10.�޿��� 2000�� 5000���̰� �μ���ȣ�� 10 �Ǵ� 30�� ����� �̸��� �޿�,�μ���ȣ�� ����Ͻÿ�.
SELECT ename,sal,deptno FROM emp WHERE (sal BETWEEN 2000 AND 5000) AND deptno IN(10,30);
SELECT ename,sal,deptno FROM emp WHERE (sal BETWEEN 2000 AND 5000) AND (deptno = 10 OR deptno = 30);


ORDER BY : ����
ASC : ������������ ���� ����(�⺻ ����)
DESC : ������������ ���� ����

SELECT * FROM emp WHERE deptno = 10 ORDER BY sal; --�������� ����
SELECT * FROM emp WHERE deptno = 10 ORDER BY sal ASC; --�������� ����(��������)
SELECT * FROM emp WHERE deptno = 10 ORDER BY sal DESC; --�������� ����

SELECT * FROM emp ORDER BY sal DESC,ename DESC; --�ߺ��� �ִ� ��� 2�������� ���� �ٽ� ������ �� ����

SELECT * FROM emp ORDER BY job,sal DESC,ename; --�ߺ����� �ִٸ� 2��,3������ �����ϴ�.

�� ALIAS�� �������� ����
SELECT empno,ename,sal,sal*12 annsal FROM emp ORDER BY annsal; --������ ��ALIAS ��� ����(WHERE���� ����)

���� ���� ��ġ�� ����Ͽ� ����
--      1     2    3     4
SELECT ename,job,deptno,hiredate FROM emp ORDER BY 3; --index3��°�� deptno�� �������� ����

���̺� ������ ������� �� ���� ��ġ �ο� --���������� �ʾƼ� ���� ����
SELECT * FROM emp ORDER BY 2;

NULLS FIRST �Ǵ� NULLS LAST Ű���带 ����Ͽ� ��ȯ�� �� �� NULL���� �����ϴ� ���� ���� ������ �� ó���� ��Ÿ���ų� �������� ��Ÿ������ ���� 

SELECT * FROM emp ORDER BY comm NULLS FIRST; --�Ⱦ��� �� �Ʒ��� ���µ� ���� ������ ������ ���
SELECT * FROM emp ORDER BY comm DESC NULLS LAST;

SELECT * FROM emp ORDER BY comm DESC NULLS LAST, ename; --2������

[�ǽ�����]
1.�����ȣ,����̸�,�Ի����� ����ϴµ� �Ի����� ���� ��������� �����Ͻÿ�.
SELECT empno,ename,hiredate FROM emp ORDER BY hiredate;

2.����̸�,�޿�,������ ���ϰ� ������ ���� ������ �����Ͻÿ�.
SELECT ename,sal,sal*12 FROM emp ORDER BY sal*12 DESC;
SELECT ename,sal,sal*12 annsal FROM emp ORDER BY annsal DESC; --�ڹٿ����� ALIAS ����

3.10�� �μ� �Ǵ� 20�� �μ����� �ٹ��ϰ� �ִ� ����� �̸��� �μ���ȣ�� ����ϴµ� �̸��� �����ڼ����� ǥ���Ͻÿ�.
SELECT ename,deptno FROM emp WHERE deptno IN(10,20) ORDER BY ename;


