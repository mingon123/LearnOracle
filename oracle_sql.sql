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


[숙제]
1.emp테이블의 업무(job)를 중복되지 않게 표시하시오.
SELECT DISTINCT job FROM emp;

2.업무가 SALESMAN 또는 MANAGER 이면서 급여가 $1,600,%2975,$2850이 아닌 모든 사원의 이름,업무 및 급여를 표시하시오.
SELECT ename,job,sal FROM emp WHERE job IN ('SALESMAN','MANAGER') AND sal NOT IN(1600,2975,2850);

3.업무명에 MAN 이 포함되어 있고, 급여를 $1,000~$3,000사이로 받는 사원의 이름,급여,업무를 출력하시오.
SELECT ename,sal,job FROM emp WHERE job LIKE '%MAN%' AND sal BETWEEN 1000 AND 3000;

4.이름이 S로 끝나는 사원들 중에서 30번 부서에 근무하는 사원의 이름,급여,부서번호를 출력하시오.
SELECT ename,sal,empno FROM emp WHERE ename LIKE '%S' AND deptno=30;

5.커미션 계약을 맺은 모든 사원의 이름,급여,커미션을 출력하는데 커미션을 기준으로 내림차순 정렬하시오.
SELECT ename,sal,comm FROM emp WHERE comm IS NOT NULL ORDER BY comm DESC ;



함수

문자함수

대소문자 조작 함수 - LOWER, UPPER, INITCAP
SELECT LOWER('HELLO') FROM dual;
SELECT UPPER('hello') FROM dual;
SELECT INITCAP('hello wORLD') FROM dual; -- 첫문자 대문자, 나머지 소문자

SELECT LOWER(ename) FROM emp;
SELECT INITCAP(ename) FROM emp;

문자 조작함수
CONCAT(문자열1,문자열2) : 문자열1과 문자열2를 연결하여 하나의 문자열로 반환

SELECT CONCAT('Hello', 'World') FROM dual;

SUBSTR(대상문자열,인덱스) : 대상문자열에서 지정한 인덱스부터 문자열을 추출
[주의]인덱스 1부터 시작
SELECT SUBSTR('Hello World',3) FROM dual;
SELECT SUBSTR('Hello World',3,3) FROM dual; --인덱스3부터 3개만 추출
SELECT SUBSTR('Hello World',-3) FROM dual; --뒤에서 세번째부터 끝까지 추출
SELECT SUBSTR('Hello World',-3,2) FROM dual; --뒤에서 세번째부터 2개만 추출

LENGTH(대상문자열) : 문자열의 개수
SELECT LENGTH('Hello World') FROM dual;

INSTR(대상문자열,검색문자) : 검색문자의 위치값 검색

SELECT INSTR('Hello World','e') FROM dual;

검색 문자가 없을 경우 0 반환
SELECT INSTR('Hello World','E') FROM dual; 
SELECT INSTR('Hello World','o') FROM dual; --중복값의 경우 앞의 값만 가져옴
            대상문자열,검색문자,검색인덱스:해당 위치부터 검색
SELECT INSTR('Hello World','o',6) FROM dual;
            대상문자열,검색문자,검색인덱스,반복횟수
반복횟수:*대상문자열 전체를 여러번 검색한다는 의미가 아니라 1번 검색으로 o를 찾으면 지정한 횟수만큼 그 뒤의 문자를 검색한다는 의미
SELECT INSTR('Hello World','o',1,2) FROM dual;

LPAD(대상문자열,총길이,문자) : 지정한 길이에 문자열을 출력하는데 공백은 왼쪽에 지정한 문자로 채움
RPAD(대상문자열,총길이,문자) : 지정한 길이에 문자열을 출력하는데 공백은 오른쪽에 지정한 문자로 채움

SELECT LPAD('Hello',10,'*') FROM dual; --지정문자가 없으면 공백으로 채움
SELECT RPAD('Hello',10,'*') FROM dual;

TRIM : 문자열에서 공백이나 특정 문자를 제거한 다음 값을 반환
방향 : LEADING -> 왼쪽, TRAILING -> 오른쪽, BOTH -> 양쪽(DEFAULT)
SELECT TRIM(LEADING 'h' FROM 'habchh') FROM dual; --왼쪽 h제거
SELECT TRIM(TRAILING 'h' FROM 'habchh') FROM dual; --오른쪽 h전부 제거
SELECT TRIM(BOTH 'h' FROM 'habchh') FROM dual; --양쪽 h전부 제거

