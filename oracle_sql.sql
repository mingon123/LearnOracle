데이터베이스(Database) : 지속적으로 저장되는 연관된 정보의 모음

SQL(Standard Query Language) : SQL은 데이터베이스에서 데이터를 검색,삽입,갱신,삭제할 수 있는 표준 언어

SELECT문 : 데이터베이스로부터 저장되어 있는 데이터를 검색하는데 사용

전체 테이블 명세
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno FROM emp;
SELECT * FROM emp; -- *은 모든 컬럼을 의미함

특정 열 선택
SELECT ename,job,sal FROM emp;

주석
SELECT * /*주석*/ FROM emp; --주석     sql문 안에서는 /* */, 밖에서는 --사용

dual : 함수 및 계산의 결과를 볼 때 사용할 수 있는 공용(Public) 테이블
SELECT SYSDATE FROM dual;
SELECT 7 + 10 FROM dual;
SELECT ASCII('A') FROM dual;
SELECT ASCII(0) FROM dual;

산술식:산술연산자(+,-,*,/)를 사용하여 숫자 및 날짜 데이터로 표현식을 작성
SELECT ename,sal,sal + 300 FROM emp;

연산자 우선순위
SELECT ename,sal,(sal + 300) * 12 FROM emp;

NULL 값의 정의 : NULL은 사용할 수 없거나, 할당되지 않았거나, 알 수 없거나, 적용할 수 없는 값(NULL은 0이나 공백과는 다름)
SELECT empno,ename,job,comm FROM emp;

산술식의 null값 : null값을 포함하는 산술식은 null로 계산
SELECT ename, comm + 100 FROM emp;

--null은 입력 자체가 되지 않는 것, 0이나 공백은 입력된 것. null은 연산이 안된다. null로 계산
--SQL 문장은 문자와 문자열 모두 ''작은따옴표를 사용

열 ALIAS : 열 이름을 바꿈
열 이름 바로 뒤에 나옴. 열 이름과 ALIAS 사이에 선택 사항인 AS 키워드가 올 수도 있음
알리아스에 큰따옴표를 사용하는 경우
 - 대소문자 구별을 원할 때
 - 공백 포함시
 - _,# 등 특수문자 사용시(_는 "" 없이 중간에는 올 수 있으나 맨 앞에 오면 오류 발생)
 - 숫자로 시작할 경우

SELECT sal*12 Asal FROM emp; --바로뒤에 한칸 띄고 별칭 입력
SELECT sal*12 AS Asal FROM emp;
SELECT sal*12 "Annual Salary" FROM emp; --공백이 있으면 에러가 생김, 큰따옴표를 사용하면 입력값 그대로 사용

연결 연산자
열이나 문자열을 다른 열에 연결
두 개의 세로선(||)으로 나타냄 --java에서의 +와 같은 기능

select ename || ' has $' || sal FROM emp;

distinct : 중복행 삭제
SELECT deptno FROM emp;
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT(deptno) FROM emp; --DISTINCT와 테이블명 앞에 공백삭제

describe : 테이블의 구조 표시
DESCRIBE emp;
DESC emp;

WHERE절 : 선택을 사용하여 행 제한
10번 부서에서 일하는 사원의 정보 읽기
SELECT * FROM emp WHERE deptno=10;

SMITH 정보 읽기
SELECT * FROM emp WHERE ename='SMITH'; --입력된 데이터는 대소문자 구분O

날짜 정보 읽기
SELECT * FROM emp WHERE hiredate > '81/12/03'; --날짜는 ('/, -')으로 구분 , 비교연산자 사용 가능

[주의] where절에서는 알리아스(ALIAS)를 사용할 수 없음
SELECT ename,sal,sal*12 ansal FROM emp WHERE sal*12 > 15000; --where절에서 ansal로 입력하면 오류

비교 연산자의 사용
SELECT * FROM emp WHERE hiredate = '81/12/03'; --같다
SELECT * FROM emp WHERE hiredate != '81/12/03'; --같지않다
SELECT * FROM emp WHERE hiredate <> '81/12/03'; --같지않다
SELECT * FROM emp WHERE hiredate ^= '81/12/03'; --같지않다

이상 ~ 이하
SELECT * FROM emp WHERE sal>=1000 AND sal<=1500;

BETWEEN ~ AND ~ : 두 값 사이(지정한 값 포함)
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 1500;
SELECT * FROM emp WHERE sal NOT BETWEEN 1000 AND 1500; --부정형

IN : 값 목록 중의 값과 일치
SELECT * FROM emp WHERE sal IN (1300,2450,3000);
SELECT * FROM emp WHERE sal NOT IN (1300,2450,3000); --부정
SELECT ename,mgr,deptno FROM emp WHERE ename IN ('ALLEN', 'FORD');

LIKE : 연산자를 사용하여 패턴 일치된 정보를 읽어옴
 %는 0개 이상의 문자를 나타냄
 _는 한 문자를 나타냄





