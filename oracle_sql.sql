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

SELECT ename || ' has $' || sal FROM emp;

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

LTRIM(대상문자열,제거할 문자) : 문자열의 왼쪽에서 공백이나 특정 문자를 제거한 다음 값을 반환
SELECT LTRIM('habchh','h') FROM dual;

RTRIM(대상문자열,제거할 문자) : 문자열의 오른쪽에서 공백이나 특정 문자를 제거한 다음 값을 반환
SELECT RTRIM('habchh','h') FROM dual;

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
SELECT SYSDATE FROM dual; --기본은 날짜만 표시

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
SELECT TO_CHAR(1234,'00000') FROM dual; --01234

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
SELECT TO_CHAR(1234,'L0000') FROM dual; --$제외는 시스템의 문자를 기준으로 통화표시

TO_DATE -- 문자 -> 날짜
SELECT TO_DATE('25-02-04','YYYY-MM-DD') FROM dual; --25/02/04
포맷 형식 생략 가능
SELECT TO_DATE('25-02-04') FROM dual;

TO_NUMBER --문자 -> 숫자
SELECT TO_NUMBER('100',999) FROM dual;
포맷 형식 생략 가능
SELECT TO_NUMBER('200') FROM dual;



일반함수

***(NVL암기)
NVL(value1,value2) : value1이 null이면 value2를 사용. value1과 value2의 자료형이 일치해야함
SELECT ename,sal,comm, sal+NVL(comm,0) 실급여 FROM emp;

SELECT ename,NVL(TO_CHAR(comm),'No Commission') "COMM." FROM emp;

NVL2(value1,value2,value3) : value1이 null인지 평가. null이면 value3, null이 아니면 value2. 자료형이 일치하지 않아도 됨.

SELECT ename,job,NVL2(comm,'commission','no commission') FROM emp;

NULLIF(value1,value2) : 두 개의 값이 일치하면 null, 두 개의 값이 일치하지 않으면 value1
SELECT NULLIF(LENGTH(ename),LENGTH(job)) "NULLIF" FROM emp;

COALESCE(value1,value2,value3,...) : null값이 아닌 값을 사용(자료형 일치)
SELECT comm,mgr,sal, COALESCE(comm,mgr,sal) FROM emp;


***(암기)CASE : 조건 제어가 가능한 함수
CASE 컬럼 WHEN 비교값 THEN 결과값
         WHEN 비교값 THEN 결과값
         WHEN 비교값 THEN 결과값
         (ELSE 결과값)
END;

SELECT ename,sal,job,
       CASE job WHEN 'SALESMAN' THEN sal*0.1
                WHEN 'MANAGER' THEN sal*0.2
                WHEN 'ANALYST' THEN sal*0.3
                ELSE sal*0.4
        END "Bonus"
FROM EMP;

SELECT ename,sal,job,
       CASE WHEN sal>=4000 AND sal<=5000 THEN 'A'
            WHEN sal>=3000 AND sal<4000 THEN 'B'
            WHEN sal>=2000 AND sal<3000 THEN 'C'
            WHEN sal>=1000 AND sal<2000 THEN 'D'
            ELSE 'F'
       END "Grade"
FROM emp ORDER BY sal DESC;

DECODE(오라클 전용) : = 비교만 가능
DECODE(컬럼,비교값,반환값,
            비교값,반환값,
            비교값,반환값,
            반환값)
            
SELECT ename,sal,job,
       DECODE(job,'SALESMAN',sal*0.1,
                  'MANAGER', sal*0.2,
                  'ANALYST', sal*0.3,
                  sal*0.4) "Bonus"
FROM emp;

SELECT ename,sal,job,
        DECODE(TRUNC(sal/1000),5,'A',
                               4,'A',
                               3,'B',
                               2,'C',
                               1,'D',
                               'F') "Grade"
FROM emp ORDER BY sal DESC;

특정 컬럼의 특정값을 먼저 오게 정렬하는 방법
ORDER BY (CASE 컬럼명 WHEN 비교값 THEN 1(순서)
                     WHEN 비교값 THEN 2
                     ELSE 3
          END)

사번으로 정렬하는데 7698인 경우는 가장 먼저 정렬
SELECT empno,ename,sal FROM emp 
ORDER BY (CASE empno WHEN 7698 THEN 1
          END),empno;

[실습문제]
1.사원이름,월급,월급과 커미션을 더한 값을 컬럼명 실급여라고 해서 출력하시오.
  단, null값은 나타나지 않게 작성하시오.
SELECT ename,sal,sal+NVL(comm,0) 실급여 FROM emp;

2.월급과 커미션을 합친 금액이 2,000이상인 급여를 받는 사원의 이름,업무,월급,커미션,고용날짜를 출력하시오.
  단, 고용날짜는 1980-12-17 형식으로 출력하시오.
SELECT ename,job,sal,comm,TO_CHAR(hiredate,'YYYY-MM-DD') AS hiredate FROM emp WHERE sal+NVL(comm,0)>=2000;

3.DECODE 함수를 사용하여 다음 데이터에 따라 JOB열의 값을 기준으로 모든 사원의 등급을 표시하시오.
  업무     등급
  PRESIDENT A
  ANALYST   B
  MANAGER   C
  SALESMAN  D
  CLERK    E
  기타      0(영)
SELECT ename, job, 
       DECODE(job,'PRESIDENT','A',
                  'ANALYST','B',
                  'MANAGER','C',
                  'SALESMAN','D',
                  'CLERK','E',
                  '0') "Grade"
FROM emp ORDER BY "Grade";

[실습문제]
1.관리자번호(mgr)가 없는 모든 사원의 이름과 업무를 표시하시오.(king)
SELECT ename,job FROM emp WHERE mgr IS NULL;