REPLACE(대상문자열,OLD,NEW) : 대상문자열에서 OLD문자를 NEW문자로 대체
SELECT REPLACE('010.1234.5678','.','-') FROM dual;

함수 중첩 
SELECT ename,LOWER(SUBSTR(ename,1,3)) FROM emp;

[실습문제]
1.업무(job)을 첫글자는 대문자 나머지는 소문자로 출력하시오.
SELECT INITCAP(job) FROM emp;

2.사원이름 중 A가 포함된 사원이름을 구하고 그 이름 중 앞에서 3자만 추출하여 출력하시오.
SELECT ename,SUBSTR(ename,1,3) FROM emp WHERE ename LIKE '%A%';

3.이름의 세번째 문자가 A인 모든 사원의 이름을 표시하시오.
SELECT ename FROM emp WHERE SUBSTR(ename,3,1) = 'A';
SELECT ename FROM emp WHERE ename LIKE '__A%';

4.이름이 J,A 또는 M으로 시작하는 모든 사원의 이름(첫글자는 대문자로, 나머지글자는 소문자로 표시) 및 이름의 길이를 표시하시오.(열레이블 name 과 length 로 표시)
SELECT INITCAP(ename) name,LENGTH(ename) length FROM emp WHERE ename LIKE 'J%' OR ename LIKE 'A%' OR ename LIKE 'M%';
SELECT INITCAP(ename) name,LENGTH(ename) length FROM emp WHERE SUBSTR(ename,1,1) IN('J','A','M');


숫자함수
CEIL(실수) : 올림 처리한 정수값을 반환
SELECT CEIL(1.4) FROM dual;

FLOOR(실수) : 버림 처리한 정수값을 반환
SELECT FLOOR(1.7) FROM dual;

ROUND(대상숫자,지정자릿수) : 반올림
SELECT ROUND(45.926,2) FROM dual; --2번째자리까지 출력(3번째자리에서 반올림)
SELECT ROUND(45.926) FROM dual; --정수값을 반환

TRUNC(대상숫자,지정자릿수) : 절삭
SELECT TRUNC(45.926,2) FROM dual; --45.92(해당자릿수까지)
SELECT TRUNC(45.926) FROM dual; --45(정수)

MOD(대상숫자,나눌 숫자) : 나머지값
SELECT MOD(17,2) FROM dual; --17%2는 오류


날짜함수
SYSDATE : ORACLE 서버의 현재 날짜와 시간을 반환
SELECT SYSDATE FROM dual;

날짜에 산술 연산자 사용
SELECT ename,hiredate,(SYSDATE - hiredate)/7 AS WEEKS FROM emp WHERE deptno=10; --입사이후 몇주가 지났는지

MONTHS_BETWEEN(날짜1,날짜2) : 두 날짜 간의 월 수 
SELECT MONTHS_BETWEEN('2024-08-29','2023-01-29') FROM dual; --큰날짜가 앞으로 와야함. 작은값이 앞으로 오면 음수가 나옴

SELECT ename,MONTHS_BETWEEN(SYSDATE,hiredate) months_worked FROM emp ORDER BY months_worked;
SELECT ename,TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)) months_worked FROM emp ORDER BY months_worked; --소숫점버림

ADD_MONTHS : 특정 날짜의 월에 정수를 더한 다음 해당 날짜를 반환하는 함수
SELECT ADD_MONTHS('2024-08-29',8) FROM dual;

NEXT_DAY : 지정된 요일의 다음 날짜
SELECT NEXT_DAY('2025/02/03','월요일') FROM dual;

1(일요일) ~ 7(토요일)
SELECT NEXT_DAY('2025/02/04',2) FROM dual;

LAST_DAY : 월의 마지막 날
SELECT LAST_DAY('2025-02-04') FROM dual;


EXTRACT : 날짜 정보에서 특정한 연,월,일,시,분,초 추출

SELECT EXTRACT(YEAR FROM SYSDATE) YEAR,
       EXTRACT(MONTH FROM SYSDATE) MONTH,
       EXTRACT(DAY FROM SYSDATE) DAY
FROM dual;

SELECT EXTRACT(YEAR FROM hiredate) YEAR,
       EXTRACT(MONTH FROM hiredate) MONTH,
       EXTRACT(DAY FROM hiredate) DAY
FROM emp;

