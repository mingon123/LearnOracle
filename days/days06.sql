커서
SELECT 문장을 실행하면 조건에 따른 결과가 추출. 추출된 결과를 결과 셋(result set) 또는 결과집합.
커서(cursor)를 이용해서 결과집합에 접근

declare
 cursor emp_csr is
 SELECT empno FROM emp WHERE deptno=10;

 emp_no emp.empno%type;
begin
 open emp_csr;
 
 loop
  fetch emp_csr into emp_no;
  --%notfound : 커서에서만 사용 가능한 속성(더 이상 패치(할당)할 행이 없음을 의미)
  exit when emp_csr%notfound;
  
  dbms_output.put_line(emp_no);
 end loop;
 close emp_csr;
end;



PL/SQL 서브프로그램

함수
-- is,begin,end구조

입력받은 값으로부터 10%의 세율을 얻는 함수
create or replace function tax(p_value in number)
 return number
is
begin
 return p_value * 0.1;
end;

SELECT TAX(100) FROM dual;
SELECT ename,sal,TAX(sal) tax,sal-TAX(sal) "실지급 급여" FROM emp;

급여와 커미션을 합쳐서 세금 계산
create or replace function tax2(p_sal in emp.sal%type,
                                p_bonus in emp.comm%type)     
 return number
is
begin
 return (p_sal + NVL(p_bonus,0)) * 0.1;
end;

SELECT empno,ename,sal,comm,sal+NVL(comm,0) 실급여,TAX2(sal,comm) TAX FROM emp;

급여(커미션 포함)에 대한 세율을 다음과 같이 정의함.급여가 월 $1,000보다 적으면 세율을 5% 적용하며,$1,000이상 $2,0000이하면 10%,$2,000을 초과하면 20%를 적용함
create or replace function tax3(p_sal in emp.sal%type,
                                p_bonus emp.comm%type)
 return number
is
 e_sum number;
 e_tax number;
begin
 e_sum := p_sal + NVL(p_bonus,0);
 
 if e_sum < 1000 then
  e_tax := e_sum * 0.05;
 elsif e_sum <= 2000 then
  e_tax := e_sum * 0.1;
 else
  e_tax := e_sum * 0.2;
 end if;
 
 return e_tax;
end;

SELECT empno,ename,sal,comm,TAX3(sal,comm) AS tax FROM emp;

사원번호를 통해서 급여를 알려주는 함수
create or replace function emp_salaries(emp_no number)
 return number
is
 nSalaries number(9);
begin
 SELECT sal
 --결과행이 단일행일 경우 INTO를 이용해서 읽어온 값을 변수에 담을 수 있음(행이 여러개면 에러)
 INTO nSalaries
 FROM emp
 WHERE empno=emp_no;
 
 return nSalaries;
end;

SELECT EMP_SALARIES(7839) FROM dual;
SELECT empno,ename,emp_salaries(empno) FROM emp WHERE deptno=10;

부서번호를 전달하면 부서명을 구할 수 있는 함수
create or replace function get_dept_name(dept_no number)
 return varchar2 --사이즈명시X
is
 sDeptName varchar2(30);
begin
 SELECT dname INTO sDeptName
 FROM dept WHERE deptno=dept_no;
 
 return sDeptName;
end;

SELECT GET_DEPT_NAME(10) FROM dual;
SELECT deptno,GET_DEPT_NAME(deptno) "Department Name" FROM dept;
SELECT empno,ename,sal,GET_DEPT_NAME(deptno) "Department Name" FROM emp; --함수를 만들면 join하지 않아도 됨

생성된 함수 확인하기
SELECT object_name,object_type FROM user_objects
WHERE object_type='FUNCTION';


작성된 함수의 소스 코드 확인
SELECT text FROM user_source
WHERE type='FUNCTION' AND name='TAX';
-- type=? AND name=?


[실습문제]
1.두 숫자를 제공하면 덧셈을 해서 결과값을 반환하는 함수(add_num)를 정의하시오.
create or replace function add_num(num1 integer,
                                   num2 integer) --number도 가능
 return integer
is
begin
 return num1+num2;
