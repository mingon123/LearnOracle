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
SELECT SYSDATE FROM dual;

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
SELECT TO_CHAR(1234,'00000') FROM dual --01234

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
SELECT TO_CHAR(1234,'L0000') FROM dual;





