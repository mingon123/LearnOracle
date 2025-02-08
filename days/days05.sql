뷰(VIEW) : 논리적으로 하나 이상의 테이블에 있는 데이터의 부분 집합

뷰 사용 목적
1)데이터 액세스를 제한하기 위해
2)복잡한 질의를 쉽게 작성하기 위해
3)데이터 독립성을 제공하기 위해
4)동일한 데이터로부터 다양한 결과를 얻기 위해
--sal,comm등을 가리고 싶을 때 사용(보안에 안전)

CREATE OR REPLACE VIEW emp10_view
AS SELECT empno id_number,ename name,sal*12 ann_salary
   FROM emp WHERE deptno=10;

SELECT * FROM emp10_view;

CREATE OR REPLACE VIEW emp_info_view 
AS SELECT e.empno,e.ename,d.deptno,d.loc,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno;

SELECT * FROM emp_info_view; --조인을 계속할 때(복잡한 코드 반복할 때) 뷰를 사용해서 편하게 가져옴

view를 통한 데이터 변경하기 --권장X
일반적으로 view는 조회용으로 많이 사용되지만 아래와 같이 데이터를 변경할 수 있음
UPDATE emp10_view SET name='SCOTT' WHERE id_number=7839;
SELECT * FROM emp10_view; --view를 변경해도 emp도 연동되어 같이 변경됨
SELECT * FROM emp; --emp테이블의 KING->SCOTT 변경됨

INSERT INTO emp10_view (id_number,name,ann_salary) VALUES (8000,'JOHN',19000);
--가상 열은 사용할 수 없음(오류발생), 추가 불가

INSERT INTO emp10_view (id_number,name) VALUES (8000,'JOHN'); --추가 가능
--가상 열을 제외하면 삽입 가능
SELECT * FROM emp10_view; --등록된 데이터의 deptno가 null이기 때문에 표시 불가 , 10번테이블만 읽어오는 것이기 때문에 JOHN이 안나옴(주의)
SELECT * FROM emp; --테이블에서는 등록된 데이터 확인 가능

ROLLBACK;

WITH CHECK OPTION : 조건 컬럼값을 변경하지 못하게 하는 옵션

REATE OR REPLACE VIEW emp30_view AS
SELECT empno,ename,deptno FROM emp WHERE deptno=30
WITH CHECK OPTION;

SELECT * FROM emp30_view;

UPDATE emp30_view SET deptno=10 WHERE empno=7499;
--뷰의 WITH CHECK OPTION의 조건에 위배됨. (WHERE deptno=30로 지정되어 있어 deptno 변경 불가능)

UPDATE emp30_view SET ename='MARIA' WHERE empno=7499; --deptno를 제외한 나머지는 수정 가능

SELECT * FROM emp30_view;

ROLLBACK;

WITH READ ONLY : 읽기 전용 뷰를 생성하는 옵션

CREATE OR REPLACE VIEW emp20_view AS
SELECT empno id_number,ename name,sal*12 ann_salary FROM emp WHERE deptno=20
WITH READ ONLY;

SELECT * FROM emp20_view;

UPDATE emp20_view SET name='DAVID' WHERE id_number=7902; --READ ONLY이기 때문에 수정 불가


뷰 삭제
DROP VIEW emp10_view;



시퀀스(SEQUENCE) : 유일한 값을 생성해주는 오라클 객체

CREATE SEQUENCE test_seq
start with 1
increment by 1
maxvalue 100000;

시작 값이 1이고 1씩 증가하고, 최대값이 100000

currval : 현재 값을 반환
nextval : 현재 시퀀스 값의 다음 값 반환

--값 확인
SELECT test_seq.nextval FROM dual; --시퀀스 값 생성 및 조회
SELECT test_seq.currval FROM dual; --시퀀스 값 조회, nextval없이 currval은 오류 



인덱스(INDEX) : 인덱스는 데이터 검색을 빨리 하기 위해 사용한다.
               테이블의 컬럼에 대한 제약 조건을 설정할 때 Primary Key, Unique 로 설정하면 Oracle은 자동으로 이 컬럼에 대해 Unique Index 설정
               
