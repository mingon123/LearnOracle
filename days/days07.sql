패키지
패키지는 업무와 관련된 Stored Procedure 및 Stored Function을 관리하고, 이를 패키지 단위로 배포할 때유용하게 사용됨.

선언부 생성

create or replace
package employee_pkg as
 procedure print_ename(p_empno number);
 procedure print_sal(p_empno number);
end employee_pkg;


본문 생성

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



트리거(Trigger)
트리거는 데이터의 변경(INSERT,DELETE,UPDATE)문이 실행될 때 자동으로 같이 실행되는 프로시저를 말함.
오라클은 기본적으로 실행전 before 과 실행 후 after 트리거를 지원함.

트리거 형식
CREATE OR REPLACE TRIGGER 트리거 이름
TIMING[before|after] even [insert|update|delete] on 테이블 이름                  --'|'는 또는의 개념
begin
end;


트리거 생성

create or replace trigger print_message
after insert on dept
begin
 dbms_output.put_line('DEPT 테이블에 정상적으로 데이터가 추가되었습니다.');
end;

트리거를 생성한 후 DEPT 테이블에 데이터를 추가하면 등록된 트리거가 동작하면서 'DEPT 테이블에 정상적으로 데이터가 추가되었습니다.'를 출력함

INSERT INTO dept VALUES (70,'EDUCATION','BUSAN');
COMMIT;