end;

SELECT add_num(2,5) FROM dual;
SELECT ename,ADD_NUM(sal,NVL(comm,0)) 실급여 FROM emp;

2)부서번호를 입력하면 해당 부서에서 근무하는 사원수를 반환하는 함수를 정의하시오(get_emp_count)
create or replace function get_emp_count(dept_no emp.deptno%type)
 return number
is
 emp_count number;
begin
 SELECT COUNT(empno) INTO emp_count 
 FROM emp WHERE deptno=dept_no;
 return emp_count;
end;

SELECT deptno,dname,GET_EMP_COUNT(deptno) 사원수 FROM dept;

3)emp테이블의 입사일을 입력하면 근무연차를 구하는 함수를 정의하시오.(소수점 자리 절삭)(get_info_hiredate)
create or replace function get_info_hiredate(hire_date emp.hiredate%type)
 return NUMBER
is
begin
 return TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date)/12); 
end;

SELECT ename,get_info_hiredate(hiredate) FROM emp;

4)emp테이블을 이용해서 사원번호를 입력하면 해당 사원의 관리자를 구하는 함수를 정의하시오.(get_mgr_name)
create or replace function get_mgr_name(emp_no emp.empno%type)
 return varchar2
is
 m_name varchar2(10);
begin
 --서브쿼리 이용
 SELECT ename INTO m_name 
 FROM emp WHERE empno=(SELECT mgr FROM emp WHERE empno=emp_no); 
 return m_name;
end;

--JOIN 이용(INNER JOIN). 없는 데이터는 null로 반환
create or replace function get_mgr_name(emp_no emp.empno%type)
 return varchar2
is
 m_name varchar2(10);
begin
 SELECT m.ename INTO m_name 
 FROM emp e JOIN emp m ON e.mgr=m.empno 
 WHERE e.empno=emp_no;
 return m_name;
end;

SELECT empno,ename,GET_MGR_NAME(empno) "관리자 이름" FROM emp;

5)emp테이블을 이용해서 사원번호를 입력하면 급여 등급을 구하는 함수를 정의하시오.(get_sal_grade)
--표준SQL사용
create or replace function get_sal_grade(emp_no emp.empno%type)
 return number
is
 s_grade number;
begin
 SELECT s.grade INTO s_grade
 FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
 WHERE e.empno=emp_no;
 return s_grade;
end;
--Oracle전용
create or replace function get_sal_grade(emp_no emp.empno%type)
 return number
is
 sgrade number;
begin
 SELECT s.grade INTO sgrade
 FROM emp e,salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal 
 AND e.empno=emp_no;
 return sgrade;
end;

----------salgrade테이블 없을 경우
create or replace function get_sal_grade(emp_no emp.empno%type)
 return varchar
is
 sgrade char(1);
begin
 SELECT CASE WHEN sal>=4000 THEN 'A'
             WHEN sal>=3000 AND sal<4000 THEN 'B'
             WHEN sal>=2000 AND sal<3000 THEN 'C'
             WHEN sal>=1000 AND sal<2000 THEN 'D'
             ELSE 'F'
        END grade
 INTO SGRADE
 FROM emp WHERE empno=emp_no;
 return sgrade;
end;

SELECT ename,sal,GET_SaL_GRADE(empno) "급여 등급" FROM emp; 




프로시저
--PL/SQL에서 반환하는 경우만 함수,반환없으면 프로시저
create or replace procedure hello_world
is
 message varchar2(100);
begin
 message := 'Hello World';
 dbms_output.put_line(message);
end;


프로시저 실행
EXEC 혹은 EXECUTE 프로시저명(파라미터...);

exec hello_world;

create or replace procedure hello_world(p_message in varchar2)
is
begin
 dbms_output.put_line(p_message);
end;

exec hello_world('Korea');


작성된 Stored Procedure 확인
SELECT object_name,object_type
FROM user_objects
WHERE object_type = 'PROCEDURE'; --대소문자 구분O

Stored Procedure의 Source를 데이터 사전을 이용해서 얻음
SELECT text FROM user_source
WHERE name = 'HELLO_WORLD';