2.커미션 항목이 입력된 사원들의 이름과 급여,커미션을 구하시오.
SELECT ename,sal,comm FROM emp WHERE comm IS NOT NULL;

3.이름의 글자수가 6자 이상인 사원의 이름을 소문자로 이름만 출력하시오.
SELECT LOWER(ename) FROM emp WHERE LENGTH(ename)>=6;

4.각 사원의 이름을 표시하고 근무 달 수(입사일로부터 현재까지의 달 수)를 계산하여 열 레이블을 MONTHS_WORKED로 지정하시오.
  결과는 정수로 반올림하여 표시하고 근무달 수를 기준으로 오름차순으로 정렬하시오.
SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)) AS MONTHS_WORKED FROM emp ORDER BY MONTHS_WORKED;

5.이름(소문자로 표시),업무,근무연차를 출력하시오.
SELECT LOWER(ename),job,TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)/12) AS "근무연차" FROM emp;


그룹함수 : 행 집합 연산을 수행하여 그룹별로 하나의 결과를 산출
AVG() : NULL을 제외한 모든 값들의 평균을 반환. NULL값은 평균 계산에서 무시됨.
SELECT ROUND(AVG(sal)) FROM emp;

--레코드 : 데이터가 들어가 있는 행
COUNT() : NULL을 제외한 값을 가진 모든 레코드의 수를 반환. COUNT(*)형식을 사용하면 NULL도 계산에 포함.

SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp;

MAX() : 레코드 내에 있는 여러값 중 가장 큰 값을 반환
SELECT MAX(sal) FROM emp;
SELECT MAX(ename) FROM emp; --사전순으로 가장 마지막(알파벳순)
SELECT MAX(hiredate) FROM emp;

MIN() : 레코드 내에 있는 여러값 중 가장 작은 값을 반환
SELECT MIN(sal) FROM emp;
SELECT MIN(ename) FROM emp; --사전순으로 가장 앞
SELECT MIN(hiredate) FROM emp;

SUM() : 레코드들이 포함하고 있는 모든 값을 더하여 반환
SELECT SUM(sal) FROM emp;

SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp;
SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp WHERE deptno = 10;
SELECT COUNT(*) FROM emp WHERE deptno=20; --사원수라고도 할 수 있음
SELECT COUNT(empno) FROM emp WHERE deptno=30; --null값이 있는 컬럼은 제대로 안나옴


GROUP BY & HAVING

SELECT에서 집합함수(그룹함수) 적용시 개별 컬럼을 지정할 수 없다.
개별 컬럼을 지정할 경우에는 반드시 GROUP BY절에 지정된 컬럼만 가능
SELECT deptno,MAX(sal) FROM emp; --두 테이블이 행의 수가 달라서 오류가 생김
SELECT deptno,MAX(sal) FROM emp GROUP BY deptno;
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno;

다중 열에서 GROUP BY절 사용
SELECT deptno,job,SUM(sal) FROM emp GROUP BY deptno,job ORDER BY deptno;

그룹 처리 결과를 제한하고자 할 때 having절 이용
- WHERE절에는 집합함수를 사용할 수 없고 HAVING절 사용

오류 발생
SELECT deptno,ROUND(AVG(sal)) FROM emp WHERE ROUND(AVG(sal))>2000 GROUP BY deptno;
--WHERE절에서 그룹함수 못씀. HAVING절을 사용해야 함.

정상 구문
SELECT deptno,ROUND(AVG(sal)) FROM emp GROUP BY deptno HAVING ROUND(AVG(sal))>2000;

HAVING절의 이용 : 알리아스 사용 X
SELECT deptno,MAX(sal) maximum FROM emp GROUP BY deptno HAVING MAX(sal)>3000;--maximum>3000; WHERE절, HAVING절 - ALIAS 안됨


[숙제]
1.사원명과 업무를 쉼표(,)로 연결해서 표시하고 컬럼명은 Employee and Job으로 표시하시오.
SELECT ename||','||job "Employee and Job" FROM emp;

2.30번 부서에서 근무하며 월2,000달러 이하를 받는 81년05월01일 이전에 입사한 사원의 이름,급여,부서번호,입사일을 출력하시오.
SELECT ename,sal,deptno,hiredate FROM emp WHERE deptno=30 AND sal<=2000 AND hiredate<'81/05/01'; 

3.이름에 A와 E가 있는 모든 사원의 이름을 표시하시오.
SELECT ename FROM emp WHERE ename LIKE '%A%' OR ename LIKE '%E%';
SELECT ename FROM emp WHERE ename LIKE '%A%' AND ename LIKE '%E%';

4.사원이름 중 S가 포함되지 않은 사람들 중 부서번호가 20번인 사원들의 이름과 부서번호를 출력하시오.
SELECT ename,deptno FROM emp WHERE ename NOT LIKE '%S%' AND deptno=20;

5.모든 사원의 이름과 급여를 표시하는데 급여는 15자 길이로 왼쪽에 $기호가 채워진 형식으로 표기하고 열 레이블을 SALARY로 지정하시오.
SELECT ename,LPAD(sal, 15,'$') SALARY FROM emp;



그룹함수 이용하기

짝수 해와 홀수 해에 입사한 사원의 정보 구하기
SELECT CASE MOD(EXTRACT(YEAR FROM hiredate),2) WHEN 0 THEN '짝수 연도'
                                               ELSE '홀수 연도'
       END AS YEAR,
       COUNT(empno) AS employee_number
FROM emp GROUP BY MOD(EXTRACT(YEAR FROM hiredate),2); --ORDER BY만 ALIAS 사용가능

1981년에 입사한 사원들의 목록으로부터 분기별 입사자의 수를 구함
SELECT TO_CHAR(hiredate,'Q') AS "Quarter",COUNT(empno) AS employee_number
FROM emp where extract(year from HIREDATE) = 1981
GROUP BY TO_CHAR(hiredate,'Q') ORDER BY "Quarter";

