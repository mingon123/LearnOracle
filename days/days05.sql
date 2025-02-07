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
SQL> DROP USER user02; --테이블에 내용이 있어서 삭제 불가

USER02 유저가 객체를 소유하고 있을 경우에는 CASCADE 옵션을 추가해서 삭제
SQL> drop user user02 CASCADE; --여기선 안되는데 일반적으로는 가능































