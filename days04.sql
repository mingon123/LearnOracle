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
VALUES (8004,'MICHAEL','CLERK',7698,TO_DATE('99/07/01','YY/MM/DD'),1800,null,30);


UPDATE�� : �� ������ ������ ����

UPDATE emp SET mgr=7900 WHERE empno=8000; --empno:primary key�� �ȹٲ�
UPDATE emp SET ename='MARIA',sal=2500,comm=500 WHERE empno=8000;

[����]WHERE���� ������� ������ ��ü���� �����Ͱ� ����
UPDATE emp SET ename='BLUE';


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
 salary number(8,2), --���8�ڸ�,�Ҽ���2�ڸ�
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
AND mgr IN(SELECT m.mgr FROM emp e,emp m WHERE e.mgr=m.empno 
AND e.ename='SMITH');

2.ALLEN���� �޿��� ���� �޴� ��� �߿��� �Ի����� ���� ���� ����� ������ ��¥�� �Ի��� ����� �Ի���,�޿��� ����Ͻÿ�
SELECT hiredate,sal FROM emp 
WHERE sal>(SELECT sal FROM emp WHERE ename='ALLEN') 
AND hiredate=(SELECT MIN(hiredate) FROM emp);

3.10�� �μ����� �ٹ��ϴ� ������� �μ���ȣ,�μ��̸�,����̸�,����,�޿������ ����Ͻÿ�.
[ORACLE ����]
SELECT e.deptno,d.dname,e.ename,e.sal,s.grade FROM emp e,dept d,salgrade s 
WHERE e.deptno=d.deptno AND e.sal BETWEEN s.losal AND s.hisal 
AND e.deptno=10;

[ǥ��SQL]