[실습문제]
1.모든 사원의 급여 최고액,최저액,총액 및 평균액을 표시하시오.열 레이블을 각각 maximum,minimum,sum 및 average로 지정하고 결과를 정수로 반올림하고 세자리 단위로 ,를 명시하시오.
SELECT TO_CHAR(MAX(sal),'9,999') maximum, TO_CHAR(MIN(sal),'9,999') minimum, TO_CHAR(SUM(sal),'99,999') sum, TO_CHAR(ROUND(AVG(sal)),'9,999') average FROM emp; --1번방법
SELECT TO_CHAR(MAX(sal),'9,999') maximum, TO_CHAR(MIN(sal),'9,999') minimum, TO_CHAR(SUM(sal),'99,999') sum, TO_CHAR(AVG(sal),'9,999') average FROM emp; --2번방법(ROUND 제거, format형식에 소숫점이 없어서)

2.급여와 커미션을 더한 금액의 최고,최저,평균금액을 구하시오.평균금액은 소수점 첫째자리까지 표시하시오.
SELECT MAX(sal+NVL(comm,0)) max, MIN(sal+NVL(comm,0)) min, ROUND(AVG(sal+NVL(comm,0)),1) avg FROM emp;

3.업무와 업무가 동일한 사원수를 표시하시오.(업무별 사원수를 구하시오.)
SELECT job,COUNT(*) FROM emp GROUP BY job;

4.30번부서의 사원수를 구하시오.
SELECT COUNT(*) FROM emp WHERE deptno=30; --부서번호를 명시하지 않은 경우
SELECT deptno,COUNT(*) FROM emp WHERE deptno=30 GROUP BY deptno; --부서번호ㅡ사원수 명시
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno HAVING deptno=30; --둘다 가능, where절이 보편적(having은 그룹함수 일 때 사용)

5.업무별 최고 월급을 구하고 업무,최고 월급을 출력하시오.
SELECT job,MAX(sal) FROM emp GROUP BY job;

6.20번부서의 급여 합계를 구하고,급여 합계 급액을 출력하시오.
SELECT SUM(sal) FROM emp WHERE deptno=20;

7.부서별로 지급되는 총월급에서 금액이 9,000이상을 받는 사원들의 부서번호,총월급을 출력하시오.
SELECT deptno,SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal)>=9000;

8.업무별로 가장 늦은 사번을 구하고 그 결과 내에서 사번이 79로 시작하는 결과만 출력하시오.(업무,가장 늦은 사번 출력)
SELECT job,MAX(empno) FROM emp GROUP BY job HAVING MAX(empno) LIKE '79%'; --이게 정답
SELECT job,MAX(empno) FROM emp WHERE empno LIKE '79%' GROUP BY job; --이것도 결과는 같음

9.업무별 총월급을 출력하는데 업무가 'MANAGER'인 사원들은 제외하고 총월급이 5,000보다 많은 업무와 총월급만 출력하시오.
SELECT job,SUM(sal) FROM emp WHERE job != 'MANAGER' GROUP BY job HAVING SUM(sal)>5000;

10.업무별로 사원의 수가 4명 이상인 업무와 인원수를 출력하시오.
SELECT job,COUNT(*) FROM emp GROUP BY job HAVING COUNT(*)>=4;


분석함수

RANK() : 순위를 표현할 때 사용하는 함수
RANK(조건값) WITHIN GROUP (ORDER BY 조건값 컬럼명 [ASC|DESC]) : 특정 데이터의 순위 확인하기
[주의] RANK 뒤에 나오는 데이터와 ORDER BY 뒤에 나오는 데이터는 같은 컬럼이어야 한다.
SELECT RANK('SMITH') WITHIN GROUP (ORDER BY ename) "RANK" FROM emp;

전체순위 보기 : RANK() 뒤가 WITHIN GROUP이 아니고 OVER로 바뀜
사원들의 empno,ename,sal,급여 순위를 출력
SELECT empno,ename,sal,RANK() OVER (ORDER BY sal) "RANK_ASC", RANK() OVER (ORDER BY sal DESC) "RANK_DESC" FROM emp; --내림차순,오름차순 정렬

10부서에 속한 직원들의 사번과 이름,급여,해당 부서 내의 급여 순위를 출력
SELECT empno,ename,sal,RANK() OVER (ORDER BY sal DESC) "RANK" FROM emp WHERE deptno=10;

사원번호,이름,급여,부서번호,부서별 급여 순위를 출력
SELECT empno,ename,sal,deptno,RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) "RANK" FROM emp; --PARTITION(그룹으로 묶음)


조인(JOIN) : 둘 이상의 테이블을 연결하여 데이터를 검색하는 방법
            보통 둘 이상의 행들의 공통된 값 Primary Key 및 Foreign Key 값을 사용하여 조인

Catesion Product(카티션 곱)
검색하고자 했던 데이터뿐 아니라 조인에 사용된 테이블들의 모든 데이터가 반환되는 현상
SELECT * FROM emp,dept; --emp,dept테이블이 합쳐져 중복데이터가 생김 : JOIN필요

JOIN 방법
[ORACLE 전용]
동등 조인(equi join) : 두 테이블에 같은 컬럼이 있는 경우 사용
조인절에 Equality Condition(=)에 의하여 조인이 이루어 짐
SELECT emp.ename,dept.dname FROM emp,dept WHERE emp.deptno=dept.deptno; --두 테이블 모두 같은 컬럼이 있어야 함(여기선 deptno)

테이블에 알리아스 부여하기
SELECT e.ename,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno; 

컬럼명을 호출할 때 테이블명 또는 테이블 알리아스를 생략
SELECT ename,d.deptno,dname FROM emp e,dept d WHERE e.deptno=d.deptno; --두 테이블에 같은 컬럼이 있는 경우는 알리아스 생략 불가 

