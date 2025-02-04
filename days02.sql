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





