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

SELECT ename || ' has $' || sal FROM emp;

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


[����]
1.emp���̺��� ����(job)�� �ߺ����� �ʰ� ǥ���Ͻÿ�.
SELECT DISTINCT job FROM emp;

2.������ SALESMAN �Ǵ� MANAGER �̸鼭 �޿��� $1,600,%2975,$2850�� �ƴ� ��� ����� �̸�,���� �� �޿��� ǥ���Ͻÿ�.
SELECT ename,job,sal FROM emp WHERE job IN ('SALESMAN','MANAGER') AND sal NOT IN(1600,2975,2850);

3.������ MAN �� ���ԵǾ� �ְ�, �޿��� $1,000~$3,000���̷� �޴� ����� �̸�,�޿�,������ ����Ͻÿ�.
SELECT ename,sal,job FROM emp WHERE job LIKE '%MAN%' AND sal BETWEEN 1000 AND 3000;

4.�̸��� S�� ������ ����� �߿��� 30�� �μ��� �ٹ��ϴ� ����� �̸�,�޿�,�μ���ȣ�� ����Ͻÿ�.
SELECT ename,sal,empno FROM emp WHERE ename LIKE '%S' AND deptno=30;

5.Ŀ�̼� ����� ���� ��� ����� �̸�,�޿�,Ŀ�̼��� ����ϴµ� Ŀ�̼��� �������� �������� �����Ͻÿ�.
SELECT ename,sal,comm FROM emp WHERE comm IS NOT NULL ORDER BY comm DESC ;



�Լ�

�����Լ�

��ҹ��� ���� �Լ� - LOWER, UPPER, INITCAP
SELECT LOWER('HELLO') FROM dual;
SELECT UPPER('hello') FROM dual;
SELECT INITCAP('hello wORLD') FROM dual; -- ù���� �빮��, ������ �ҹ���

SELECT LOWER(ename) FROM emp;
SELECT INITCAP(ename) FROM emp;

���� �����Լ�
CONCAT(���ڿ�1,���ڿ�2) : ���ڿ�1�� ���ڿ�2�� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ

SELECT CONCAT('Hello', 'World') FROM dual;

SUBSTR(����ڿ�,�ε���) : ����ڿ����� ������ �ε������� ���ڿ��� ����
[����]�ε��� 1���� ����
SELECT SUBSTR('Hello World',3) FROM dual;
SELECT SUBSTR('Hello World',3,3) FROM dual; --�ε���3���� 3���� ����
SELECT SUBSTR('Hello World',-3) FROM dual; --�ڿ��� ����°���� ������ ����
SELECT SUBSTR('Hello World',-3,2) FROM dual; --�ڿ��� ����°���� 2���� ����

LENGTH(����ڿ�) : ���ڿ��� ����
SELECT LENGTH('Hello World') FROM dual;

INSTR(����ڿ�,�˻�����) : �˻������� ��ġ�� �˻�

SELECT INSTR('Hello World','e') FROM dual;

�˻� ���ڰ� ���� ��� 0 ��ȯ
SELECT INSTR('Hello World','E') FROM dual; 
SELECT INSTR('Hello World','o') FROM dual; --�ߺ����� ��� ���� ���� ������
            ����ڿ�,�˻�����,�˻��ε���:�ش� ��ġ���� �˻�
SELECT INSTR('Hello World','o',6) FROM dual;
            ����ڿ�,�˻�����,�˻��ε���,�ݺ�Ƚ��
�ݺ�Ƚ��:*����ڿ� ��ü�� ������ �˻��Ѵٴ� �ǹ̰� �ƴ϶� 1�� �˻����� o�� ã���� ������ Ƚ����ŭ �� ���� ���ڸ� �˻��Ѵٴ� �ǹ�
SELECT INSTR('Hello World','o',1,2) FROM dual;

LPAD(����ڿ�,�ѱ���,����) : ������ ���̿� ���ڿ��� ����ϴµ� ������ ���ʿ� ������ ���ڷ� ä��
RPAD(����ڿ�,�ѱ���,����) : ������ ���̿� ���ڿ��� ����ϴµ� ������ �����ʿ� ������ ���ڷ� ä��

SELECT LPAD('Hello',10,'*') FROM dual; --�������ڰ� ������ �������� ä��
SELECT RPAD('Hello',10,'*') FROM dual;

TRIM : ���ڿ����� �����̳� Ư�� ���ڸ� ������ ���� ���� ��ȯ
���� : LEADING -> ����, TRAILING -> ������, BOTH -> ����(DEFAULT)
SELECT TRIM(LEADING 'h' FROM 'habchh') FROM dual; --���� h����
SELECT TRIM(TRAILING 'h' FROM 'habchh') FROM dual; --������ h���� ����
SELECT TRIM(BOTH 'h' FROM 'habchh') FROM dual; --���� h���� ����

LTRIM(����ڿ�,������ ����) : ���ڿ��� ���ʿ��� �����̳� Ư�� ���ڸ� ������ ���� ���� ��ȯ
SELECT LTRIM('habchh','h') FROM dual;

RTRIM(����ڿ�,������ ����) : ���ڿ��� �����ʿ��� �����̳� Ư�� ���ڸ� ������ ���� ���� ��ȯ
SELECT RTRIM('habchh','h') FROM dual;

REPLACE(����ڿ�,OLD,NEW) : ����ڿ����� OLD���ڸ� NEW���ڷ� ��ü
SELECT REPLACE('010.1234.5678','.','-') FROM dual;

�Լ� ��ø 
SELECT ename,LOWER(SUBSTR(ename,1,3)) FROM emp;

[�ǽ�����]
1.����(job)�� ù���ڴ� �빮�� �������� �ҹ��ڷ� ����Ͻÿ�.
SELECT INITCAP(job) FROM emp;

2.����̸� �� A�� ���Ե� ����̸��� ���ϰ� �� �̸� �� �տ��� 3�ڸ� �����Ͽ� ����Ͻÿ�.
SELECT ename,SUBSTR(ename,1,3) FROM emp WHERE ename LIKE '%A%';

3.�̸��� ����° ���ڰ� A�� ��� ����� �̸��� ǥ���Ͻÿ�.
SELECT ename FROM emp WHERE SUBSTR(ename,3,1) = 'A';
SELECT ename FROM emp WHERE ename LIKE '__A%';

4.�̸��� J,A �Ǵ� M���� �����ϴ� ��� ����� �̸�(ù���ڴ� �빮�ڷ�, ���������ڴ� �ҹ��ڷ� ǥ��) �� �̸��� ���̸� ǥ���Ͻÿ�.(�����̺� name �� length �� ǥ��)
SELECT INITCAP(ename) name,LENGTH(ename) length FROM emp WHERE ename LIKE 'J%' OR ename LIKE 'A%' OR ename LIKE 'M%';
SELECT INITCAP(ename) name,LENGTH(ename) length FROM emp WHERE SUBSTR(ename,1,1) IN('J','A','M');


�����Լ�
CEIL(�Ǽ�) : �ø� ó���� �������� ��ȯ
SELECT CEIL(1.4) FROM dual;

FLOOR(�Ǽ�) : ���� ó���� �������� ��ȯ
SELECT FLOOR(1.7) FROM dual;

ROUND(������,�����ڸ���) : �ݿø�
SELECT ROUND(45.926,2) FROM dual; --2��°�ڸ����� ���(3��°�ڸ����� �ݿø�)
SELECT ROUND(45.926) FROM dual; --�������� ��ȯ

TRUNC(������,�����ڸ���) : ����
SELECT TRUNC(45.926,2) FROM dual; --45.92(�ش��ڸ�������)
SELECT TRUNC(45.926) FROM dual; --45(����)

MOD(������,���� ����) : ��������
SELECT MOD(17,2) FROM dual; --17%2�� ����


��¥�Լ�
SYSDATE : ORACLE ������ ���� ��¥�� �ð��� ��ȯ
SELECT SYSDATE FROM dual; --�⺻�� ��¥�� ǥ��

��¥�� ��� ������ ���
SELECT ename,hiredate,(SYSDATE - hiredate)/7 AS WEEKS FROM emp WHERE deptno=10; --�Ի����� ���ְ� ��������

MONTHS_BETWEEN(��¥1,��¥2) : �� ��¥ ���� �� �� 
SELECT MONTHS_BETWEEN('2024-08-29','2023-01-29') FROM dual; --ū��¥�� ������ �;���. �������� ������ ���� ������ ����

SELECT ename,MONTHS_BETWEEN(SYSDATE,hiredate) months_worked FROM emp ORDER BY months_worked;
SELECT ename,TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)) months_worked FROM emp ORDER BY months_worked; --�Ҽ�������

ADD_MONTHS : Ư�� ��¥�� ���� ������ ���� ���� �ش� ��¥�� ��ȯ�ϴ� �Լ�
SELECT ADD_MONTHS('2024-08-29',8) FROM dual;

NEXT_DAY : ������ ������ ���� ��¥
SELECT NEXT_DAY('2025/02/03','������') FROM dual;

1(�Ͽ���) ~ 7(�����)
SELECT NEXT_DAY('2025/02/04',2) FROM dual;

LAST_DAY : ���� ������ ��
SELECT LAST_DAY('2025-02-04') FROM dual;


EXTRACT : ��¥ �������� Ư���� ��,��,��,��,��,�� ����

SELECT EXTRACT(YEAR FROM SYSDATE) YEAR,
       EXTRACT(MONTH FROM SYSDATE) MONTH,
       EXTRACT(DAY FROM SYSDATE) DAY
FROM dual;

SELECT EXTRACT(YEAR FROM hiredate) YEAR,
       EXTRACT(MONTH FROM hiredate) MONTH,
       EXTRACT(DAY FROM hiredate) DAY
FROM emp;

SELECT EXTRACT(YEAR FROM SYSTIMESTAMP) YEAR,
       EXTRACT(MONTH FROM SYSTIMESTAMP) MONTH,
       EXTRACT(DAY FROM SYSTIMESTAMP) DAY,
       EXTRACT(HOUR FROM SYSTIMESTAMP) HOUR, 
       EXTRACT(MINUTE FROM SYSTIMESTAMP) MINUTE, 
       EXTRACT(SECOND FROM SYSTIMESTAMP) SECOND
FROM dual;

SELECT EXTRACT(YEAR FROM DATE'2025-02-04') YEAR, --DATE�� ���̸� ���ڿ��� ��� ����
       EXTRACT(MONTH FROM DATE'2025-02-04') MONTH,
       EXTRACT(DAY FROM DATE'2025-02-04') DAY
FROM dual; 

SELECT EXTRACT(YEAR FROM TIMESTAMP'2025-02-04 11:45:10') YEAR, --DATE�� ���̸� ���ڿ��� ��� ����
       EXTRACT(MONTH FROM TIMESTAMP'2025-02-04 11:45:10') MONTH,
       EXTRACT(DAY FROM TIMESTAMP'2025-02-04 11:45:10') DAY,
       EXTRACT(HOUR FROM TIMESTAMP'2025-02-04 11:45:10') HOUR, --�ð��� DATE���� TIMESTAMP ����ؾ���
       EXTRACT(MINUTE FROM TIMESTAMP'2025-02-04 11:45:10') MINUTE,
       EXTRACT(SECOND FROM TIMESTAMP'2025-02-04 11:45:10') SECOND
FROM dual; 

[�ǽ�����]
1.���ú��� �̹����� �������������� ���� �� ���� ���Ͻÿ�.
SELECT LAST_DAY(SYSDATE)-SYSDATE AS "���� �� ��" FROM dual;

2.�� ����� �����ȣ,�̸�,�޿� �� 15% �λ�� �޿��� ����(�ݿø�)�� ǥ���Ͻÿ�. �λ�� �޿� ���� ���̺��� New Salary�� �����Ͻÿ�.
SELECT empno,ename,sal,ROUND(sal+sal*0.15) "New Salary" FROM emp;

3.������ ������ 4�� ����� ������ �޴� ����� �̸��� ������ ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE MOD(sal,4)=0;


��ȯ�Լ�

����� ������ ���� ����
TO_CHAR : ���� -> ����, ��¥ -> ����
TO_NUMBER : ���� -> ����
TO_DATE : ���� -> ��¥

TO_CHAR : ��¥ -> ����
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM dual;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM dual;

TO_CHAR : ����->����

���� �ڸ����� ��ġ�ؾ���
SELECT TO_CHAR(1234,9999) FROM dual; --9 : �ڸ���
SELECT TO_CHAR(1234,'9999') FROM dual; --���� ����
SELECT TO_CHAR(1234,'0000') FROM dual; --0000���� ����ϸ� ##��� ����. ''�ʼ�!

�ڸ����� ���ڶ�
SELECT TO_CHAR(1234,999) FROM dual; --####(���Ŀ� �����ʾ� ����)
SELECT TO_CHAR(1234,'999') FROM dual; --####
SELECT TO_CHAR(1234,'000') FROM dual; --####

�ڸ��� �������� ���� : ���� -> ����
SELECT TO_CHAR(1234) FROM dual; --1234

���� �ڸ������� ���� �ڸ��� ����
SELECT TO_CHAR(1234,99999) FROM dual; -- 1234(�� �տ� ������ĭ ���)
SELECT TO_CHAR(1234,'99999') FROM dual; -- 1234
SELECT TO_CHAR(1234,'00000') FROM dual; --01234

�Ҽ��� �ڸ�
SELECT TO_CHAR(1234,9999.99) FROM dual; --1234.00
SELECT TO_CHAR(1234,'9999.99') FROM dual; --1234.00
SELECT TO_CHAR(1234,'0000.00') FROM dual; --1234.00

�ݿø��ؼ� �Ҽ��� ��°�ڸ����� ǥ��
SELECT TO_CHAR(25.897,'99.99') FROM dual; --25.90
--�ݿø�(ROUND : ������������, TO_CHAR : ���ڷ� ��ȯ)
�λ�� �޿��� �Ҽ��� ù°�ڸ����� ǥ��
SELECT TO_CHAR(sal*1.15,'9,999.9') FROM emp;

��ȭǥ��
SELECT TO_CHAR(1234,'$0000') FROM dual;
������ȭ ǥ��(��)
SELECT TO_CHAR(1234,'L0000') FROM dual; --$���ܴ� �ý����� ���ڸ� �������� ��ȭǥ��

TO_DATE -- ���� -> ��¥
SELECT TO_DATE('25-02-04','YYYY-MM-DD') FROM dual; --25/02/04
���� ���� ���� ����
SELECT TO_DATE('25-02-04') FROM dual;

TO_NUMBER --���� -> ����
SELECT TO_NUMBER('100',999) FROM dual;
���� ���� ���� ����
SELECT TO_NUMBER('200') FROM dual;



�Ϲ��Լ�

***(NVL�ϱ�)
NVL(value1,value2) : value1�� null�̸� value2�� ���. value1�� value2�� �ڷ����� ��ġ�ؾ���
SELECT ename,sal,comm, sal+NVL(comm,0) �Ǳ޿� FROM emp;

SELECT ename,NVL(TO_CHAR(comm),'No Commission') "COMM." FROM emp;

NVL2(value1,value2,value3) : value1�� null���� ��. null�̸� value3, null�� �ƴϸ� value2. �ڷ����� ��ġ���� �ʾƵ� ��.

SELECT ename,job,NVL2(comm,'commission','no commission') FROM emp;

NULLIF(value1,value2) : �� ���� ���� ��ġ�ϸ� null, �� ���� ���� ��ġ���� ������ value1
SELECT NULLIF(LENGTH(ename),LENGTH(job)) "NULLIF" FROM emp;