부가적인 조건 명시하기
SELECT e.ename,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno AND e.ename='ALLEN'; --AND로 조건 추가 입력

SELECT e.ename,e.sal,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno AND e.sal BETWEEN 3000 AND 4000;


--비동등조인 : 동등조인이 안된다고 하더라도 같은 조건의 데이터여야 한다. emp.sal=salgrade로 대응되기 때문에 가능
비동등 조인(no equi join)
테이블의 어떤 column도 join할 테이블의 column에 일치하지 않을 때 사용하고 조인 조건은 동등(=)이외의 연산자를 갖음(between and,is null,in)

사원이름,급여,급여등급 구하기(emp,salgrade 테이블 이용)
SELECT e.ename,e.sal,s.grade FROM emp e,salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal;


SELF JOIN
사원 이름과 해당 사원의 관리자 이름 구하기(관리자가 없는 사원 제외)
SELECT e.ename 사원이름,m.ename 관리자이름 FROM emp e,emp m WHERE e.mgr=m.empno; --e:사원정보,m:관리자번호


외부 조인(OUTER JOIN)
Equi JOIN 문장들의 한 가지 제약점은 그것들이 조인을 생성하려 하는 두 개의 테이블의 두 개 컬럼에서 공통된 값이 없다면 테이블로부터 데이터를 반환하지 않는다는 것.
누락된 행을 보기 위해서는 Outer Join을 사용

누락된 행의 반대 테이블의 조인 조건의 컬럼에 (+)기호 표시
SELECT DISTINCT e.deptno,d.deptno FROM emp e,dept d WHERE e.deptno(+)=d.deptno;

사원이름과 해당 사원의 관리자 이름구하기(관리자가 없는 사원도 표시)
SELECT e.ename 사원이름,m.ename 관리자이름 FROM emp e,emp m WHERE e.mgr=m.empno(+); --누락행의 반대테이블


[표준 SQL]
내부 조인(INNER JOIN)
SELECT e.ename,d.deptno FROM emp e INNER JOIN dept d ON e.deptno=d.deptno;
SELECT e.ename,d.deptno FROM emp e JOIN dept d ON e.deptno=d.deptno;

JOIN 사용시 ON절을 정의하고 부가적인 조건이 있으면 WHERE절 사용
SELECT e.ename,d.dname FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE e.ename='ALLEN';
--JOIN : 내부조건, ON : 조인조건, WHERE : 부가조건

만약 조인 조건에 사용된 컬럼의 이름이 같다면 다음과 같이 USING절을 사용하여 조인 조건을 정의할 수 있다.
SELECT e.ename,d.dname FROM emp e JOIN dept d USING(deptno) WHERE e.ename='ALLEN';

[주의]USING에 사용된 컬럼은 테이블명 또는 테이블알리아스를 붙이지 않음
SELECT e.ename,deptno FROM emp e JOIN dept d USING(deptno); --오류: ALIAS사용X, USING명령어로 하나로 합침

JOIN할 때 하나의 테이블에만 존재하는 컬럼은 테이블명 또는 테이블 알리아스를 붙이지 않아도 식별 가능
SELECT ename,deptno,dname FROM emp JOIN dept USING(deptno);


SELF JOIN
사원 이름과 해당 사원의 관리자 이름 구하기(관리자가 없는 사원읜 제외)
SELECT e.ename name,m.ename manager_name FROM emp e JOIN emp m ON e.mgr = m.empno; --USING 사용 불가


외부 조인(OUTER JOIN)
누락된 행의 방향 표시 --null값이 필요하면 사용
SELECT DISTINCT(e.deptno),d.deptno FROM emp e RIGHT OUTER JOIN dept d ON e.deptno=d.deptno; --_1로 누락된거 확인하고 RIGHT OUTER 추가하여 빈 컬럼도 추가

사원 이름과 해당 사원의 관리자 이름 구하기(관리자가 없는 사원도 표시)
SELECT e.ename name,m.ename manager_name FROM emp e LEFT OUTER JOIN emp m ON e.mgr=m.empno;

[실습문제]
1.모든 사원의 이름,부서번호,부서이름을 표시하시오.(emp,dept)
SELECT e.ename,e.deptno,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno; --오라클전용

SELECT e.ename,d.deptno,d.dname FROM emp e JOIN dept d ON e.deptno=d.deptno; --표준SQL
SELECT ename,deptno,dname FROM emp JOIN dept USING(deptno); --표준SQL

2.업무가 MANAGER인 사원의 정보를 이름,업무,부서명,근무지 순으로 출력하시오.(emp,dept)
SELECT e.ename,e.job,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.job='MANAGER'; --오라클전용

SELECT e.ename,e.job,d.dname,d.loc FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE e.job='MANAGER'; --표준SQL
SELECT ename,job,dname,loc FROM emp e JOIN dept USING(deptno) WHERE job='MANAGER';

3.커미션을 받고 급여가 1,600이상인 사원의 사원이름,급여,부서명,근무지를 출력하시오.
SELECT e.ename,e.sal,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.comm IS NOT NULL AND e.sal>=1600; --오라클전용

SELECT e.ename,e.sal,d.dname,d.loc FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE e.comm IS NOT NULL AND e.sal>=1600; --표준SQL
SELECT ename,sal,dname,loc FROM emp JOIN dept USING(deptno) WHERE comm IS NOT NULL AND sal>=1600;

4.근무지(LOC)가 CHICAGO인 모든 사원의 이름,업무,부서번호 및 부서이름을 표시하시오.
SELECT e.ename,e.job,d.deptno,d.dname FROM emp e,dept d WHERE e.deptno=d.deptno AND d.loc='CHICAGO'; --오라클전용