부서테이블에 부서정보를 입력하는 프로시저를 생성
create or replace procedure add_department(p_deptno in dept.deptno%type,
                                           p_dname in dept.dname%type,
                                           p_loc in dept.loc%type)
is
begin
 INSERT INTO dept VALUES (p_deptno,p_dname,p_loc);
 COMMIT;
 exception when others then
  dbms_output.put_line(p_dname || ' register is failed');
  ROLLBACK;
end;

exec add_department(60,'IT SERVICE','BUSAN');


사원테이블에 사원정보를 저장
create or replace procedure register_emp(e_no number,
                                         e_name varchar2,
                                         e_job varchar2,
                                         e_mgr number,
                                         e_sal number,
                                         e_comm number,
                                         e_deptno number)
is
begin
 INSERT INTO emp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
 VALUES (e_no,e_name,e_job,e_mgr,SYSDATE,e_sal,e_comm,e_deptno);
 COMMIT; --정상이면 COMMIT아니면 아래
 exception when others then
  dbms_output.put_line(e_name || ' register is failed');
  ROLLBACK;
end;

exec register_emp(9000,'PETER','MANAGER',7902,6000,200,30);


부서번호를 통해서 부서명과 부서의 위치 구하기
create or replace procedure output_department(p_dept_no in dept.deptno%type)
is
 d_dname dept.dname%type;
 d_loc dept.loc%type;
begin --2개이상이면 순서대로 입력
 SELECT dname,loc INTO d_dname,d_loc 
 FROM dept WHERE deptno=p_dept_no;
 dbms_output.put_line(d_dname || ', ' || d_loc); --읽어오기만 하기 때문에 exception 생략 가능
end;

exec output_department(10);


입력한 입사연도에 입사한 사원의 사원번호와 사원명을 출력
create or replace procedure info_hiredate(p_year in varchar2)
is
 --%rowtype으로 데이터 타입이 지정되어 있는 emp의 하나의 행이 가지는 모든 컬럼의 데이터 타입을 가져옴
 e_emp emp%rowtype;
begin
 SELECT empno,ename,sal INTO e_emp.empno,e_emp.ename,e_emp.sal
 FROM emp WHERE TO_CHAR(hiredate,'YYYY')=p_year;
 
 dbms_output.put_line(e_emp.empno || ' ' || e_emp.ename || ' ' || e_emp.sal);
end;

하나의 행이 반환되어 에러가 발생하지 않음
exec info_hiredate('1980');
여러개의 행이 반환되어 에러 발생
exec_info_giredate('1981'); --fetch사용해야함


--커서 이용하기
입력한 입사연도에 입사한 사원의 사원번호와 사원명을 출력(커서 이용하기)
create or replace procedure info_hiredate(p_year in varchar2)
is
 --%rowtype으로 데이터 타입이 지정되어 있는 emp의 하나의 행이 가지는 모든 컬럼의 데이터 타입을 가져옴
 e_emp emp%rowtype;
 --커서 선언
 cursor emp_cur is
 SELECT empno,ename,sal
 FROM emp WHERE TO_CHAR(hiredate,'YYYY')=p_year;
begin
 open emp_cur;
 loop
  fetch emp_cur into e_emp.empno,e_emp.ename,e_emp.sal; --행이 있을 경우 무한반복
  exit when emp_cur%notfound; --값이 없을 경우 빠져나감
  dbms_output.put_line(e_emp.empno || ' ' || e_emp.ename || ' ' || e_emp.sal);
 end loop;
 close emp_cur;
end info_hiredate; --생략가능

exec info_hiredate('1981');


'SALES' 부서에 속한 사원의 정보 보기 --JOIN이 되어있어야함, 값이 여러개(cursor사용 필수)
create or replace procedure emp_info(p_dept dept.dname%type)
is
 cursor emp_cur is
 SELECT empno,ename FROM emp e JOIN dept d
 ON e.deptno=d.deptno WHERE dname = UPPER(p_dept);
 
 e_emp_no emp.empno%type;
 e_emp_name emp.ename%type;
