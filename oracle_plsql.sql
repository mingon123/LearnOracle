--PL/SQL : 조건문,반복문,변수나 상수 선언 및 사용 + SQL 사용 가능
--[주의]실행하려는 구간 선택 후 실행해야함

PL/SQL은 Procedural language extension to Structured Query Language(SQL)의 약자, SQL을 확장한 순차적 처리 언어

PL/SQL의 기본 단위는 블록(block)
1)선언부(declarative part) : 사용할 변수나 상수를 선언(선언부에만 변수와 상수 선언 가능)
2)실행부(executable part) : 실제 처리할 로직을 담당하는 부분
3)예외처리부(eception-building part) : 실행부에서 로직을 처리하던 중 발생할 수 있는 각종 오류들에 대해 처리

기본 구조

begin
    dbms_output.put_line('Hello World');
end;

메시지 출력
*SQL Developer에서 결과 메시지 출력
메뉴>보기>DBMS출력>DBMS출력창에서 + 아이콘을 클릭하고 접속

변수 사용

declare
 --변수를 선언할 수 있는 선언부
 message varchar2(100);                     --변수 뒤에 자료형 입력
begin
 --선언부에서 선언한 변수에 값을 대입
 message := 'Hello World';                  --:=로 입력(삽입) =는 비교연산자
 dbms_output.put_line(message);
end;

declare
 message varchar2(100) := 'HELLO ORACLE';   --선언부에서 바로 입력 가능
begin
 dbms_output.put_line(message);
end;

declare
 counter integer;                           --초기화안하면 null로 인식
begin
 counter := counter + 1;
 if counter is null then                    --null이면 블럭 안 실행
    dbms_output.put_line('Result : counter is null');
 end if;
end;

구구단 2단 출력
declare
 counter integer;
 i integer;
begin
 for i in 1..9 loop
    counter := 2 * i;
    dbms_output.put_line('2 * ' || i || ' = ' || counter);
 end loop;
end;

예외처리부

declare
 counter integer;
begin
 counter := 10;
 counter := counter/0; --예외 발생
 dbms_output.put_line(counter);
 exception when others then
  dbms_output.put_line('errors');
end;


--배열(콜렉션,중첩테이블,연관배열). 잘쓰이진 않음, 자료형이 다르면 사용할 수 없기 때문, 레코드를 많이 사용함- 자료형이 달라도 사용 가능
콜렉션

varray : variable array의 약자로 고정 길이(fixed number)를 가진 배열

declare
 type varray_test is varray(3) of integer;
 varray1 varray_test; --위에서 선언한 varray_test 타입 변수
begin
 varray1 := varray_test(10,20,30);
 
 dbms_output.put_line(varray1(1));
 dbms_output.put_line(varray1(2));
 dbms_output.put_line(varray1(3));
end;


중첩 테이블 : varray와 흡사하지만 중첩 테이블은 선언 시에 전체 크기를 명시할 필요가 없음

declare
 type nested_test is table of varchar2(10);
 nested1 nested_test; --위에서 선언한 nested_test 타입 변수 지정
begin
 nested1 := nested_test('A','B','C','D');
 
 --QNFRK
 --NESTED1(5) := 'E'; --한번 값을 넣으면 크기는 더 늘어나지 않음, 배열과 똑같음

 dbms_output.put_line(nested1(2)); --B 출력
end;


Associative array(index-by table) : 연관배열은 index-by table이라고도 하며 키와 값의 쌍으로 구성.

declare
 type assoc_type is table of number index by pls_integer;
 assoc1 assoc_type;--위에서 선언한 assoc_type 타입 변수
begin
 assoc1(3) := 33; --key는 3, value는 33
 dbms_output.put_line(assoc1(3));
end;


레코드
콜렉션에 해당하는 varray,중첩 테이블,associative array는 모든 프로그래밍 언어에서 사용하는 배열 형태의 구조.
구성하는 요소들의 데이터 타입은 모두 같음.
서로 다른 유형의 데이터 타입으로 구성하고 싶으면 레코드 사용

declare
 --TYPE으로 레코드 선언
 type record1 is record (deptno number not null:=50, --deptno는 primary key이므로 한번 더 실행하면 중복되어 오류 발생
                         dname varchar2(14),
                         loc varchar2(13));
 --위에서 선언한 record1을 받는 변수 선언
 rec1 record1;
