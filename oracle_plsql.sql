--PL/SQL : ���ǹ�,�ݺ���,������ ��� ���� �� ��� + SQL ��� ����
--[����]�����Ϸ��� ���� ���� �� �����ؾ���

PL/SQL�� Procedural language extension to Structured Query Language(SQL)�� ����, SQL�� Ȯ���� ������ ó�� ���

PL/SQL�� �⺻ ������ ���(block)
1)�����(declarative part) : ����� ������ ����� ����(����ο��� ������ ��� ���� ����)
2)�����(executable part) : ���� ó���� ������ ����ϴ� �κ�
3)����ó����(eception-building part) : ����ο��� ������ ó���ϴ� �� �߻��� �� �ִ� ���� �����鿡 ���� ó��

�⺻ ����

begin
    dbms_output.put_line('Hello World');
end;

�޽��� ���
*SQL Developer���� ��� �޽��� ���
�޴�>����>DBMS���>DBMS���â���� + �������� Ŭ���ϰ� ����

���� ���

declare
 --������ ������ �� �ִ� �����
 message varchar2(100);                     --���� �ڿ� �ڷ��� �Է�
begin
 --����ο��� ������ ������ ���� ����
 message := 'Hello World';                  --:=�� �Է�(����) =�� �񱳿�����
 dbms_output.put_line(message);
end;

declare
 message varchar2(100) := 'HELLO ORACLE';   --����ο��� �ٷ� �Է� ����
begin
 dbms_output.put_line(message);
end;

declare
 counter integer;                           --�ʱ�ȭ���ϸ� null�� �ν�
begin
 counter := counter + 1;
 if counter is null then                    --null�̸� �� �� ����
    dbms_output.put_line('Result : counter is null');
 end if;
end;

������ 2�� ���
declare
 counter integer;
 i integer;
begin
 for i in 1..9 loop
    counter := 2 * i;
    dbms_output.put_line('2 * ' || i || ' = ' || counter);
 end loop;
end;

����ó����

declare
 counter integer;
begin
 counter := 10;
 counter := counter/0; --���� �߻�
 dbms_output.put_line(counter);
 exception when others then
  dbms_output.put_line('errors');
end;


--�迭(�ݷ���,��ø���̺�,�����迭). �߾����� ����, �ڷ����� �ٸ��� ����� �� ���� ����, ���ڵ带 ���� �����- �ڷ����� �޶� ��� ����
�ݷ���

varray : variable array�� ���ڷ� ���� ����(fixed number)�� ���� �迭

declare
 type varray_test is varray(3) of integer;
 varray1 varray_test; --������ ������ varray_test Ÿ�� ����
begin
 varray1 := varray_test(10,20,30);
 
 dbms_output.put_line(varray1(1));
 dbms_output.put_line(varray1(2));
 dbms_output.put_line(varray1(3));
end;


��ø ���̺� : varray�� ��������� ��ø ���̺��� ���� �ÿ� ��ü ũ�⸦ ����� �ʿ䰡 ����

declare
 type nested_test is table of varchar2(10);
 nested1 nested_test; --������ ������ nested_test Ÿ�� ���� ����
begin
 nested1 := nested_test('A','B','C','D');
 
 --QNFRK
 --NESTED1(5) := 'E'; --�ѹ� ���� ������ ũ��� �� �þ�� ����, �迭�� �Ȱ���

 dbms_output.put_line(nested1(2)); --B ���
end;


Associative array(index-by table) : �����迭�� index-by table�̶�� �ϸ� Ű�� ���� ������ ����.

declare
 type assoc_type is table of number index by pls_integer;
 assoc1 assoc_type;--������ ������ assoc_type Ÿ�� ����
begin
 assoc1(3) := 33; --key�� 3, value�� 33
 dbms_output.put_line(assoc1(3));
end;


���ڵ�
�ݷ��ǿ� �ش��ϴ� varray,��ø ���̺�,associative array�� ��� ���α׷��� ���� ����ϴ� �迭 ������ ����.
�����ϴ� ��ҵ��� ������ Ÿ���� ��� ����.
���� �ٸ� ������ ������ Ÿ������ �����ϰ� ������ ���ڵ� ���

declare
 --TYPE���� ���ڵ� ����
 type record1 is record (deptno number not null:=50, --deptno�� primary key�̹Ƿ� �ѹ� �� �����ϸ� �ߺ��Ǿ� ���� �߻�
                         dname varchar2(14),
                         loc varchar2(13));
 --������ ������ record1�� �޴� ���� ����
 rec1 record1;
begin
 rec1.dname := 'RECORD';
 rec1.loc := 'SEOUL';
 
 --rec1 ���ڵ� ���� dept ���̺� insert
 INSERT INTO dept VALUES rec1; 
 COMMIT;
 exception when others then 
  ROLLBACK;
  dbms_output.put_line('errors');
end;
--���� �߻� �� ROLLBACK(����) �ƴϸ� COMMIT

declare
 grade char(1);
begin
 grade := 'B';
 
 if grade = 'A' then
  dbms_output.put_line('EXCELLENT');
 elsif grade = 'B' then                 --[����]else if�ƴ� elsif
  dbms_output.put_line('Good');
 elsif grade = 'C' then
  dbms_output.put_line('Fair');
 elsif grade = 'D' then
  dbms_output.put_line('Poor');
 end if;                                --end if����ؼ� if�� ���������� ���� �Ȼ��� , else�� ���� ����
end;


CASE��

declare
 grade char(1);
begin
 grade := 'B';
 
 case grade 
 when 'A' then
  dbms_output.put_line('Excellent');   
 when 'B' then                 --[����]else if�ƴ� elsif
  dbms_output.put_line('Good');
 when 'C' then
  dbms_output.put_line('Fair');
 when 'D' then
  dbms_output.put_line('Poor');
 else
  dbms_output.put_line('Not Found');
 end case;                              --end case�� ����Ͽ� ��������
end;           


LOOP��
--while���� ����
declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 
 loop                               
    result_num := 2 * test_number;
    if result_num > 20 then
     exit; --��� ����
    else
     dbms_output.put_line(result_num);
    end if;
    test_number := test_number + 1; --[����]test_number�� �������� ������ ��� ���ѷ���
 end loop;
end;

�� �ڵ� �� ���̱�
declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 
 loop
  result_num := 2* test_number;
  
  exit when result_num > 20;
  
  dbms_output.put_line(result_num);
  test_number := test_number + 1;  
 end loop;
end;


WHILE-LOOP��

declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 result_num := 0;
 
 while result_num < 20 loop
  result_num := 2 * test_number;
  dbms_output.put_line(result_num);
  test_number := test_number + 1;       --���� �߰����� ������ ���ѷ���
 end loop;
end;


FOR..LOOP��

declare
 test_number integer;
 result_num integer;
begin
 for test_number in 1..10 loop
  result_num := 2 * test_number;
  dbms_output.put_line(result_num);
 end loop;
end;



































































