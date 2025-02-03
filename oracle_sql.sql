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

사원명에 S가 포함된 사원 정보 읽기
SELECT * FROM emp WHERE ename LIKE '%S%';

사원명이 S로 시작하는 사원 정보 읽기
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename NOT LIKE 'S%'; --부정

입사일이 22로 끝나는 날 입사한 사원 정보 읽기
SELECT * FROM emp WHERE hiredate LIKE '%22'; --날짜도 찾을 수 있음, 문자열로 입력

사원이름이 FOR 다음에 한글자로 구성된 이름을 갖는 사원 정보 읽기
SELECT * FROM emp WHERE ename LIKE 'FOR_';

NULL 조건 사용
SELECT * FROM emp WHERE comm = NULL; -- comm = null은 불가
SELECT * FROM emp WHERE comm IS NULL; --이렇게 입력해야함
SELECT * FROM emp WHERE comm IS NOT NULL; -- comm != null은 불가

[실습문제]
1.emp테이블에서 사원번호(empno),사원이름(ename),월급(sal)을 출력하시오
SELECT empno,ename,sal FROM emp;

2.emp테이블에서 사원이름과 월급을 출력하는데 컬럼명은 "이 름", "월 급"으로 바꿔서 출력하시오.
SELECT ename "이 름", sal "월 급" FROM emp;

3.emp테이블에서 사원번호,사원이름,월급,연봉을 구하고 각각 컬럼명은 "사원번호","사원이름","월급","연봉"으로 출력하시오.
SELECT empno 사원번호,ename 사원이름,sal 월급,sal*12 연봉 FROM emp;

4.emp테이블에서 사원번호가 7698인 사원의 이름,업무(job),급여를 출력하시오
SELECT ename,job,sal FROM emp WHERE empno=7698;

5.emp테이블에서 사원이름이 SMITH인 사원의 이름과 월급,부서번호(deptno)를 구하시오.
SELECT ename,sal,deptno FROM emp WHERE ename='SMITH';

6.월급이 2500이상 3500미만인 사원의 이름,입사일,월급을 구하시오.
SELECT ename,hiredate,sal FROM emp WHERE sal>=2500 AND sal<3500;

7.급여가 2000에서 3000사이에 포함되지 않는 사원의 이름,업무,급여를 출력하시오.
SELECT ename,job,sal FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;
SELECT ename,job,sal FROM emp WHERE not (sal>=2000 AND sal<=3000);

8.81년05월01일과 81년12월03일 사이에 입사한 사원의 이름,급여,입사일을 출력하시오.
SELECT ename,sal,hiredate FROM emp WHERE hiredate BETWEEN '81/05/01' AND '81/12/03'; --날짜에도 ''필수!
SELECT ename,sal,hiredate FROM emp WHERE hiredate BETWEEN '81-05-01' AND '81-12-03';
SELECT ename,sal,hiredate FROM emp WHERE hiredate>='81/05/01' AND hiredate<='81/12/03';

9.사원번호가 7566,7782,7934인 사원을 제외한 사람들의 사원번호,이름,월급을 출력하시오.
SELECT empno,ename,sal FROM emp WHERE empno NOT IN(7566,7782,7934);

10.급여가 2000와 5000사이고 부서번호가 10 또는 30인 사원의 이름과 급여,부서번호를 출력하시오.
SELECT ename,sal,deptno FROM emp WHERE (sal BETWEEN 2000 AND 5000) AND deptno IN(10,30);
SELECT ename,sal,deptno FROM emp WHERE (sal BETWEEN 2000 AND 5000) AND (deptno = 10 OR deptno = 30);


ORDER BY : 정렬
ASC : 오름차순으로 행을 정렬(기본 순서)
DESC : 내림차순으로 행을 정렬

SELECT * FROM emp WHERE deptno = 10 ORDER BY sal; --오름차순 정렬
SELECT * FROM emp WHERE deptno = 10 ORDER BY sal ASC; --오름차순 정렬(생략가능)
SELECT * FROM emp WHERE deptno = 10 ORDER BY sal DESC; --내림차순 정렬

SELECT * FROM emp ORDER BY sal DESC,ename DESC; --중복이 있는 경우 2차정렬을 통해 다시 정렬할 수 있음

SELECT * FROM emp ORDER BY job,sal DESC,ename; --중복값이 있다면 2차,3차정렬 가능하다.

열 ALIAS를 기준으로 정렬
SELECT empno,ename,sal,sal*12 annsal FROM emp ORDER BY annsal; --정렬은 열ALIAS 사용 가능(WHERE절은 오류)

열의 숫자 위치를 사용하여 정렬
--      1     2    3     4
SELECT ename,job,deptno,hiredate FROM emp ORDER BY 3; --index3번째인 deptno를 기준으로 정렬

테이블에 생성된 순서대로 열 숫자 위치 부여 --직관적이지 않아서 좋지 않음
SELECT * FROM emp ORDER BY 2;

NULLS FIRST 또는 NULLS LAST 키워드를 사용하여 반환된 행 중 NULL값을 포함하는 행이 정렬 순서상 맨 처음에 나타나거나 마지막에 나타나도록 지정 

SELECT * FROM emp ORDER BY comm NULLS FIRST; --안쓰면 맨 아래로 가는데 위로 가도록 싶으면 사용
SELECT * FROM emp ORDER BY comm DESC NULLS LAST;

SELECT * FROM emp ORDER BY comm DESC NULLS LAST, ename; --2차정렬

[실습문제]
1.사원번호,사원이름,입사일을 출력하는데 입사일이 빠른 사람순으로 정렬하시오.
SELECT empno,ename,hiredate FROM emp ORDER BY hiredate;

2.사원이름,급여,연봉을 구하고 연봉이 많은 순으로 정렬하시오.
SELECT ename,sal,sal*12 FROM emp ORDER BY sal*12 DESC;
SELECT ename,sal,sal*12 annsal FROM emp ORDER BY annsal DESC; --자바에서는 ALIAS 권장

3.10번 부서 또는 20번 부서에서 근무하고 있는 사원의 이름과 부서번호를 출력하는데 이름을 영문자순으로 표시하시오.
SELECT ename,deptno FROM emp WHERE deptno IN(10,20) ORDER BY ename;