인덱스 만들기
자동 : 테이블 정의에 Primary Key 또는 Unique 제약 조건을 정의하면 고유 인덱스가 자동으로 생성
수동 : 사용자가 열에 고유하지 않은 인덱스를 생성하여 행에 대한 액세스 시간을 줄일 수 있음

UNIQUE INDEX : 유일한 값을 가지는 컬럼에 인덱스 설정
CREATE UNIQUE INDEX dname_idx ON dept(dname);

NON UNIQUE INDEX : 유일한 값을 가지지 않는 컬럼에 인덱스 설정
CREATE INDEX deptno_idx ON emp(deptno);

인덱스 생성이 필요한 경우
1)열에 광범위한 값이 포함된 경우
2)열에 널 값이 많이 포함된 경우
3)WHERE 절 또는 조인 조건에서 하나 이상의 열이 함께 자주 사용되는 경우

인덱스를 생성하지 않아야 할 경우
1)테이블이 작은 경우
2)열이 질의의 조건으로 자주 사용되지 않는 경우
3)테이블이 자주 갱신되는 경우



동의어 : 객체의 다른 이름. 객체 액세스를 단순화
1)다른 사용자가 소유한 테이블을 쉽게 참조
2)긴 객체 이름 짧게 만듦

CREATE SYNONYM emp20
FOR emp20_view;

SELECT * FROM emp20; --EMP20_VIEW 단순 호출

DROP SYNONYM emp20;


권한

관리자 계정과 사용자 계정

관리자 계정의 역할 : 데이터베이스의 생성과 관리를 담당하는 슈퍼유저 계정이며 데이터베이스 객체의 생성,변경,삭제 등의 작업이 가능
사용자 계정의 역할 : 사용자 계정은 데이터베이스에 접근하여 데이터를 조작(삽입,삭제,수정,검색)하고 관리하는 일을 수행


사용자 생성
[오라클 11버전]
RUN SQL Command Line 선택

SQL>conn sys/1234(비밀번호) as sysdba;
SQL>create user user02 identified by 1234(비밀번호); <-- 계정 생성
SQL>GRANT resource,connect To user02; <-- 접속 권한 부여

비밀번호(암호) 변경
SQL> conn sys/1234 as sysdba
SQL> ALTER USER user02 identified by 5678;


사용자 삭제

[주의]계정이 접속된 상태에서는 삭제가 불가능함
SQL> DROP USER user02; --테이블에 내용이 있어서 삭제 불가

USER02 유저가 객체를 소유하고 있을 경우에는 CASCADE 옵션을 추가해서 삭제
SQL> drop user user02 CASCADE;







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
 
 --불가
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



[숙제]내가 문제 만들고 풀어보기
JOIN 3문제
1.업무가 SALESMAN인 사원번호,사원이름,부서명,지역 출력
SELECT e.empno,e.ename,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.job='SALESMAN';

2.관리자보다 월급이 많은 사원의 이름,급여,커미션 출력
SELECT e.ename,e.sal,NVL(e.comm,0) comm1 FROM emp e,emp m WHERE e.mgr=m.empno AND e.sal>m.sal;

3.연봉((sal+comm)*12)이 가장 적은 사원의 사원이름,업무,월급,커미션,연봉,등급 출력
SELECT e.ename,e.job,NVL(e.comm,0) 커미션,(e.sal+NVL(e.comm,0))*12 연봉, s.grade
FROM emp e,salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal
AND (e.sal+NVL(e.comm,0))*12=(SELECT MIN((sal+NVL(comm,0))*12) FROM emp);


서브쿼리 3문제
1.가장 높은 월급을 받는 사람의 사원번호,이름 출력
SELECT empno,ename FROM emp WHERE sal=(SELECT MAX(sal) FROM emp);

2.부서별 급여가 평균이상인 사람의 수를 출력
SELECT COUNT(*) FROM emp WHERE sal>=(SELECT AVG(sal) FROM emp);

3.월급이 가장 낮은 사람과 입사일이 같은 사람을 출력
SELECT empno,ename,hiredate,sal FROM emp WHERE sal=(SELECT MIN(sal) FROM emp);




