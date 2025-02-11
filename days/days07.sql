��Ű��
��Ű���� ������ ���õ� Stored Procedure �� Stored Function�� �����ϰ�, �̸� ��Ű�� ������ ������ �������ϰ� ����.

����� ����

create or replace
package employee_pkg as
 procedure print_ename(p_empno number);
 procedure print_sal(p_empno number);
end employee_pkg;


���� ����

create or replace
package body employee_pkg as
 procedure print_ename(p_empno number)
 is
  l_ename emp.ename%type;
 begin
  SELECT ename INTO l_ename
  FROM emp WHERE empno=p_empno;
  dbms_output.put_line(l_ename);
 end print_ename;
 
 procedure print_sal(p_empno number)
 is
  l_sal emp.sal%type;
 begin
  SELECT sal INTO l_sal
  FROM emp WHERE empno=p_empno;
  dbms_output.put_line(l_sal);
 end print_sal;
end employee_pkg;

exec employee_pkg.print_ename(7369);
exec employee_pkg.print_Sal(7369);



Ʈ����(Trigger)
Ʈ���Ŵ� �������� ����(INSERT,DELETE,UPDATE)���� ����� �� �ڵ����� ���� ����Ǵ� ���ν����� ����.
����Ŭ�� �⺻������ ������ before �� ���� �� after Ʈ���Ÿ� ������.

Ʈ���� ����
CREATE OR REPLACE TRIGGER Ʈ���� �̸�
TIMING[before|after] even [insert|update|delete] on ���̺� �̸�                  --'|'�� �Ǵ��� ����
begin
end;


Ʈ���� ����

create or replace trigger print_message
after insert on dept
begin
 dbms_output.put_line('DEPT ���̺� ���������� �����Ͱ� �߰��Ǿ����ϴ�.');
end;

Ʈ���Ÿ� ������ �� DEPT ���̺� �����͸� �߰��ϸ� ��ϵ� Ʈ���Ű� �����ϸ鼭 'DEPT ���̺� ���������� �����Ͱ� �߰��Ǿ����ϴ�.'�� �����

INSERT INTO dept VALUES (70,'EDUCATION','BUSAN');
COMMIT;






