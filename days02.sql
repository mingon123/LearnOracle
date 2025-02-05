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

�Լ� ��ø ����
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
SELECT TO_CHAR(1234,'L0000') FROM dual; --$���ܴ� �ý����� ���ڸ� ������ ��ȭǥ��

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

SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp; --���� �׷��Լ��� �ϳ��� ������ ���� ����
SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp WHERE deptno = 10;
SELECT COUNT(*) FROM emp WHERE deptno=20; --�������� �� �� ����
SELECT COUNT(empno) FROM emp WHERE deptno=30; --null���� �ִ� �÷��� ����� �ȳ���


GROUP BY & HAVING

SELECT���� �����Լ� ����� ���� �÷��� ������ �� ����.
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






