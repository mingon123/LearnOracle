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