SELECT e.ename,e.job,d.deptno,d.dname FROM emp e JOIN dept d ON e.deptno=d.deptno WHERE d.loc='CHICAGO'; --표준SQL
SELECT ename,job,deptno,dname FROM emp JOIN dept USING(deptno) WHERE loc='CHICAGO';


5.근무지(LOC)별로 근무하는 사원의 수가 5명 이하인 경우,인원이 적은 도시 순으로 정렬하시오.(근무 인원이 0명인 곳도 표시)
SELECT d.loc,COUNT(e.empno) emp_member FROM emp e,dept d WHERE e.deptno(+)=d.deptno GROUP BY d.loc HAVING COUNT(e.empno)<=5 ORDER BY emp_member; --오라클전용

SELECT d.loc,COUNT(e.empno) emp_member FROM emp e RIGHT OUTER JOIN dept d ON e.deptno=d.deptno GROUP BY d.loc HAVING COUNT(e.empno)<=5 ORDER BY emp_member; --표준SQL
SELECT loc,COUNT(empno) emp_member FROM emp RIGHT OUTER JOIN dept USING(deptno) GROUP BY loc HAVING COUNT(empno)<=5 ORDER BY emp_member;

6.사원의 이름 및 사원 번호를 관리자의 이름과 관리자 번호와 함께 표시하고 각각의 열 레이블은 employee,emp#,manager,mgr#로 지정하시오.(관리자가 없는 사원 미출력)
SELECT e.ename "employee",e.empno "emp#",m.ename "manager",e.mgr "mgr#" FROM emp e, emp m WHERE m.empno=e.mgr; --오라클전용

SELECT e.ename "employee",e.empno "emp#",m.ename "manager",e.mgr "mgr#" FROM emp e INNER JOIN emp m ON m.empno=e.mgr; --표준SQL

7.관리자보다 먼저 입사한 모든 사원의 이름, 사원 입사일, 관리자의 이름, 관리자 입사일과 함께 표시하고 열 레이블을 각각 employee,emp hired,manager,mgr hired로 지정하시오.
SELECT e.ename "employee",e.hiredate "emp hired",m.ename "manager",m.hiredate "mgr hired" FROM emp e,emp m WHERE m.empno=e.mgr AND e.hiredate<m.hiredate; --오라클전용

SELECT e.ename "employee",e.hiredate "emp hired",m.ename "manager",m.hiredate "mgr hired" FROM emp e JOIN emp m ON e.mgr=m.empno WHERE e.hiredate<m.hiredate; --표준SQL

8.사원의 이름 및 사원번호를 관리자의 이름과 관리자 번호와 함께 표시하고 각각의 열 레이블은 employee,emp#,manager,mgr#로 지정하는데 King을 포함하여 관리자가 없는 모든 사원도 표시하고 결과를 사원번호를 기준으로 정렬하시오.
SELECT e.ename "employee",e.empno "emp#",m.ename "manager",m.empno "mgr#" FROM emp e, emp m WHERE e.mgr=m.empno(+) ORDER BY e.empno; --오라클전용

SELECT e.ename "employee",e.empno "emp#",m.ename "manager",m.empno "mgr#" FROM emp e LEFT OUTER JOIN emp m ON e.mgr=m.empno ORDER BY e.empno;--표준SQL

9.커미션이 책정된 사원들의 사원번호,이름,연봉,급여+커미션,급여등급,부서명을 출력하는데 각각의 컬럼명을 "사원번호","사원이름","연봉","실급여","급여등급","부서명"으로 출력하시오.
  단,커미션이 NULL인 것은 제외하고 출력(emp,dept,salgrade)
SELECT e.empno 사원번호,e.ename 사원이름,e.sal*12 연봉,e.sal+e.comm 실급여,s.grade 급여등급,d.dname 부서명
FROM emp e,dept d,salgrade s 
WHERE e.deptno=d.deptno AND e.sal BETWEEN s.losal AND s.hisal AND e.comm IS NOT NULL; --오라클전용 --JOIN 기준을 급여,실급여로 조인하라는 것을 말하지 않음 

SELECT e.empno 사원번호,e.ename 사원이름,e.sal*12 연봉,e.sal+e.comm 실급여,s.grade 급여등급,d.dname 부서명 --표준SQL
FROM emp e JOIN dept d ON e.deptno=d.deptno JOIN salgrade s 
ON e.sal BETWEEN s.losal AND s.hisal WHERE e.comm IS NOT NULL;
-- 3테이블 JOIN은 JOIN ON + JOIN ON형식으로 해야함



집합연산자

UNION : 합집합, 중복값 제거. 두 테이블의 결합을 나타내며, 결합시키는 두 테이블의 중복되지 않은 값들을 반환

SELECT deptno FROM emp
UNION
SELECT deptno FROM dept;

UNION ALL : UNION과 같으나 두 테이블의 중복되는 값까지 반환

SELECT deptno FROM emp
UNION ALL
SELECT deptno FROM dept;


INTERSECT : 교집합, 두행의 집합 중 공통된 행을 반호나

SELECT deptno FROM emp
INTERSECT
SELECT deptno FROM dept;


MINUS : 차집합, 첫번째 SELECT 문에 의해 반환되는 행 중에서 두번째 SELECT 문에 의해 반환되는 행에 존재하지 않는 행들을 보여줌

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;


**(중요)
SUBQUERY : 하나의 SQL 문장의 절에 NESTED된 SELECT문장

단일행 서브쿼리 : 오직 한 개의 행(값)을 반환

사원번호가 7369인 사람과 같은 직업을 가진 사람의 사원번호,이름을 출력
SELECT job FROM emp WHERE empno=7369;
SELECT empno,ename job FROM emp WHERE job = 'CLERK'; -- 두번 해야함. 아래처럼 한줄로 가능

