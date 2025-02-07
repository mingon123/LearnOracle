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
누락된 행의 방향 표시 --한눈에 보기 쉬워 좋음
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



