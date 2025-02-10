Ŀ��
SELECT ������ �����ϸ� ���ǿ� ���� ����� ����. ����� ����� ��� ��(result set) �Ǵ� �������.
Ŀ��(cursor)�� �̿��ؼ� ������տ� ����

declare
 cursor emp_csr is
 SELECT empno FROM emp WHERE deptno=10;

 emp_no emp.empno%type;
begin
 open emp_csr;
 
 loop
  fetch emp_csr into emp_no;
  --%notfound : Ŀ�������� ��� ������ �Ӽ�(�� �̻� ��ġ(�Ҵ�)�� ���� ������ �ǹ�)
  exit when emp_csr%notfound;
  
  dbms_output.put_line(emp_no);
 end loop;
 close emp_csr;
end;



PL/SQL �������α׷�

�Լ�
-- is,begin,end����

�Է¹��� �����κ��� 10%�� ������ ��� �Լ�
create or replace function tax(p_value in number)
 return number
is
begin
 return p_value * 0.1;
end;

SELECT TAX(100) FROM dual;
SELECT ename,sal,TAX(sal) tax,sal-TAX(sal) "������ �޿�" FROM emp;

�޿��� Ŀ�̼��� ���ļ� ���� ���
create or replace function tax2(p_sal in emp.sal%type,
                                p_bonus in emp.comm%type)     
 return number
is
begin
 return (p_sal + NVL(p_bonus,0)) * 0.1;
end;

SELECT empno,ename,sal,comm,sal+NVL(comm,0) �Ǳ޿�,TAX2(sal,comm) TAX FROM emp;

�޿�(Ŀ�̼� ����)�� ���� ������ ������ ���� ������.�޿��� �� $1,000���� ������ ������ 5% �����ϸ�,$1,000�̻� $2,0000���ϸ� 10%,$2,000�� �ʰ��ϸ� 20%�� ������
create or replace function tax3(p_sal in emp.sal%type,
                                p_bonus emp.comm%type)
 return number
is
 e_sum number;
 e_tax number;
begin
 e_sum := p_sal + NVL(p_bonus,0);
 
 if e_sum < 1000 then
  e_tax := e_sum * 0.05;
 elsif e_sum <= 2000 then
  e_tax := e_sum * 0.1;
 else
  e_tax := e_sum * 0.2;
 end if;
 
 return e_tax;
end;

SELECT empno,ename,sal,comm,TAX3(sal,comm) AS tax FROM emp;

�����ȣ�� ���ؼ� �޿��� �˷��ִ� �Լ�
create or replace function emp_salaries(emp_no number)
 return number
is
 nSalaries number(9);
begin
 SELECT sal
 --������� �������� ��� INTO�� �̿��ؼ� �о�� ���� ������ ���� �� ����(���� �������� ����)
 INTO nSalaries
 FROM emp
 WHERE empno=emp_no;
 
 return nSalaries;
end;

SELECT EMP_SALARIES(7839) FROM dual;
SELECT empno,ename,emp_salaries(empno) FROM emp WHERE deptno=10;

�μ���ȣ�� �����ϸ� �μ����� ���� �� �ִ� �Լ�
create or replace function get_dept_name(dept_no number)
 return varchar2 --��������X
is
 sDeptName varchar2(30);
begin
 SELECT dname INTO sDeptName
 FROM dept WHERE deptno=dept_no;
 
 return sDeptName;
end;

SELECT GET_DEPT_NAME(10) FROM dual;
SELECT deptno,GET_DEPT_NAME(deptno) "Department Name" FROM dept;
SELECT empno,ename,sal,GET_DEPT_NAME(deptno) "Department Name" FROM emp; --�Լ��� ����� join���� �ʾƵ� ��

������ �Լ� Ȯ���ϱ�
SELECT object_name,object_type FROM user_objects
WHERE object_type='FUNCTION';

[�ǽ�����]
1.�� ���ڸ� �����ϸ� ������ �ؼ� ������� ��ȯ�ϴ� �Լ�(add_num)�� �����Ͻÿ�.
create or replace function add_num(num1 integer,num2 integer) --number�� ����
 return integer
is
begin
 return num1+num2;
end;

SELECT add_num(2,5) FROM dual;
SELECT ename,ADD_NUM(sal,NVL(comm,0)) �Ǳ޿� FROM emp;