SELECT empno,ename job FROM emp WHERE job = (SELECT  job FROM emp WHERE empno=7369); --서브쿼리, ()는 =로 연결되어있기 때문에 하나의 값, 하나의 컬럼이여야 한다.

SELECT empno,ename,sal FROM emp WHERE sal = (SELECT sal FROM emp WHERE ename='MARTIN'); --이름이 MARTIN인 사람과 같은 월급을 받는 사람을 출력, MARTIN이라는 중복값이 없어서 가능. 중복값이 없도록 조심해야함


다중행 서브쿼리 : 하나 이상의 행을 반환하는 서브쿼리

IN 연산자 사용
부서별로 가장 급여를 적게 받는 사원과 동일한 급여를 받는 사원의 정보를 출력
SELECT empno,ename,sal,deptno FROM emp WHERE sal IN (SELECT MIN(sal) FROM emp GROUP BY deptno); 


ANY(SOME) 연산자의 사용
ANY 연산자는 서브쿼리의 결과값 중 어느 하나의 값이라도 만족이 되면 결과값을 반환(OR와 같음)

SELECT sal FROM emp WHERE job='SALESMAN';
SELECT ename,sal FROM emp WHERE sal>1600 OR sal>1250 OR sal>1500;  --조건에 해당하는 값을 모두 반환

서브쿼리로 표시
SELECT ename,sal FROM emp WHERE sal> ANY(SELECT sal FROM emp WHERE job='SALESMAN');


ALL 연산자의 사용
서브 쿼리의 결과와 모든 값이 일치(AND와 같음)

SELECT sal FROM emp WHERE deptno=20;
SELECT empno,ename,sal,deptno FROM emp WHERE sal>800 AND sal>2975 AND sal>3000;

서브 쿼리로 표시
SELECT empno,ename,sal,deptno FROM emp WHERE sal>ALL(SELECT sal FROM emp WHERE deptno=20);


다중열 서브 쿼리
서브 쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인 쿼리에 전달하는 쿼리

SELECT empno,ename,sal,deptno FROM Emp WHERE (deptno,sal) IN(SELECT deptno,sal FROM emp WHERE deptno=30); --비교할 때 컬럼의 갯수가 같아야 함

부서별로 가장 급여를 적게 받는 사원의 정보를 출력
SELECT empno,ename,sal,deptno FROM emp WHERE (deptno,sal) IN (SELECT deptno,MIN(sal) FROM emp GROUP BY deptno);

인라인뷰 : 메인 쿼리의 FROM절을 서브 쿼리로 이용하는 방법
--()조건이 테이블 역할을 함
급여가 20번 부서의 평균 급여보다 많은 급여를 받는 사원의 사원번호,이름,부서명 출력
SELECT e.empno,e.ename,d.dname
FROM (SELECT * FROM emp WHERE sal>(SELECT AVG(sal) FROM emp WHERE deptno=20)) e JOIN dept d
USING(deptno);

SELECT e.empno,e.ename,d.dname FROM emp e JOIN dept d
USING(deptno) WHERE sal>(SELECT AVG(sal) FROM emp WHERE deptno=20);

부서별로 부서번호,부서명,급여총액을 출력하시오.
SELECT deptno,dname,total 
FROM dept JOIN (SELECT deptno,SUM(sal) total FROM emp GROUP BY deptno)
USING(deptno);


스칼라 서브 쿼리
*스칼라값이란 벡터값에 대응되는 말로 단일 값을 의미함
결과값이 단일 행, 단일 열의 스칼라값으로 반환된다. 만약 결과값이 다중 행이거나 다중열이라면 DBMS는 그 중 어떠한 행, 어떠한 열을 출력해야 하는 지 알 수 없어 에러를 출력.

스칼라 서브 쿼리 형태
SELECT deptno, (SELECT dname FROM dept WHERE deptno=e.deptno),SUM(sal)
FROM emp e GROUP BY deptno;

[실습문제]
1."BLAKE"와 같은 부서에 있는 사원들의 이름과 입사일을 구하는데 "BLAKE"는 제외하고 출력하시오.
SELECT ename,hiredate FROM emp 
WHERE deptno=(SELECT deptno FROM emp WHERE ename='BLAKE')
AND ename!='BLAKE';

BLACK가 여러명일 수 있음
SELECT ename,hiredate FROM emp 
WHERE deptno IN(SELECT deptno FROM emp WHERE ename='BLAKE') --IN사용해야함
AND ename!='BLAKE';

2.평균급여보다 많은 급여를 받는 사원들의 사원번호,이름,월급을 출력하는데 월급이 높은 사람순으로 출력하시오.
SELECT empno,ename,sal FROM emp WHERE sal>(SELECT AVG(sal) FROM emp) ORDER BY sal desc;

3.10번부서에서 급여를 가장 적게 받는 사원과 동일한 급여를 받는 사원의 이름과 월급을 출력하시오.
SELECT ename,sal FROM emp WHERE sal=(SELECT MIN(sal) FROM emp WHERE deptno=10); 

4.(부서별 사원수를 구하고) 사원수가 3명이하의 부서의 부서명과 사원수를 출력하시오.
--join
SELECT d.dname,COUNT(e.empno) cnt FROM emp e,dept d 
WHERE e.deptno(+)=d.deptno GROUP BY d.dname HAVING COUNT(e.empno)<=3;

--서브쿼리
SELECT a.dname,NVL(b.cnt,0) FROM dept a,(SELECT deptno,COUNT(empno) cnt FROM emp GROUP BY deptno) b  --NVL : null값 으로 변경
WHERE a.deptno=b.deptno(+) AND NVL(b.cnt,0)<=3;

5.사원번호가 7844인 사원보다 빨리 입사한 사원의 이름과 입사일을 출력하시오.
SELECT ename,hiredate FROM emp
WHERE hiredate<(SELECT hiredate FROM emp WHERE empno=7844);

