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
������ ���� ���� ǥ�� --�Ѵ��� ���� ���� ����
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



