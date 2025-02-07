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

함수 중첩 가능
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
SELECT TO_CHAR(1234,'L0000') FROM dual; --$제외는 시스템의 문자를 기준을 통화표시

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

SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp; --여러 그룹함수를 하나의 행으로 연산 가능
SELECT MAX(sal),MIN(sal),ROUND(AVG(sal)),SUM(sal) FROM emp WHERE deptno = 10;
SELECT COUNT(*) FROM emp WHERE deptno=20; --사원수라고도 할 수 있음
SELECT COUNT(empno) FROM emp WHERE deptno=30; --null값이 있는 컬럼은 제대로 안나옴


GROUP BY & HAVING

SELECT에서 집합함수 적용시 개별 컬럼을 지정할 수 없다.
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