COALESCE(value1,value2,value3,...) : null���� �ƴ� ���� ���(�ڷ��� ��ġ)
SELECT comm,mgr,sal, COALESCE(comm,mgr,sal) FROM emp;


***(�ϱ�)CASE : ���� ��� ������ �Լ�
CASE �÷� WHEN �񱳰� THEN �����
         WHEN �񱳰� THEN �����
         WHEN �񱳰� THEN �����
         (ELSE �����)
END;

SELECT ename,sal,job,
       CASE job WHEN 'SALESMAN' THEN sal*0.1
                WHEN 'MANAGER' THEN sal*0.2
                WHEN 'ANALYST' THEN sal*0.3
                ELSE sal*0.4
        END "Bonus"
FROM EMP;

SELECT ename,sal,job,
       CASE WHEN sal>=4000 AND sal<=5000 THEN 'A'
            WHEN sal>=3000 AND sal<4000 THEN 'B'
            WHEN sal>=2000 AND sal<3000 THEN 'C'
            WHEN sal>=1000 AND sal<2000 THEN 'D'
            ELSE 'F'
       END "Grade"
FROM emp ORDER BY sal DESC;

DECODE(����Ŭ ����) : = �񱳸� ����
DECODE(�÷�,�񱳰�,��ȯ��,
            �񱳰�,��ȯ��,
            �񱳰�,��ȯ��,
            ��ȯ��)
            
SELECT ename,sal,job,
       DECODE(job,'SALESMAN',sal*0.1,
                  'MANAGER', sal*0.2,
                  'ANALYST', sal*0.3,
                  sal*0.4) "Bonus"
FROM emp;

SELECT ename,sal,job,
        DECODE(TRUNC(sal/1000),5,'A',
                               4,'A',
                               3,'B',
                               2,'C',
                               1,'D',
                               'F') "Grade"
FROM emp ORDER BY sal DESC;

Ư�� �÷��� Ư������ ���� ���� �����ϴ� ���
ORDER BY (CASE �÷��� WHEN �񱳰� THEN 1(����)
                     WHEN �񱳰� THEN 2
                     ELSE 3
          END)

������� �����ϴµ� 7698�� ���� ���� ���� ����
SELECT empno,ename,sal FROM emp 
ORDER BY (CASE empno WHEN 7698 THEN 1
          END),empno;

[�ǽ�����]
1.����̸�,����,���ް� Ŀ�̼��� ���� ���� �÷��� �Ǳ޿���� �ؼ� ����Ͻÿ�.
  ��, null���� ��Ÿ���� �ʰ� �ۼ��Ͻÿ�.
SELECT ename,sal,sal+NVL(comm,0) �Ǳ޿� FROM emp;

2.���ް� Ŀ�̼��� ��ģ �ݾ��� 2,000�̻��� �޿��� �޴� ����� �̸�,����,����,Ŀ�̼�,��볯¥�� ����Ͻÿ�.
  ��, ��볯¥�� 1980-12-17 �������� ����Ͻÿ�.
SELECT ename,job,sal,comm,TO_CHAR(hiredate,'YYYY-MM-DD') AS hiredate FROM emp WHERE sal+NVL(comm,0)>=2000;

3.DECODE �Լ��� ����Ͽ� ���� �����Ϳ� ���� JOB���� ���� �������� ��� ����� ����� ǥ���Ͻÿ�.
  ����     ���
  PRESIDENT A
  ANALYST   B
  MANAGER   C
  SALESMAN  D
  CLERK    E
  ��Ÿ      0(��)
SELECT ename, job, 
       DECODE(job,'PRESIDENT','A',
                  'ANALYST','B',
                  'MANAGER','C',
                  'SALESMAN','D',
                  'CLERK','E',
                  '0') "Grade"
FROM emp ORDER BY "Grade";

[�ǽ�����]
1.�����ڹ�ȣ(mgr)�� ���� ��� ����� �̸��� ������ ǥ���Ͻÿ�.(king)
SELECT ename,job FROM emp WHERE mgr IS NULL;

2.Ŀ�̼� �׸��� �Էµ� ������� �̸��� �޿�,Ŀ�̼��� ���Ͻÿ�.
SELECT ename,sal,comm FROM emp WHERE comm IS NOT NULL;

3.�̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �ҹ��ڷ� �̸��� ����Ͻÿ�.
SELECT LOWER(ename) FROM emp WHERE LENGTH(ename)>=6;

4.�� ����� �̸��� ǥ���ϰ� �ٹ� �� ��(�Ի��Ϸκ��� ��������� �� ��)�� ����Ͽ� �� ���̺��� MONTHS_WORKED�� �����Ͻÿ�.
  ����� ������ �ݿø��Ͽ� ǥ���ϰ� �ٹ��� ���� �������� ������������ �����Ͻÿ�.
SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)) AS MONTHS_WORKED FROM emp ORDER BY MONTHS_WORKED;

5.�̸�(�ҹ��ڷ� ǥ��),����,�ٹ������� ����Ͻÿ�.
SELECT LOWER(ename),job,TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)/12) AS "�ٹ�����" FROM emp;


�׷��Լ� : �� ���� ������ �����Ͽ� �׷캰�� �ϳ��� ����� ����
AVG() : NULL�� ������ ��� ������ ����� ��ȯ. NULL���� ��� ��꿡�� ���õ�.
SELECT ROUND(AVG(sal)) FROM emp;

--���ڵ� : �����Ͱ� �� �ִ� ��
COUNT() : NULL�� ������ ���� ���� ��� ���ڵ��� ���� ��ȯ. COUNT(*)������ ����ϸ� NULL�� ��꿡 ����.

SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp;

MAX() : ���ڵ� ���� �ִ� ������ �� ���� ū ���� ��ȯ
SELECT MAX(sal) FROM emp;
SELECT MAX(ename) FROM emp; --���������� ���� ������(���ĺ���)
SELECT MAX(hiredate) FROM emp;

MIN() : ���ڵ� ���� �ִ� ������ �� ���� ���� ���� ��ȯ
SELECT MIN(sal) FROM emp;
SELECT MIN(ename) FROM emp; --���������� ���� ��
SELECT MIN(hiredate) FROM emp;

SUM() : ���ڵ���� �����ϰ� �ִ� ��� ���� ���Ͽ� ��ȯ
SELECT SUM(sal) FROM emp;

SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp;
SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp WHERE deptno = 10;
SELECT COUNT(*) FROM emp WHERE deptno=20; --�������� �� �� ����
SELECT COUNT(empno) FROM emp WHERE deptno=30; --null���� �ִ� �÷��� ����� �ȳ���


GROUP BY & HAVING

SELECT���� �����Լ�(�׷��Լ�) ����� ���� �÷��� ������ �� ����.
���� �÷��� ������ ��쿡�� �ݵ�� GROUP BY���� ������ �÷��� ����
SELECT deptno,MAX(sal) FROM emp; --�� ���̺��� ���� ���� �޶� ������ ����
SELECT deptno,MAX(sal) FROM emp GROUP BY deptno;
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno;

���� ������ GROUP BY�� ���
SELECT deptno,job,SUM(sal) FROM emp GROUP BY deptno,job ORDER BY deptno;

�׷� ó�� ����� �����ϰ��� �� �� having�� �̿�
- WHERE������ �����Լ��� ����� �� ���� HAVING�� ���

���� �߻�
SELECT deptno,ROUND(AVG(sal)) FROM emp WHERE ROUND(AVG(sal))>2000 GROUP BY deptno;
--WHERE������ �׷��Լ� ����. HAVING���� ����ؾ� ��.

���� ����
SELECT deptno,ROUND(AVG(sal)) FROM emp GROUP BY deptno HAVING ROUND(AVG(sal))>2000;