SELECT EXTRACT(YEAR FROM SYSTIMESTAMP) YEAR,
       EXTRACT(MONTH FROM SYSTIMESTAMP) MONTH,
       EXTRACT(DAY FROM SYSTIMESTAMP) DAY,
       EXTRACT(HOUR FROM SYSTIMESTAMP) HOUR, 
       EXTRACT(MINUTE FROM SYSTIMESTAMP) MINUTE, 
       EXTRACT(SECOND FROM SYSTIMESTAMP) SECOND
FROM dual;

SELECT EXTRACT(YEAR FROM DATE'2025-02-04') YEAR, --DATE를 붙이면 문자열로 출력 가능
       EXTRACT(MONTH FROM DATE'2025-02-04') MONTH,
       EXTRACT(DAY FROM DATE'2025-02-04') DAY
FROM dual; 

SELECT EXTRACT(YEAR FROM TIMESTAMP'2025-02-04 11:45:10') YEAR, --DATE를 붙이면 문자열로 출력 가능
       EXTRACT(MONTH FROM TIMESTAMP'2025-02-04 11:45:10') MONTH,
       EXTRACT(DAY FROM TIMESTAMP'2025-02-04 11:45:10') DAY,
       EXTRACT(HOUR FROM TIMESTAMP'2025-02-04 11:45:10') HOUR, --시간은 DATE말고 TIMESTAMP 사용해야함
       EXTRACT(MINUTE FROM TIMESTAMP'2025-02-04 11:45:10') MINUTE,
       EXTRACT(SECOND FROM TIMESTAMP'2025-02-04 11:45:10') SECOND
FROM dual; 

[실습문제]
1.오늘부터 이번달의 마지막날까지의 남은 날 수를 구하시오.
SELECT LAST_DAY(SYSDATE)-SYSDATE AS "남은 날 수" FROM dual;

2.각 사원의 사원번호,이름,급여 및 15% 인상된 급여를 정수(반올림)로 표시하시오. 인상된 급여 열의 레이블을 New Salary로 지정하시오.
SELECT empno,ename,sal,ROUND(sal+sal*0.15) "New Salary" FROM emp;

3.월급을 나눠서 4의 배수인 월급을 받는 사원의 이름과 월급을 출력하시오.
SELECT ename,sal FROM emp WHERE MOD(sal,4)=0;


변환함수

명시적 데이터 유형 숫자
TO_CHAR : 숫자 -> 문자, 날짜 -> 문자
TO_NUMBER : 문자 -> 숫자
TO_DATE : 문자 -> 날짜

TO_CHAR : 날짜 -> 문자
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM dual;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM dual;

TO_CHAR : 숫자->문자

실제 자리수와 일치해야함
SELECT TO_CHAR(1234,9999) FROM dual; --9 : 자릿수
SELECT TO_CHAR(1234,'9999') FROM dual; --위와 같음
SELECT TO_CHAR(1234,'0000') FROM dual; --0000으로 명시하면 ##출력 오류. ''필수!

자리수가 모자람
SELECT TO_CHAR(1234,999) FROM dual; --####(형식에 맞지않아 오류)
SELECT TO_CHAR(1234,'999') FROM dual; --####
SELECT TO_CHAR(1234,'000') FROM dual; --####

자리수 지정하지 않음 : 숫자 -> 문자
SELECT TO_CHAR(1234) FROM dual; --1234

실제 자리수보다 많은 자리수 지정
SELECT TO_CHAR(1234,99999) FROM dual; -- 1234(값 앞에 공백한칸 출력)
SELECT TO_CHAR(1234,'99999') FROM dual; -- 1234
SELECT TO_CHAR(1234,'00000') FROM dual --01234

소수점 자리
SELECT TO_CHAR(1234,9999.99) FROM dual; --1234.00
SELECT TO_CHAR(1234,'9999.99') FROM dual; --1234.00
SELECT TO_CHAR(1234,'0000.00') FROM dual; --1234.00

반올림해서 소수점 둘째자리까지 표시
SELECT TO_CHAR(25.897,'99.99') FROM dual; --25.90
--반올림(ROUND : 숫자형태유지, TO_CHAR : 문자로 변환)
인상된 급여를 소수점 첫째자리까지 표시
SELECT TO_CHAR(sal*1.15,'9,999.9') FROM emp;

통화표시
SELECT TO_CHAR(1234,'$0000') FROM dual;
지역통화 표시(원)
SELECT TO_CHAR(1234,'L0000') FROM dual;
