6.직속상사(mgr)가 KING인 모든 사원의 이름과 급여를 출력하시오.
SELECT ename,sal FROM emp 
WHERE mgr IN(SELECT empno FROM emp WHERE ename='KING');

7.20번부서에서 가장 급여를 많이 받는 사원과 동일한 급여를 받는 사원의 이름과 부서명,급여,급여등급을 출력하시오.
SELECT e.ename,d.dname,sal,s.grade FROM emp e,dept d, salgrade s 
WHERE e.deptno=d.deptno AND e.sal BETWEEN s.losal AND s.hisal 
AND e.sal=(SELECT MAX(sal) FROM emp WHERE deptno=20);

8.총급여(sal+comm)가 평균 급여보다 많은 급여를 받는 사람의 부서번호,이름,총급여,커미션을 출력하시오.(커미션은 유(o),무(x)로 표시하고 컬럼명은 "comm유무"로 출력)
SELECT deptno,ename,sal+NVL(comm,0) 총급여,NVL2(comm,'O','X') comm유무 FROM emp WHERE sal+NVL(comm,0)>(SELECT AVG(sal) FROM emp);

SELECT deptno,ename,sal+NVL(comm,0) 총급여,
       CASE WHEN comm IS NOT NULL THEN 'O'
       ELSE 'X'
       END As COMM유무
FROM emp
WHERE sal+NVL(comm,0)>(SELECT AVG(sal) FROM emp);

9.CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 이름과 급여,지역명을 출력하시오.
SELECT e.ename,e.sal,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno 
AND sal>(SELECT AVG(sal) FROM emp e,dept d WHERE e.deptno=d.deptno AND d.loc='CHICAGO');

10.커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급을 출력하시오.
SELECT e.ename,s.grade FROM emp e, salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal 
AND e.sal = (SELECT MAX(sal) FROM emp WHERE comm IS NOT NULL);



INSERT문 : 테이블에 행을 삽입

전체 데이터 삽입[전체 컬럼 명시]
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (8000,'DENNIS','SALESMAN',7698,'99/01/22',1700,200,30);

전체 데이터 삽입[컬럼명 생략 가능]
INSERT INTO emp VALUES (8001,'SUNNY','SALESMAN',7698,'99/03/01',1000,300,30);

NULL 삽입 방법[값이 입력되지 않는 컬럼은 제외] --컬럼명 필수
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,deptno) --comm제외
VALUES (8002,'PETER','CLERK',7698,'99/05/01',1500,20);

NULL 삽입 방법[값이 입력되지 않는 컬럼을 제외하지 않을 경우]
INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (8003,'ANNIE','CLERK',7698,'99/06/01',1300,null,10);

날짜의 삽입
INSERT INTO emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
VALUES (8004,'MICHAEL','CLERK',7698,TO_DATE('99/07/01','YY/MM/DD'),1800,null,30); --둘 중 선택


UPDATE문 : 행 단위로 데이터 갱신

UPDATE emp SET mgr=7900 WHERE empno=8000; --empno:primary key라 안바꿈
UPDATE emp SET ename='MARIA',sal=2500,comm=500 WHERE empno=8000; --나열된 부분만 변경

[주의]WHERE절을 명시하지 않으면 전체행의 데이터가 변경
UPDATE emp SET ename='BLUE';
--ROLLBACK; 사용하여 돌리기가능, but 자바에서 한 경우 ROLLBACK 불가. DDL,DML문장 실행 전까지는 되돌리기 가능

DELETE문 : 행을 삭제

DELETE FROM emp WHERE empno=8004;

WHERE절을 명시하지 않으면 전체행 삭제
DELETE FROM emp;


트랜잭션 : 데이터 처리의 한 단위. 트랜잭션은 데이터를 일관되게 변경하는 DML 문장으로 구성됨

1)트랜잭션 시작 : 실행 가능한 SQL문장이 제일 처음 실행될 때
2)트랜잭션 끝 : COMMIT 이나 ROLLBACK,
               DDL 이나 DCL 문장의 실행(자동 COMMIT)
               기계 장애 또는 시스템 충돌
3)COMMIT과 ROLLBACK의 장점
1.데이터의 일관성을 제공
2.데이터를 영구적으로 변경하기 전에 데이터 변경을 확인하게 함
3.관련된 작업을 논리적으로 그룹화 함
4.COMMIT,ROLLBACK 문장으로 트랜잭션의 논리를 제어


데이터베이스 객체

테이블 : 기본적인 데이터 저장 단위, 레코드와 컬럼 구성
오라클 데이터베이스의 테이블 : 사용자 테이블,데이터 딕셔너리로 구성

- 사용자가 소유한 테이블의 이름
SELECT table_name FROM user_tables;

- 사용자가 소유한 개별 객체 유형
SELECT DISTINCT object_type FROM user_objects;

- 사용자가 소유한 테이블,뷰,동의어 및 시퀀스
SELECT * FROM user_catalog;

테이블의 생성
- 테이블 이름 : 만들어질 테이블의 이름
- 열 이름 : 테이블 내에 만들어질 열의 이름
- 데이터 타입 : 각각의 열은 자신의 데이터 타입
- default <표현식> : INSERT 구문에 열의 값이 지정되지 않은 경우에 이용될 디폴트 값 지정
- 제약조건 : 만들어질 각 열에 선택적으로 제약조건을정의

테이블 생성
CREATE TABLE employee(
 empno number(6),
 name varchar2(30) not null,
 salary number(8,2), --정수8자리,소숫점2자리
 hire_date date default SYSDATE,
 CONSTRAINT employee_pk primary key (empno) 
);

INSERT INTO employee (empno,name,salary) VALUES (100,'홍길동',1000.23);
COMMIT;
SELECT * FROM employee;