HAVING���� �̿� : �˸��ƽ� ��� X
SELECT deptno,MAX(sal) maximum FROM emp GROUP BY deptno HAVING MAX(sal)>3000;--maximum>3000; WHERE��, HAVING�� - ALIAS �ȵ�


[����]
1.������ ������ ��ǥ(,)�� �����ؼ� ǥ���ϰ� �÷����� Employee and Job���� ǥ���Ͻÿ�.
SELECT ename||','||job "Employee and Job" FROM emp;

2.30�� �μ����� �ٹ��ϸ� ��2,000�޷� ���ϸ� �޴� 81��05��01�� ������ �Ի��� ����� �̸�,�޿�,�μ���ȣ,�Ի����� ����Ͻÿ�.
SELECT ename,sal,deptno,hiredate FROM emp WHERE deptno=30 AND sal<=2000 AND hiredate<'81/05/01'; 

3.�̸��� A�� E�� �ִ� ��� ����� �̸��� ǥ���Ͻÿ�.
SELECT ename FROM emp WHERE ename LIKE '%A%' OR ename LIKE '%E%';
SELECT ename FROM emp WHERE ename LIKE '%A%' AND ename LIKE '%E%';

4.����̸� �� S�� ���Ե��� ���� ����� �� �μ���ȣ�� 20���� ������� �̸��� �μ���ȣ�� ����Ͻÿ�.
SELECT ename,deptno FROM emp WHERE ename NOT LIKE '%S%' AND deptno=20;

5.��� ����� �̸��� �޿��� ǥ���ϴµ� �޿��� 15�� ���̷� ���ʿ� $��ȣ�� ä���� �������� ǥ���ϰ� �� ���̺��� SALARY�� �����Ͻÿ�.
SELECT ename,LPAD(sal, 15,'$') SALARY FROM emp;



�׷��Լ� �̿��ϱ�

¦�� �ؿ� Ȧ�� �ؿ� �Ի��� ����� ���� ���ϱ�
SELECT CASE MOD(EXTRACT(YEAR FROM hiredate),2) WHEN 0 THEN '¦�� ����'
                                               ELSE 'Ȧ�� ����'
       END AS YEAR,
       COUNT(empno) AS employee_number
FROM emp GROUP BY MOD(EXTRACT(YEAR FROM hiredate),2); --ORDER BY�� ALIAS ��밡��

1981�⿡ �Ի��� ������� ������κ��� �б⺰ �Ի����� ���� ����
SELECT TO_CHAR(hiredate,'Q') AS "Quarter",COUNT(empno) AS employee_number
FROM emp where extract(year from HIREDATE) = 1981
GROUP BY TO_CHAR(hiredate,'Q') ORDER BY "Quarter";

[�ǽ�����]
1.��� ����� �޿� �ְ��,������,�Ѿ� �� ��վ��� ǥ���Ͻÿ�.�� ���̺��� ���� maximum,minimum,sum �� average�� �����ϰ� ����� ������ �ݿø��ϰ� ���ڸ� ������ ,�� ����Ͻÿ�.
SELECT TO_CHAR(MAX(sal),'9,999') maximum, TO_CHAR(MIN(sal),'9,999') minimum, TO_CHAR(SUM(sal),'99,999') sum, TO_CHAR(ROUND(AVG(sal)),'9,999') average FROM emp; --1�����
SELECT TO_CHAR(MAX(sal),'9,999') maximum, TO_CHAR(MIN(sal),'9,999') minimum, TO_CHAR(SUM(sal),'99,999') sum, TO_CHAR(AVG(sal),'9,999') average FROM emp; --2�����(ROUND ����, format���Ŀ� �Ҽ����� ���)

2.�޿��� Ŀ�̼��� ���� �ݾ��� �ְ�,����,��ձݾ��� ���Ͻÿ�.��ձݾ��� �Ҽ��� ù°�ڸ����� ǥ���Ͻÿ�.
SELECT MAX(sal+NVL(comm,0)) max, MIN(sal+NVL(comm,0)) min, ROUND(AVG(sal+NVL(comm,0)),1) avg FROM emp;

3.������ ������ ������ ������� ǥ���Ͻÿ�.(������ ������� ���Ͻÿ�.)
SELECT job,COUNT(*) FROM emp GROUP BY job;

4.30���μ��� ������� ���Ͻÿ�.
SELECT COUNT(*) FROM emp WHERE deptno=30; --�μ���ȣ�� ������� ���� ���
SELECT deptno,COUNT(*) FROM emp WHERE deptno=30 GROUP BY deptno; --�μ���ȣ�ѻ���� ���
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno HAVING deptno=30; --�Ѵ� ����, where���� ������(having�� �׷��Լ� �� �� ���)

5.������ �ְ� ������ ���ϰ� ����,�ְ� ������ ����Ͻÿ�.
SELECT job,MAX(sal) FROM emp GROUP BY job;

6.20���μ��� �޿� �հ踦 ���ϰ�,�޿� �հ� �޾��� ����Ͻÿ�.
SELECT SUM(sal) FROM emp WHERE deptno=20;

7.�μ����� ���޵Ǵ� �ѿ��޿��� �ݾ��� 9,000�̻��� �޴� ������� �μ���ȣ,�ѿ����� ����Ͻÿ�.
SELECT deptno,SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal)>=9000;

8.�������� ���� ���� ����� ���ϰ� �� ��� ������ ����� 79�� �����ϴ� ����� ����Ͻÿ�.(����,���� ���� ��� ���)
SELECT job,MAX(empno) FROM emp GROUP BY job HAVING MAX(empno) LIKE '79%'; --�̰� ����
SELECT job,MAX(empno) FROM emp WHERE empno LIKE '79%' GROUP BY job; --�̰͵� ����� ����

9.������ �ѿ����� ����ϴµ� ������ 'MANAGER'�� ������� �����ϰ� �ѿ����� 5,000���� ���� ������ �ѿ��޸� ����Ͻÿ�.
SELECT job,SUM(sal) FROM emp WHERE job != 'MANAGER' GROUP BY job HAVING SUM(sal)>5000;

10.�������� ����� ���� 4�� �̻��� ������ �ο����� ����Ͻÿ�.
SELECT job,COUNT(*) FROM emp GROUP BY job HAVING COUNT(*)>=4;


�м��Լ�

RANK() : ������ ǥ���� �� ����ϴ� �Լ�
RANK(���ǰ�) WITHIN GROUP (ORDER BY ���ǰ� �÷��� [ASC|DESC]) : Ư�� �������� ���� Ȯ���ϱ�
[����] RANK �ڿ� ������ �����Ϳ� ORDER BY �ڿ� ������ �����ʹ� ���� �÷��̾�� �Ѵ�.
SELECT RANK('SMITH') WITHIN GROUP (ORDER BY ename) "RANK" FROM emp;

��ü���� ���� : RANK() �ڰ� WITHIN GROUP�� �ƴϰ� OVER�� �ٲ�
������� empno,ename,sal,�޿� ������ ���
SELECT empno,ename,sal,RANK() OVER (ORDER BY sal) "RANK_ASC", RANK() OVER (ORDER BY sal DESC) "RANK_DESC" FROM emp; --��������,�������� ����

10�μ��� ���� �������� ����� �̸�,�޿�,�ش� �μ� ���� �޿� ������ ���
SELECT empno,ename,sal,RANK() OVER (ORDER BY sal DESC) "RANK" FROM emp WHERE deptno=10;

�����ȣ,�̸�,�޿�,�μ���ȣ,�μ��� �޿� ������ ���
SELECT empno,ename,sal,deptno,RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) "RANK" FROM emp; --PARTITION(�׷����� ����)


����(JOIN) : �� �̻��� ���̺��� �����Ͽ� �����͸� �˻��ϴ� ���
            ���� �� �̻��� ����� ����� �� Primary Key �� Foreign Key ���� ����Ͽ� ����

Catesion Product(īƼ�� ��)
�˻��ϰ��� �ߴ� �����ͻ� �ƴ϶� ���ο� ���� ���̺���� ��� �����Ͱ� ��ȯ�Ǵ� ����
SELECT * FROM emp,dept; --emp,dept���̺��� ������ �ߺ������Ͱ� ���� : JOIN�ʿ�

JOIN ���
[ORACLE ����]
���� ����(equi join) : �� ���̺� ���� �÷��� �ִ� ��� ���
�������� Equality Condition(=)�� ���Ͽ� ������ �̷�� ��
SELECT emp.ename,dept.dname FROM emp,dept WHERE emp.deptno=dept.deptno; --�� ���̺� ��� ���� �÷��� �־�� ��(���⼱ deptno)

���̺� �˸��ƽ� �ο��ϱ�
SELECT e.ename,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno; 

�÷����� ȣ���� �� ���̺�� �Ǵ� ���̺� �˸��ƽ��� ����
SELECT ename,d.deptno,dname FROM emp e,dept d WHERE e.deptno=d.deptno; --�� ���̺� ���� �÷��� �ִ� ���� �˸��ƽ� ���� �Ұ� 

�ΰ����� ���� ����ϱ�
SELECT e.ename,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno AND e.ename='ALLEN'; --AND�� ���� �߰� �Է�

SELECT e.ename,e.sal,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno AND e.sal BETWEEN 3000 AND 4000;


--�񵿵����� : ���������� �ȵȴٰ� �ϴ��� ���� ������ �����Ϳ��� �Ѵ�. emp.sal=salgrade�� �����Ǳ� ������ ����
�񵿵� ����(no equi join)
���̺��� � column�� join�� ���̺��� column�� ��ġ���� ���� �� ����ϰ� ���� ������ ����(=)�̿��� �����ڸ� ����(between and,is null,in)

����̸�,�޿�,�޿���� ���ϱ�(emp,salgrade ���̺� �̿�)
SELECT e.ename,e.sal,s.grade FROM emp e,salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal;


SELF JOIN
��� �̸��� �ش� ����� ������ �̸� ���ϱ�(�����ڰ� ���� ��� ����)
SELECT e.ename ����̸�,m.ename �������̸� FROM emp e,emp m WHERE e.mgr=m.empno; --e:�������,m:�����ڹ�ȣ


�ܺ� ����(OUTER JOIN)
Equi JOIN ������� �� ���� �������� �װ͵��� ������ �����Ϸ� �ϴ� �� ���� ���̺��� �� �� �÷����� ����� ���� ���ٸ� ���̺�κ��� �����͸� ��ȯ���� �ʴ´ٴ� ��.
������ ���� ���� ���ؼ��� Outer Join�� ���

������ ���� �ݴ� ���̺��� ���� ������ �÷��� (+)��ȣ ǥ��
SELECT DISTINCT e.deptno,d.deptno FROM emp e,dept d WHERE e.deptno(+)=d.deptno;

����̸��� �ش� ����� ������ �̸����ϱ�(�����ڰ� ���� ����� ǥ��)
SELECT e.ename ����̸�,m.ename �������̸� FROM emp e,emp m WHERE e.mgr=m.empno(+); --�������� �ݴ����̺�


[ǥ�� SQL]
���� ����(INNER JOIN)
SELECT e.ename,d.deptno FROM emp e INNER JOIN dept d ON e.deptno=d.deptno;
SELECT e.ename,d.deptno FROM emp e JOIN dept d ON e.deptno=d.deptno;

JOIN ���� ON���� �����ϰ� �ΰ����� ������ ������ WHERE�� ���
SELECT e.ename,d.dname FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE e.ename='ALLEN';
--JOIN : ��������, ON : ��������, WHERE : �ΰ�����

���� ���� ���ǿ� ���� �÷��� �̸��� ���ٸ� ������ ���� USING���� ����Ͽ� ���� ������ ������ �� �ִ�.
SELECT e.ename,d.dname FROM emp e JOIN dept d USING(deptno) WHERE e.ename='ALLEN';

[����]USING�� ���� �÷��� ���̺�� �Ǵ� ���̺�˸��ƽ��� ������ ����
SELECT e.ename,deptno FROM emp e JOIN dept d USING(deptno); --����: ALIAS���X, USING��ɾ�� �ϳ��� ��ħ

JOIN�� �� �ϳ��� ���̺��� �����ϴ� �÷��� ���̺�� �Ǵ� ���̺� �˸��ƽ��� ������ �ʾƵ� �ĺ� ����
SELECT ename,deptno,dname FROM emp JOIN dept USING(deptno);


SELF JOIN
��� �̸��� �ش� ����� ������ �̸� ���ϱ�(�����ڰ� ���� ����� ����)
SELECT e.ename name,m.ename manager_name FROM emp e JOIN emp m ON e.mgr = m.empno; --USING ��� �Ұ�


�ܺ� ����(OUTER JOIN)
������ ���� ���� ǥ�� --null���� �ʿ��ϸ� ���
SELECT DISTINCT(e.deptno),d.deptno FROM emp e RIGHT OUTER JOIN dept d ON e.deptno=d.deptno; --_1�� �����Ȱ� Ȯ���ϰ� RIGHT OUTER �߰��Ͽ� �� �÷��� �߰�

��� �̸��� �ش� ����� ������ �̸� ���ϱ�(�����ڰ� ���� ����� ǥ��)
SELECT e.ename name,m.ename manager_name FROM emp e LEFT OUTER JOIN emp m ON e.mgr=m.empno;

[�ǽ�����]
1.��� ����� �̸�,�μ���ȣ,�μ��̸��� ǥ���Ͻÿ�.(emp,dept)
SELECT e.ename,e.deptno,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno; --����Ŭ����

SELECT e.ename,d.deptno,d.dname FROM emp e JOIN dept d ON e.deptno=d.deptno; --ǥ��SQL
SELECT ename,deptno,dname FROM emp JOIN dept USING(deptno); --ǥ��SQL

2.������ MANAGER�� ����� ������ �̸�,����,�μ���,�ٹ��� ������ ����Ͻÿ�.(emp,dept)
SELECT e.ename,e.job,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.job='MANAGER'; --����Ŭ����

SELECT e.ename,e.job,d.dname,d.loc FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE e.job='MANAGER'; --ǥ��SQL
SELECT ename,job,dname,loc FROM emp e JOIN dept USING(deptno) WHERE job='MANAGER';

3.Ŀ�̼��� �ް� �޿��� 1,600�̻��� ����� ����̸�,�޿�,�μ���,�ٹ����� ����Ͻÿ�.
SELECT e.ename,e.sal,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.comm IS NOT NULL AND e.sal>=1600; --����Ŭ����

SELECT e.ename,e.sal,d.dname,d.loc FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE e.comm IS NOT NULL AND e.sal>=1600; --ǥ��SQL
SELECT ename,sal,dname,loc FROM emp JOIN dept USING(deptno) WHERE comm IS NOT NULL AND sal>=1600;

4.�ٹ���(LOC)�� CHICAGO�� ��� ����� �̸�,����,�μ���ȣ �� �μ��̸��� ǥ���Ͻÿ�.
SELECT e.ename,e.job,d.deptno,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno AND d.loc='CHICAGO'; --����Ŭ����

SELECT e.ename,e.job,d.deptno,d.dname FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE d.loc='CHICAGO'; --ǥ��SQL
SELECT ename,job,deptno,dname FROM emp JOIN dept USING(deptno) WHERE loc='CHICAGO';


5.�ٹ���(LOC)���� �ٹ��ϴ� ����� ���� 5�� ������ ���,�ο��� ���� ���� ������ �����Ͻÿ�.(�ٹ� �ο��� 0���� ���� ǥ��)
SELECT d.loc,COUNT(e.empno) emp_member FROM emp e,dept d WHERE e.deptno(+)=d.deptno GROUP BY d.loc HAVING COUNT(e.empno)<=5 ORDER BY emp_member; --����Ŭ����

SELECT d.loc,COUNT(e.empno) emp_member FROM emp e RIGHT OUTER JOIN dept d ON e.deptno=d.deptno GROUP BY d.loc HAVING COUNT(e.empno)<=5 ORDER BY emp_member; --ǥ��SQL
SELECT loc,COUNT(empno) emp_member FROM emp RIGHT OUTER JOIN dept USING(deptno) GROUP BY loc HAVING COUNT(empno)<=5 ORDER BY emp_member;

6.����� �̸� �� ��� ��ȣ�� �������� �̸��� ������ ��ȣ�� �Բ� ǥ���ϰ� ������ �� ���̺��� employee,emp#,manager,mgr#�� �����Ͻÿ�.(�����ڰ� ���� ��� �����)
SELECT e.ename "employee",e.empno "emp#",m.ename "manager",e.mgr "mgr#" FROM emp e, emp m WHERE m.empno=e.mgr; --����Ŭ����

SELECT e.ename "employee",e.empno "emp#",m.ename "manager",e.mgr "mgr#" FROM emp e INNER JOIN emp m ON m.empno=e.mgr; --ǥ��SQL

7.�����ں��� ���� �Ի��� ��� ����� �̸�, ��� �Ի���, �������� �̸�, ������ �Ի��ϰ� �Բ� ǥ���ϰ� �� ���̺��� ���� employee,emp hired,manager,mgr hired�� �����Ͻÿ�.
SELECT e.ename "employee",e.hiredate "emp hired",m.ename "manager",m.hiredate "mgr hired" FROM emp e,emp m WHERE m.empno=e.mgr AND e.hiredate<m.hiredate; --����Ŭ����

SELECT e.ename "employee",e.hiredate "emp hired",m.ename "manager",m.hiredate "mgr hired" FROM emp e JOIN emp m ON e.mgr=m.empno WHERE e.hiredate<m.hiredate; --ǥ��SQL

8.����� �̸� �� �����ȣ�� �������� �̸��� ������ ��ȣ�� �Բ� ǥ���ϰ� ������ �� ���̺��� employee,emp#,manager,mgr#�� �����ϴµ� King�� �����Ͽ� �����ڰ� ���� ��� ����� ǥ���ϰ� ����� �����ȣ�� �������� �����Ͻÿ�.
SELECT e.ename "employee",e.empno "emp#",m.ename "manager",m.empno "mgr#" FROM emp e, emp m WHERE e.mgr=m.empno(+) ORDER BY e.empno; --����Ŭ����

SELECT e.ename "employee",e.empno "emp#",m.ename "manager",m.empno "mgr#" FROM emp e LEFT OUTER JOIN emp m ON e.mgr=m.empno ORDER BY e.empno;--ǥ��SQL

9.Ŀ�̼��� å���� ������� �����ȣ,�̸�,����,�޿�+Ŀ�̼�,�޿����,�μ����� ����ϴµ� ������ �÷����� "�����ȣ","����̸�","����","�Ǳ޿�","�޿����","�μ���"���� ����Ͻÿ�.
  ��,Ŀ�̼��� NULL�� ���� �����ϰ� ���(emp,dept,salgrade)
SELECT e.empno �����ȣ,e.ename ����̸�,e.sal*12 ����,e.sal+e.comm �Ǳ޿�,s.grade �޿����,d.dname �μ���
FROM emp e,dept d,salgrade s 
WHERE e.deptno=d.deptno AND e.sal BETWEEN s.losal AND s.hisal AND e.comm IS NOT NULL; --����Ŭ���� --JOIN ������ �޿�,�Ǳ޿��� �����϶�� ���� ������ ���� 

SELECT e.empno �����ȣ,e.ename ����̸�,e.sal*12 ����,e.sal+e.comm �Ǳ޿�,s.grade �޿����,d.dname �μ��� --ǥ��SQL
FROM emp e JOIN dept d ON e.deptno=d.deptno JOIN salgrade s 
ON e.sal BETWEEN s.losal AND s.hisal WHERE e.comm IS NOT NULL;
-- 3���̺� JOIN�� JOIN ON + JOIN ON�������� �ؾ���



���տ�����

UNION : ������, �ߺ��� ����. �� ���̺��� ������ ��Ÿ����, ���ս�Ű�� �� ���̺��� �ߺ����� ���� ������ ��ȯ

SELECT deptno FROM emp
UNION
SELECT deptno FROM dept;

UNION ALL : UNION�� ������ �� ���̺��� �ߺ��Ǵ� ������ ��ȯ

SELECT deptno FROM emp
UNION ALL
SELECT deptno FROM dept;


INTERSECT : ������, ������ ���� �� ����� ���� ��ȣ��

SELECT deptno FROM emp
INTERSECT
SELECT deptno FROM dept;


MINUS : ������, ù��° SELECT ���� ���� ��ȯ�Ǵ� �� �߿��� �ι�° SELECT ���� ���� ��ȯ�Ǵ� �࿡ �������� �ʴ� ����� ������

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;


**(�߿�)
SUBQUERY : �ϳ��� SQL ������ ���� NESTED�� SELECT����

������ �������� : ���� �� ���� ��(��)�� ��ȯ

�����ȣ�� 7369�� ����� ���� ������ ���� ����� �����ȣ,�̸��� ���
SELECT job FROM emp WHERE empno=7369;
SELECT empno,ename job FROM emp WHERE job = 'CLERK'; -- �ι� �ؾ���. �Ʒ�ó�� ���ٷ� ����

SELECT empno,ename job FROM emp WHERE job = (SELECT  job FROM emp WHERE empno=7369); --��������, ()�� =�� ����Ǿ��ֱ� ������ �ϳ��� ��, �ϳ��� �÷��̿��� �Ѵ�.

SELECT empno,ename,sal FROM emp WHERE sal = (SELECT sal FROM emp WHERE ename='MARTIN'); --�̸��� MARTIN�� ����� ���� ������ �޴� ����� ���, MARTIN�̶�� �ߺ����� ��� ����. �ߺ����� ������ �����ؾ���


������ �������� : �ϳ� �̻��� ���� ��ȯ�ϴ� ��������

IN ������ ���
�μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� ����� ������ ���
SELECT empno,ename,sal,deptno FROM emp WHERE sal IN (SELECT MIN(sal) FROM emp GROUP BY deptno); 


ANY(SOME) �������� ���
ANY �����ڴ� ���������� ����� �� ��� �ϳ��� ���̶� ������ �Ǹ� ������� ��ȯ(OR�� ����)

SELECT sal FROM emp WHERE job='SALESMAN';
SELECT ename,sal FROM emp WHERE sal>1600 OR sal>1250 OR sal>1500;  --���ǿ� �ش��ϴ� ���� ��� ��ȯ

���������� ǥ��
SELECT ename,sal FROM emp WHERE sal> ANY(SELECT sal FROM emp WHERE job='SALESMAN');


ALL �������� ���
���� ������ ����� ��� ���� ��ġ(AND�� ����)

SELECT sal FROM emp WHERE deptno=20;
SELECT empno,ename,sal,deptno FROM emp WHERE sal>800 AND sal>2975 AND sal>3000;

���� ������ ǥ��
SELECT empno,ename,sal,deptno FROM emp WHERE sal>ALL(SELECT sal FROM emp WHERE deptno=20);


���߿� ���� ����
���� ������ ����� �� �� �̻��� �÷����� ��ȯ�Ǿ� ���� ������ �����ϴ� ����

SELECT empno,ename,sal,deptno FROM Emp WHERE (deptno,sal) IN(SELECT deptno,sal FROM emp WHERE deptno=30); --���� �� �÷��� ������ ���ƾ� ��

�μ����� ���� �޿��� ���� �޴� ����� ������ ���
SELECT empno,ename,sal,deptno FROM emp WHERE (deptno,sal) IN (SELECT deptno,MIN(sal) FROM emp GROUP BY deptno);

�ζ��κ� : ���� ������ FROM���� ���� ������ �̿��ϴ� ���
--()������ ���̺� ������ ��
�޿��� 20�� �μ��� ��� �޿����� ���� �޿��� �޴� ����� �����ȣ,�̸�,�μ��� ���
SELECT e.empno,e.ename,d.dname
FROM (SELECT * FROM emp WHERE sal>(SELECT AVG(sal) FROM emp WHERE deptno=20)) e JOIN dept d
USING(deptno);

SELECT e.empno,e.ename,d.dname FROM emp e JOIN dept d
USING(deptno) WHERE sal>(SELECT AVG(sal) FROM emp WHERE deptno=20);

�μ����� �μ���ȣ,�μ���,�޿��Ѿ��� ����Ͻÿ�.
SELECT deptno,dname,total 
FROM dept JOIN (SELECT deptno,SUM(sal) total FROM emp GROUP BY deptno)
USING(deptno);


��Į�� ���� ����
*��Į���̶� ���Ͱ��� �����Ǵ� ���� ���� ���� �ǹ���
������� ���� ��, ���� ���� ��Į������ ��ȯ�ȴ�. ���� ������� ���� ���̰ų� ���߿��̶�� DBMS�� �� �� ��� ��, ��� ���� ����ؾ� �ϴ� �� �� �� ���� ������ ���.

��Į�� ���� ���� ����
SELECT deptno, (SELECT dname FROM dept WHERE deptno=e.deptno),SUM(sal)
FROM emp e GROUP BY deptno;

[�ǽ�����]
1."BLAKE"�� ���� �μ��� �ִ� ������� �̸��� �Ի����� ���ϴµ� "BLAKE"�� �����ϰ� ����Ͻÿ�.
SELECT ename,hiredate FROM emp 
WHERE deptno=(SELECT deptno FROM emp WHERE ename='BLAKE')
AND ename!='BLAKE';

BLACK�� �������� �� ����
SELECT ename,hiredate FROM emp 
WHERE deptno IN(SELECT deptno FROM emp WHERE ename='BLAKE') --IN����ؾ���
AND ename!='BLAKE';

2.��ձ޿����� ���� �޿��� �޴� ������� �����ȣ,�̸�,������ ����ϴµ� ������ ���� ��������� ����Ͻÿ�.
SELECT empno,ename,sal FROM emp WHERE sal>(SELECT AVG(sal) FROM emp) ORDER BY sal desc;

3.10���μ����� �޿��� ���� ���� �޴� ����� ������ �޿��� �޴� ����� �̸��� ������ ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE sal=(SELECT MIN(sal) FROM emp WHERE deptno=10); 

4.(�μ��� ������� ���ϰ�) ������� 3�������� �μ��� �μ���� ������� ����Ͻÿ�.
--join
SELECT d.dname,COUNT(e.empno) cnt FROM emp e,dept d 
WHERE e.deptno(+)=d.deptno GROUP BY d.dname HAVING COUNT(e.empno)<=3;

--��������
SELECT a.dname,NVL(b.cnt,0) FROM dept a,(SELECT deptno,COUNT(empno) cnt FROM emp GROUP BY deptno) b  --NVL : null�� ���� ����
WHERE a.deptno=b.deptno(+) AND NVL(b.cnt,0)<=3;

5.�����ȣ�� 7844�� ������� ���� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename,hiredate FROM emp
WHERE hiredate<(SELECT hiredate FROM emp WHERE empno=7844);

6.���ӻ��(mgr)�� KING�� ��� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT ename,sal FROM emp 
WHERE mgr IN(SELECT empno FROM emp WHERE ename='KING');

7.20���μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� ����� �̸��� �μ���,�޿�,�޿������ ����Ͻÿ�.
SELECT e.ename,d.dname,sal,s.grade FROM emp e,dept d, salgrade s 
WHERE e.deptno=d.deptno AND e.sal BETWEEN s.losal AND s.hisal 
AND e.sal=(SELECT MAX(sal) FROM emp WHERE deptno=20);

8.�ѱ޿�(sal+comm)�� ��� �޿����� ���� �޿��� �޴� ����� �μ���ȣ,�̸�,�ѱ޿�,Ŀ�̼��� ����Ͻÿ�.(Ŀ�̼��� ��(o),��(x)�� ǥ���ϰ� �÷����� "comm����"�� ���)
SELECT deptno,ename,sal+NVL(comm,0) �ѱ޿�,NVL2(comm,'O','X') comm���� FROM emp WHERE sal+NVL(comm,0)>(SELECT AVG(sal) FROM emp);

SELECT deptno,ename,sal+NVL(comm,0) �ѱ޿�,
       CASE WHEN comm IS NOT NULL THEN 'O'
       ELSE 'X'
       END As COMM����
FROM emp
WHERE sal+NVL(comm,0)>(SELECT AVG(sal) FROM emp);

9.CHICAGO �������� �ٹ��ϴ� ����� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿�,�������� ����Ͻÿ�.
SELECT e.ename,e.sal,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno 
AND sal>(SELECT AVG(sal) FROM emp e,dept d WHERE e.deptno=d.deptno AND d.loc='CHICAGO');

10.Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿������ ����Ͻÿ�.
SELECT e.ename,s.grade FROM emp e, salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE comm IS NOT NULL);



INSERT�� : ���̺� ���� ����

��ü ������ ����[��ü �÷� ���]
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (8000,'DENNIS','SALESMAN',7698,'99/01/22',1700,200,30);

��ü ������ ����[�÷��� ���� ����]
INSERT INTO emp VALUES (8001,'SUNNY','SALESMAN',7698,'99/03/01',1000,300,30);

NULL ���� ���[���� �Էµ��� �ʴ� �÷��� ����] --�÷��� �ʼ�
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,deptno) --comm����
VALUES (8002,'PETER','CLERK',7698,'99/05/01',1500,20);

NULL ���� ���[���� �Էµ��� �ʴ� �÷��� �������� ���� ���]
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (8003,'ANNIE','CLERK',7698,'99/06/01',1300,null,10);

��¥�� ����
INSERT INTO emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (8004,'MICHAEL','CLERK',7698,TO_DATE('99/07/01','YY/MM/DD'),1800,null,30); --�� �� ����


UPDATE�� : �� ������ ������ ����

UPDATE emp SET mgr=7900 WHERE empno=8000; --empno:primary key�� �ȹٲ�
UPDATE emp SET ename='MARIA',sal=2500,comm=500 WHERE empno=8000; --������ �κи� ����

[����]WHERE���� ������� ������ ��ü���� �����Ͱ� ����
UPDATE emp SET ename='BLUE';
--ROLLBACK; ����Ͽ� �����Ⱑ��, but �ڹٿ��� �� ��� ROLLBACK �Ұ�. DDL,DML���� ���� �������� �ǵ����� ����

DELETE�� : ���� ����

DELETE FROM emp WHERE empno=8004;

WHERE���� ������� ������ ��ü�� ����
DELETE FROM emp;


Ʈ����� : ������ ó���� �� ����. Ʈ������� �����͸� �ϰ��ǰ� �����ϴ� DML �������� ������

1)Ʈ����� ���� : ���� ������ SQL������ ���� ó�� ����� ��
2)Ʈ����� �� : COMMIT �̳� ROLLBACK,
               DDL �̳� DCL ������ ����(�ڵ� COMMIT)
               ��� ��� �Ǵ� �ý��� �浹