begin
 rec1.dname := 'RECORD';
 rec1.loc := 'SEOUL';
 
 --rec1 레코드 값을 dept 테이블에 insert
 INSERT INTO dept VALUES rec1; 
 COMMIT;
 exception when others then 
  ROLLBACK;
  dbms_output.put_line('errors');
end;
--예외 발생 시 ROLLBACK(문구) 아니면 COMMIT

declare
 grade char(1);
begin
 grade := 'B';
 
 if grade = 'A' then
  dbms_output.put_line('EXCELLENT');
 elsif grade = 'B' then                 --[주의]else if아닌 elsif
  dbms_output.put_line('Good');
 elsif grade = 'C' then
  dbms_output.put_line('Fair');
 elsif grade = 'D' then
  dbms_output.put_line('Poor');
 end if;                                --end if사용해서 if문 빠져나가야 에러 안생김 , else문 생략 가능
end;


CASE문

declare
 grade char(1);
begin
 grade := 'B';
 
 case grade 
 when 'A' then
  dbms_output.put_line('Excellent');   
 when 'B' then                 --[주의]else if아닌 elsif
  dbms_output.put_line('Good');
 when 'C' then
  dbms_output.put_line('Fair');
 when 'D' then
  dbms_output.put_line('Poor');
 else
  dbms_output.put_line('Not Found');
 end case;                              --end case를 사용하여 빠져나감
end;           


LOOP문
--while문과 같음
declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 
 loop                               
    result_num := 2 * test_number;
    if result_num > 20 then
     exit; --블록 종료
    else
     dbms_output.put_line(result_num);
    end if;
    test_number := test_number + 1; --[주의]test_number가 증가하지 않으면 계속 무한루프
 end loop;
end;

위 코드 더 줄이기
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


WHILE-LOOP문

declare
 test_number integer;
 result_num integer;
begin
 test_number := 1;
 result_num := 0;
 
 while result_num < 20 loop
  result_num := 2 * test_number;
  dbms_output.put_line(result_num);
  test_number := test_number + 1;       --값을 추가하지 않으면 무한루프
 end loop;
end;


FOR..LOOP문

declare
 test_number integer;
 result_num integer;
begin
 for test_number in 1..10 loop
  result_num := 2 * test_number;
  dbms_output.put_line(result_num);
 end loop;
end;



커서
SELECT 문장을 실행하면 조건에 따른 결과가 추출. 추출된 결과를 결과 셋(result set) 또는 결과집합.
커서(cursor)를 이용해서 결과집합에 접근

declare
 cursor emp_csr is
 SELECT empno FROM emp WHERE deptno=10;

 emp_no emp.empno%type;
begin
 open emp_csr;
 
 loop
  fetch emp_csr into emp_no;
  --%notfound : 커서에서만 사용 가능한 속성(더 이상 패치(할당)할 행이 없음을 의미)
  exit when emp_csr%notfound;
  
  dbms_output.put_line(emp_no);
 end loop;
 close emp_csr;
end;



PL/SQL 서브프로그램

함수
-- is,begin,end구조

입력받은 값으로부터 10%의 세율을 얻는 함수
create or replace function tax(p_value in number)
 return number
is
begin
 return p_value * 0.1;
end;

SELECT TAX(100) FROM dual;
SELECT ename,sal,TAX(sal) tax,sal-TAX(sal) "실지급 급여" FROM emp;

급여와 커미션을 합쳐서 세금 계산
create or replace function tax2(p_sal in emp.sal%type,
                                p_bonus in emp.comm%type)     
 return number
is
begin
 return (p_sal + NVL(p_bonus,0)) * 0.1;
end;

SELECT empno,ename,sal,comm,sal+NVL(comm,0) 실급여,TAX2(sal,comm) TAX FROM emp;

급여(커미션 포함)에 대한 세율을 다음과 같이 정의함.급여가 월 $1,000보다 적으면 세율을 5% 적용하며,$1,000이상 $2,0000이하면 10%,$2,000을 초과하면 20%를 적용함
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

사원번호를 통해서 급여를 알려주는 함수
create or replace function emp_salaries(emp_no number)
 return number
is
 nSalaries number(9);
