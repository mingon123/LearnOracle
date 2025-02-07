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



































