3)COMMIT�� ROLLBACK�� ����
1.�������� �ϰ����� ����
2.�����͸� ���������� �����ϱ� ���� ������ ������ Ȯ���ϰ� ��
3.���õ� �۾��� �������� �׷�ȭ ��
4.COMMIT,ROLLBACK �������� Ʈ������� ���� ����


�����ͺ��̽� ��ü

���̺� : �⺻���� ������ ���� ����, ���ڵ�� �÷� ����
����Ŭ �����ͺ��̽��� ���̺� : ����� ���̺�,������ ��ųʸ��� ����

- ����ڰ� ������ ���̺��� �̸�
SELECT table_name FROM user_tables;

- ����ڰ� ������ ���� ��ü ����
SELECT DISTINCT object_type FROM user_objects;

- ����ڰ� ������ ���̺�,��,���Ǿ� �� ������
SELECT * FROM user_catalog;

���̺��� ����
- ���̺� �̸� : ������� ���̺��� �̸�
- �� �̸� : ���̺� ���� ������� ���� �̸�
- ������ Ÿ�� : ������ ���� �ڽ��� ������ Ÿ��
- default <ǥ����> : INSERT ������ ���� ���� �������� ���� ��쿡 �̿�� ����Ʈ �� ����
- �������� : ������� �� ���� ���������� ��������������

���̺� ����
CREATE TABLE employee(
 empno number(6),
 name varchar2(30) not null,
 salary number(8,2), --����8�ڸ�,�Ҽ���2�ڸ�
 hire_date date default SYSDATE,
 CONSTRAINT employee_pk primary key (empno) 
);

INSERT INTO employee (empno,name,salary) VALUES (100,'ȫ�浿',1000.23);
COMMIT;
SELECT * FROM employee;


-PRIMARY KEY & FOREIGN KEY

CREATE TABLE suser(
 id varchar2(20),
 name varchar2(30),
 CONSTRAINT suser_pk primary key (id)
);

CREATE TABLE sboard(
 num number,
 id varchar(20) not null,
 content varchar2(4000) not null,
 CONSTRAINT sboard_pk primary key (num),
 CONSTRAINT sboard_fk foreign key (id) references suser (id)
);

INSERT INTO suser (id,name) VALUES ('SKY','ȫ�浿');
INSERT INTO suser (id,name) VALUES ('BLUE','�ڹ���');
INSERT INTO suser (id,name) VALUES ('ONE','�念��');
COMMIT;

SELECT * FROM suser;

INSERT INTO sboard (num,id,content) VALUES (1,'SKY','����');
INSERT INTO sboard (num,id,content) VALUES (2,'BLUE','ȣȣ');
INSERT INTO sboard (num,id,content) VALUES (3,'ONE','ũũ');
COMMIT;

SELECT *FROM sboard;

FOREIGN KEY ���������� ����Ǿ �ڽ� �����Ͱ� ���� ��� �θ� ������ ���� �Ұ�
DELETE FROM suser WHERE id='SKY'; --�ڽĵ����Ͱ� �־ �θ������� SKY�� ������



���̺� ����

ADD������ : ���̺� ���ο� �÷� �߰�
ALTER TABLE employee ADD (addr varchar2(50));

���� ���� �߰�
ALTER TABLE employee ADD CONSTRAINT employee_pk primary key (empno); --�̹��־ ����. ���� ��� �̷��� �߰�

MODIFY������ : ���̺��� Į���� �����ϰų� NOT NULL �÷����� ������ �� ����
ALTER TABLE employee MODIFY (salary number(10,2) not null);

DROP������ : �÷��� ����
ALTER TABLE employee DROP COLUMN name;

�÷��� ����
ALTER TABLE employee RENAME COLUMN salary TO sal;

���̺�� ����
RENAME employee TO employee2;

���̺� ����
DROP TABLE employee2;

ON DELETE CASCADE : �θ� ���̺��� �÷��� �����ϸ� �ڽ� ���̺��� �ڽ� �����͸� ��� ����

CREATE TABLE s_member(
 id varchar2(20) primary key,
 name varchar2(30)
);

CREATE TABLE s_member_detail(
 num number primary key,
 content varchar2(4000) not null,
 id varchar2(20) not null references s_member (id) ON DELETE CASCADE
);

INSERT INTO s_member (id,name) VALUES ('SKY','ȫ�浿');
INSERT INTO s_member (id,name) VALUES ('BLUE','�ڹ���');
INSERT INTO s_member (id,name) VALUES ('ONE','�念��');
COMMIT;

INSERT INTO s_member_detail (num,content,id) VALUES (1,'����','SKY');
INSERT INTO s_member_detail (num,content,id) VALUES (2,'ȣȣ','SKY');
INSERT INTO s_member_detail (num,content,id) VALUES (3,'ũũ','SKY');
COMMIT;

SELECT * FROM s_member;
SELECT * FROM s_member_detail;

ON DELETE CASCADE�� ������ ���̺��� �θ� �����͸� �����ϸ� �ڽ� �����͸� �Բ� ������
DELETE FROM s_member WHERE id='SKY';

[�ǽ�����]
1.student��� �̸����� ���̺� ����
�÷���     id           name         age       score
������Ÿ�� varchar2(10) varchar2(30) number(3) number(3)
��������   primary key  not null     not null  not null

CREATE TABLE student(
 id varchar2(10) primary key,
 name varchar2(30) not null,
 age number(3) not null,
 score number(3) not null
);

2. ������ �Է�
id      name   age   score
dragon  ȫ�浿  21    100       
sky     �念��  22    99
blue    �ڹ���  34    88

INSERT INTO student(id,name,age,score) VALUES ('dragon','ȫ�浿',21,100);
INSERT INTO student(id,name,age,score) VALUES ('sky','�念��',22,99);
INSERT INTO student(id,name,age,score) VALUES ('blue','�ڹ���',34,88);
COMMIT;

3.������ �б�
student ���̺��� ���� �հ踦 ���Ͻÿ�.
SELECT SUM(score) FROM student;

[�ǽ�����]
1.SMITH�� ���ӻ��(mgr)�� �̸��� �μ���,�ٹ������� ����Ͻÿ�.
SELECT e.ename,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno 
AND mgr IN(SELECT mgr FROM emp WHERE ename='SMITH');

SELECT e.ename,d.dname,d.loc FROM emp e JOIN dept d USING(deptno)
WHERE e.empno IN(SELECT mgr FROM emp WHERE ename='SMITH');

2.ALLEN���� �޿��� ���� �޴� ��� �߿��� �Ի����� ���� ���� ����� ������ ��¥�� �Ի��� ����� �Ի���,�޿��� ����Ͻÿ�
SELECT ename,hiredate,sal FROM emp 
WHERE hiredate=(SELECT MIN(hiredate) FROM emp 
                WHERE sal>all(SELECT sal FROM emp WHERE ename='ALLEN'));
 

3.10�� �μ����� �ٹ��ϴ� ������� �μ���ȣ,�μ��̸�,����̸�,����,�޿������ ����Ͻÿ�.
[ORACLE ����]
SELECT e.deptno,d.dname,e.ename,e.sal,s.grade 
FROM emp e,dept d,salgrade s 
WHERE e.deptno=d.deptno 
AND e.sal BETWEEN s.losal AND s.hisal 
AND e.deptno=10;

[ǥ��SQL]
SELECT e.deptno,d.dname,e.ename,e.sal,s.grade 
FROM emp e INNER JOIN dept d --INNER �������� 
ON e.deptno=d.deptno
INNER JOIN salgrade s 
ON e.sal BETWEEN s.losal AND s.hisal 
WHERE e.deptno=10;



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

[����]������ ���ӵ� ���¿����� ������ �Ұ�����
SQL> DROP USER user02; --���̺� ������ �־ ���� �Ұ�

USER02 ������ ��ü�� �����ϰ� ���� ��쿡�� CASCADE �ɼ��� �߰��ؼ� ����
SQL> drop user user02 CASCADE;




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