-PRIMARY KEY & FOREIGN KEY

CREATE TABLE suser(
 id varchar2(20),
 name varchar2(30),
 CONSTRAINT suser_pk primary key (id)
);

CREATE TABLE sboard(
 num number,
 id varchar(20) not null,
 content varchar2(4000) not null,
 CONSTRAINT sboard_pk primary key (num),
 CONSTRAINT sboard_fk foreign key (id) references suser (id)
);

INSERT INTO suser (id,name) VALUES ('SKY','홍길동');
INSERT INTO suser (id,name) VALUES ('BLUE','박문수');
INSERT INTO suser (id,name) VALUES ('ONE','장영실');
COMMIT;

SELECT * FROM suser;

INSERT INTO sboard (num,id,content) VALUES (1,'SKY','하하');
INSERT INTO sboard (num,id,content) VALUES (2,'BLUE','호호');
INSERT INTO sboard (num,id,content) VALUES (3,'ONE','크크');
COMMIT;

SELECT *FROM sboard;

FOREIGN KEY 제약조건이 적용되어서 자식 데이터가 있을 경우 부모 데이터 삭제 불가
DELETE FROM suser WHERE id='SKY'; --자식데이터가 있어서 부모데이터인 SKY를 못지움



테이블 관리

ADD연산자 : 테이블에 새로운 컬럼 추가
ALTER TABLE employee ADD (addr varchar2(50));

제약 조건 추가
ALTER TABLE employee ADD CONSTRAINT employee_pk primary key (empno); --이미있어서 에러. 없을 경우 이렇게 추가

MODIFY연산자 : 테이블의 칼럼을 수정하거나 NOT NULL 컬럼으로 변경할 수 있음
ALTER TABLE employee MODIFY (salary number(10,2) not null);

DROP연산자 : 컬럼의 삭제
ALTER TABLE employee DROP COLUMN name;

컬럼명 변경
ALTER TABLE employee RENAME COLUMN salary TO sal;

테이블명 변경
RENAME employee TO employee2;

테이블 삭제
DROP TABLE employee2;

ON DELETE CASCADE : 부모 테이블의 컬럼을 삭제하면 자식 테이블의 자식 데이터를 모두 삭제

CREATE TABLE s_member(
 id varchar2(20) primary key,
 name varchar2(30)
);

CREATE TABLE s_member_detail(
 num number primary key,
 content varchar2(4000) not null,
 id varchar2(20) not null references s_member (id) ON DELETE CASCADE
);

INSERT INTO s_member (id,name) VALUES ('SKY','홍길동');
INSERT INTO s_member (id,name) VALUES ('BLUE','박문수');
INSERT INTO s_member (id,name) VALUES ('ONE','장영실');
COMMIT;

INSERT INTO s_member_detail (num,content,id) VALUES (1,'하하','SKY');
INSERT INTO s_member_detail (num,content,id) VALUES (2,'호호','SKY');
INSERT INTO s_member_detail (num,content,id) VALUES (3,'크크','SKY');
COMMIT;

SELECT * FROM s_member;
SELECT * FROM s_member_detail;

ON DELETE CASCADE로 설정된 테이블은 부모 데이터를 삭제하면 자식 데이터를 함께 삭제함
DELETE FROM s_member WHERE id='SKY';

[실습문제]
1.student라는 이름으로 테이블 생성
컬럼명     id           name         age       score
데이터타입 varchar2(10) varchar2(30) number(3) number(3)
제약조건   primary key  not null     not null  not null

CREATE TABLE student(
 id varchar2(10) primary key,
 name varchar2(30) not null,
 age number(3) not null,
 score number(3) not null
);

2. 데이터 입력
id      name   age   score
dragon  홍길동  21    100       
sky     장영실  22    99
blue    박문수  34    88

INSERT INTO student(id,name,age,score) VALUES ('dragon','홍길동',21,100);
INSERT INTO student(id,name,age,score) VALUES ('sky','장영실',22,99);
INSERT INTO student(id,name,age,score) VALUES ('blue','박문수',34,88);
COMMIT;

3.데이터 읽기
student 테이블에서 성적 합계를 구하시오.
SELECT SUM(score) FROM student;

[실습문제]
1.SMITH의 직속상사(mgr)의 이름과 부서명,근무지역을 출력하시오.
SELECT e.ename,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno 
AND mgr IN(SELECT mgr FROM emp WHERE ename='SMITH');

SELECT e.ename,d.dname,d.loc FROM emp e JOIN dept d USING(deptno)
WHERE e.empno IN(SELECT mgr FROM emp WHERE ename='SMITH');

2.ALLEN보다 급여를 많이 받는 사람 중에서 입사일이 가장 빠른 사원과 동일한 날짜에 입사한 사원의 입사일,급여를 출력하시오
SELECT ename,hiredate,sal FROM emp 
WHERE hiredate=(SELECT MIN(hiredate) FROM emp 
                WHERE sal>all(SELECT sal FROM emp WHERE ename='ALLEN'));
 

3.10번 부서에서 근무하는 사원들의 부서번호,부서이름,사원이름,월급,급여등급을 출력하시오.
[ORACLE 전용]
SELECT e.deptno,d.dname,e.ename,e.sal,s.grade 
FROM emp e,dept d,salgrade s 
WHERE e.deptno=d.deptno 
AND e.sal BETWEEN s.losal AND s.hisal 
AND e.deptno=10;

[표준SQL]
SELECT e.deptno,d.dname,e.ename,e.sal,s.grade 
FROM emp e INNER JOIN dept d --INNER 생략가능 
ON e.deptno=d.deptno
INNER JOIN salgrade s 
ON e.sal BETWEEN s.losal AND s.hisal 
WHERE e.deptno=10;



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

CREATE OR REPLACE VIEW emp30_view AS
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