begin
 open emp_cur;
 
 loop
  fetch emp_cur into e_emp_no,e_emp_name;
  exit when emp_cur%notfound;
  dbms_output.put_line(e_emp_no || ' ' || e_emp_name);
 end loop;
 close emp_cur;
end;

exec emp_info('SALES');


테이블 생성
create table book(
 bookid number primary key,
 bookname varchar2(60) not null,
 publisher varchar2(60) not null,
 price number not null
);

동일한 도서가 있는지 점검한 후 동일한 도서가 없으면 삽입하고 동일한 도서가 있으면 가격을 업데이트하는 프로시저를 작성하시오.
create or replace procedure change_book_info(mybookid number,
                                             mybookname varchar2,
                                             mypublisher varchar2,
                                             myprice number)
is
 mycount number;
begin
 SELECT COUNT(*) INTO mycount FROM book
 WHERE bookname = mybookname; --일치하는것만 카운트
 
 if mycount!=0 then
  --동일한 도서명을 갖고 있는 행이 존재하면 UPDATE
  UPDATE book SET price = myprice
  WHERE bookname = mybookname;
 else
  --동일한 도서명을 갖고 있는 행이 존재하지 않으면 INSERT
  INSERT INTO book (bookid,bookname,publisher,price)
  VALUES (mybookid,mybookname,mypublisher,myprice);
 end if;
 COMMIT;
 exception when others then
  dbms_output.put_line('Errors');
  ROLLBACK;
end;

exec change_book_info(1,'자바의 정석','자바 천국',15000); --같은데이터면 변경,없으면추가


[실습문제]
1.업무를 입력하여 해당 업무를 수행하는 사원들의 사원번호,이름,급여,업무를 출력(job_info)
create or replace procedure job_info(p_job emp.job%type)
is
 cursor emp_cur is
 SELECT empno,ename,sal,job
 FROM emp WHERE job = p_job;

 e_emp emp%rowtype;
begin
 open emp_cur;
 loop
  fetch emp_cur into e_emp.empno,e_emp.ename,e_emp.sal,e_emp.job;
  exit when emp_cur%notfound;
  dbms_output.put_line(e_emp.empno || ',' || e_emp.ename || ',' || e_emp.sal || ',' || e_emp.job);
 end loop;
 close emp_cur;
end;

exec job_info('MANAGER'); --대문자 필수


2.사원번호와 새 업무를 입력하면 emp테이블의 해당 사원의 업무를 갱신할 수 있는 프로시저를 작성
create or replace procedure change_job(e_no emp.empno%type,
                                       e_job emp.job%type)
is
begin
 UPDATE emp SET job=e_job WHERE empno=e_no;
 COMMIT;
 exception when others then
  dbms_output.put_line(e_no || ' update is failed ');
  ROLLBACK;
end;

exec change_job(7369,'DRIVER');


3.사원번호를 입력하면 근무지를 구하는 함수(find_loc)
create or replace function find_loc(emp_no number)
 return varchar2
is
 dept_loc varchar2(14);
begin
 SELECT loc INTO dept_loc
 FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE empno=emp_no);
 return dept_loc;
end;

SELECT FIND_LOC(7698) FROM dual;
SELECT empno,ename,FIND_LOC(empno) FROM emp;


4.부서 이름을 입력하면 해당 부서의 사원에 대해 급여가 많은 순으로 정보를 제공 프로시저(emp_salary_info). 출력 컬럼->empno,ename,sal
create or replace procedure emp_salary_info(p_dept dept.dname%type)
is
 cursor emp_cur is
 SELECT empno,ename,sal
 FROM emp e JOIN dept d
 ON e.deptno=d.deptno
 WHERE d.dname = UPPER(p_dept)
 ORDER BY sal DESC;

 e_emp emp%rowtype;
begin
 open emp_cur;
  loop
   fetch emp_cur into e_emp.empno,e_emp.ename,e_emp.sal;
   exit when emp_cur%notfound;
   dbms_output.put_line(e_emp.empno || ' ' || e_emp.ename || ' ' || e_emp.sal);
  end loop;
 close emp_cur;
end;

exec emp_salary_info('SALES');