begin
 SELECT sal
 --결과행이 단일행일 경우 INTO를 이용해서 읽어온 값을 변수에 담을 수 있음(행이 여러개면 에러)
 INTO nSalaries
 FROM emp
 WHERE empno=emp_no;
 
 return nSalaries;
end;

SELECT EMP_SALARIES(7839) FROM dual;
SELECT empno,ename,emp_salaries(empno) FROM emp WHERE deptno=10;

부서번호를 전달하면 부서명을 구할 수 있는 함수
create or replace function get_dept_name(dept_no number)
 return varchar2 --사이즈명시X
is
 sDeptName varchar2(30);
begin
 SELECT dname INTO sDeptName
 FROM dept WHERE deptno=dept_no;
 
 return sDeptName;
end;

SELECT GET_DEPT_NAME(10) FROM dual;
SELECT deptno,GET_DEPT_NAME(deptno) "Department Name" FROM dept;
SELECT empno,ename,sal,GET_DEPT_NAME(deptno) "Department Name" FROM emp; --함수를 만들면 join하지 않아도 됨

생성된 함수 확인하기
SELECT object_name,object_type FROM user_objects
WHERE object_type='FUNCTION';

[실습문제]
1.두 숫자를 제공하면 덧셈을 해서 결과값을 반환하는 함수(add_num)를 정의하시오.
create or replace function add_num(num1 integer,num2 integer) --number도 가능
 return integer
is
begin
 return num1+num2;
end;

SELECT add_num(2,5) FROM dual;
SELECT ename,ADD_NUM(sal,NVL(comm,0)) 실급여 FROM emp;

2)부서번호를 입력하면 해당 부서에서 근무하는 사원수를 반환하는 함수를 정의하시오(get_emp_count)
create or replace function get_emp_count(dept_no emp.deptno%type)
 return number
is
 emp_count number;
begin
 SELECT COUNT(empno) INTO emp_count 
 FROM emp WHERE deptno=dept_no;
 return emp_count;
end;

SELECT deptno,dname,GET_EMP_COUNT(deptno) 사원수 FROM dept;

3)emp테이블의 입사일을 입력하면 근무연차를 구하는 함수를 정의하시오.(소수점 자리 절삭)(get_info_hiredate)
create or replace function get_info_hiredate(hire_date emp.hiredate%type)
 return NUMBER
is
begin
 return TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date)/12); 
end;

SELECT ename,get_info_hiredate(hiredate) FROM emp;

4)emp테이블을 이용해서 사원번호를 입력하면 해당 사원의 관리자를 구하는 함수를 정의하시오.(get_mgr_name)
create or replace function get_mgr_name(emp_no emp.empno%type)
 return varchar2
is
 m_name varchar2(10);
begin
 --서브쿼리 이용
 SELECT ename INTO m_name 
 FROM emp WHERE empno=(SELECT mgr FROM emp WHERE empno=emp_no); 
 return m_name;
end;

--JOIN 이용(INNER JOIN). 없는 데이터는 null로 반환
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

SELECT empno,ename,GET_MGR_NAME(empno) "관리자 이름" FROM emp;

5)emp테이블을 이용해서 사원번호를 입력하면 급여 등급을 구하는 함수를 정의하시오.(get_sal_grade)
--표준SQL사용
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
--Oracle전용
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

----------salgrade테이블 없을 경우
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

SELECT ename,sal,GET_SaL_GRADE(empno) "급여 등급" FROM emp; 




프로시저
--PL/SQL에서 반환하는 경우만 함수,반환없으면 프로시저
create or replace procedure hello_world
is
 message varchar2(100);
begin
 message := 'Hello World';
 dbms_output.put_line(message);
end;


프로시저 실행
EXEC 혹은 EXECUTE 프로시저명(파라미터...);

exec hello_world;

create or replace procedure hello_world(p_message in varchar2)
is
begin
 dbms_output.put_line(p_message);
end;

exec hello_world('Korea');

작성된 Stored Procedure 확인
SELECT object_name,object_type
FROM user_objects
WHERE object_type = 'PROCEDURE'; --대소문자 구분O

Stored Procedure의 Source를 데이터 사전을 이용해서 얻음
SELECT text FROM user_source
WHERE name = 'HELLO_WORLD';




