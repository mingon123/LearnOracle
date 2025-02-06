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