2)�μ���ȣ�� �Է��ϸ� �ش� �μ����� �ٹ��ϴ� ������� ��ȯ�ϴ� �Լ��� �����Ͻÿ�(get_emp_count)
create or replace function get_emp_count(dept_no emp.deptno%type)
 return number
is
 emp_count number;
begin
 SELECT COUNT(empno) INTO emp_count 
 FROM emp WHERE deptno=dept_no;
 return emp_count;
end;

SELECT deptno,dname,GET_EMP_COUNT(deptno) ����� FROM dept;

3)emp���̺��� �Ի����� �Է��ϸ� �ٹ������� ���ϴ� �Լ��� �����Ͻÿ�.(�Ҽ��� �ڸ� ����)(get_info_hiredate)
create or replace function get_info_hiredate(hire_date emp.hiredate%type)
 return NUMBER
is
begin
 return TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date)/12); 
end;

SELECT ename,get_info_hiredate(hiredate) FROM emp;

4)emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �ش� ����� �����ڸ� ���ϴ� �Լ��� �����Ͻÿ�.(get_mgr_name)
create or replace function get_mgr_name(emp_no emp.empno%type)
 return varchar2
is
 m_name varchar2(10);
begin
 --�������� �̿�
 SELECT ename INTO m_name 
 FROM emp WHERE empno=(SELECT mgr FROM emp WHERE empno=emp_no); 
 return m_name;
end;

--JOIN �̿�(INNER JOIN). ���� �����ʹ� null�� ��ȯ
create or replace function get_mgr_name(emp_no emp.empno%type)
 return varchar2
is
 m_name varchar2(10);
begin
 SELECT m.ename INTO m_name 
 FROM emp e JOIN emp m ON e.mgr=m.empno 
 WHERE e.empno=emp_no;
 return m_name;
end;

SELECT empno,ename,GET_MGR_NAME(empno) "������ �̸�" FROM emp;

5)emp���̺��� �̿��ؼ� �����ȣ�� �Է��ϸ� �޿� ����� ���ϴ� �Լ��� �����Ͻÿ�.(get_sal_grade)
--ǥ��SQL���
create or replace function get_sal_grade(emp_no emp.empno%type)
 return number
is
 s_grade number;
begin
 SELECT s.grade INTO s_grade
 FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
 WHERE e.empno=emp_no;
 return s_grade;
end;
--Oracle����
create or replace function get_sal_grade(emp_no emp.empno%type)
 return number
is
 sgrade number;
begin
 SELECT s.grade INTO sgrade
 FROM emp e,salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal 
 AND e.empno=emp_no;
 return sgrade;
end;

----------salgrade���̺� ���� ���
create or replace function get_sal_grade(emp_no emp.empno%type)
 return varchar
is
 sgrade char(1);
begin
 SELECT CASE WHEN sal>=4000 THEN 'A'
             WHEN sal>=3000 AND sal<4000 THEN 'B'
             WHEN sal>=2000 AND sal<3000 THEN 'C'
             WHEN sal>=1000 AND sal<2000 THEN 'D'
             ELSE 'F'
        END grade
 INTO SGRADE
 FROM emp WHERE empno=emp_no;
 return sgrade;
end;

SELECT ename,sal,GET_SaL_GRADE(empno) "�޿� ���" FROM emp; 




���ν���
--PL/SQL���� ��ȯ�ϴ� ��츸 �Լ�,��ȯ������ ���ν���
create or replace procedure hello_world
is
 message varchar2(100);
begin
 message := 'Hello World';
 dbms_output.put_line(message);
end;


���ν��� ����
EXEC Ȥ�� EXECUTE ���ν�����(�Ķ����...);

exec hello_world;

create or replace procedure hello_world(p_message in varchar2)
is
begin
 dbms_output.put_line(p_message);
end;

exec hello_world('Korea');

�ۼ��� Stored Procedure Ȯ��
SELECT object_name,object_type
FROM user_objects
WHERE object_type = 'PROCEDURE'; --��ҹ��� ����O

Stored Procedure�� Source�� ������ ������ �̿��ؼ� ����
SELECT text FROM user_source
WHERE name = 'HELLO_WORLD';





