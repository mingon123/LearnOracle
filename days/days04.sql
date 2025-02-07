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
VALUES (8004,'MICHAEL','CLERK',7698,TO_DATE('99/07/01','YY/MM/DD'),1800,null,30);


UPDATE문 : 행 단위로 데이터 갱신

UPDATE emp SET mgr=7900 WHERE empno=8000; --empno:primary key라 안바꿈
UPDATE emp SET ename='MARIA',sal=2500,comm=500 WHERE empno=8000;

[주의]WHERE절을 명시하지 않으면 전체행의 데이터가 변경
UPDATE emp SET ename='BLUE';


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
 salary number(8,2), --양수8자리,소숫점2자리
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
AND mgr IN(SELECT m.mgr FROM emp e,emp m WHERE e.mgr=m.empno 
AND e.ename='SMITH');

2.ALLEN보다 급여를 많이 받는 사람 중에서 입사일이 가장 빠른 사원과 동일한 날짜에 입사한 사원의 입사일,급여를 출력하시오
SELECT hiredate,sal FROM emp 
WHERE sal>(SELECT sal FROM emp WHERE ename='ALLEN') 
AND hiredate=(SELECT MIN(hiredate) FROM emp);

3.10번 부서에서 근무하는 사원들의 부서번호,부서이름,사원이름,월급,급여등급을 출력하시오.
[ORACLE 전용]
SELECT e.deptno,d.dname,e.ename,e.sal,s.grade FROM emp e,dept d,salgrade s 
WHERE e.deptno=d.deptno AND e.sal BETWEEN s.losal AND s.hisal 
AND e.deptno=10;

[표준SQL]














