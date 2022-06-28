/*
Java에서 처음으로 JDBC 프로그래밍 해보기
*/
--우선 system계정을 연결한 후 새로운 계정을 생성한다.
CREATE USER kosmo IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO kosmo;

--계정을 생성한 후 접속창에 kosmo 계정을 등록하고 해당 문서에 연결한다.
--회원관리 테이블 : member 생성

create table member
(
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    regidate date default sysdate,
    primary key (id)
);

--더미데이터 입력하기
insert into member (id, pass, name) values ('test','1234','테스트');
select * from member;
commit;

/*
The change of record occurred within Oracle cannot be checked immediately from outside
반드시 commit명령을 통해 임시테이블의 내용을 실제 테이블로 옮기는 작업이 필요하다
즉, insert, update, delete를 수행한 이후에는 commit해야 한다.
*/
insert into member (id, pass, name) values ('dummy','1234','나는더미');
select * from member;
commit;

update member set pass='9x9x' where id='test2';
select * from member;
commit;

--해당 계정에 생성된 제약조건 확인 
select * from user_constraints;

--like를 이용한 검색 쿼리
select * from member where name like '%겸%';
-------------------------------------------------------
--JDBC > CallableStatement 인터페이스 사용하기

--substr(문자열 혹은 컬럼, 시작인덱스, 길이) : 시작인덱스부터 길이만큼 잘라낸다.

select substr('hongildong',1,1) from dual;
--rpad(문자열 혹은 컬럼, 길이, 문자) : 문자열의 남은 길이만큼을 문자로 채워준다.
--문자열(아이디)의 첫글자를 제외한 나머지 부분을 *로 채워준다. 
select rpad('h',10,'*') from dual;
select rpad(substr('hongildong',1,1), length('hongildong'), '*') from dual;

select rpad(substr('hongildong',1,),length('hongildong'), '*')
    from dual;
/*
시나리오] 매개변수로 회원아이디(문자열)을 받으면 첫문자를 제외한 나머지부분을
*로 변환하는 함수를 생성하시오
    실행 예)  kosmo->k****
*/
create or replace function fillAsterik (
    idStr varchar2 /*매개변수는 문자형으로 설정*/
    )
return varchar2 /*반환값 문자형으로 설정 */
is retStr varchar2(50); /*변수생성:반환값을 저장할것임*/
begin
    --문자열의 우측부분을 *로 채워준다.
    retStr := rpad(substr(idStr,1,1) , length(idStr), '*');
    return retStr;
end;
/

select fillAsterik('kosmo') from dual;
select fillAsterik('nakjasabal') from dual;

/*
시나리오] member 테이블에 새로운 회원정보를 입력하는 프로시저를 생성하시오
    입력값 : 아이디, 패스워드, 이름
*/
create or replace procedure KosmoMemberInsert(
        p_id in varchar2,
        p_pass in varchar2,
        p_name in varchar2, /*Java에서 전달한 인자를 받을 인파라미터*/
        returnVal out number /* 입력성공여부 확인*/
    )
is 
begin
    --인파라미터를 통해 insert 쿼리문 작성
    insert into member (id, pass, name)
        values (p_id, p_pass, p_name);
    --입력이 정상적으로 처리되었다면...
    if sql%found then
        --성공한 행의 갯수를 얻어와서, 아웃파라미터에 저장한다.
        returnVal := sql%rowcount;
        commit;
    else
        --실패한 경우에는 0을 반환한다.
        returnVal := 0;
    end if;
end;
/
set serveroutput on;
select * from user_source where name like upper('%kosmomem%');
--바인드 변수 생성 
var insert_count number;
execute KosmoMemberInsert('pro1','p1234','프로시저1',:insert_count);
--결과확인
print insert_count;
--입력된 정보 확인 
select * from member;

/*
시나리오] member테이블에서 레코드를 삭제하는 프로시저를 생성하시오
    매개변수 : In => member_id(아이디)
                Out => returnVal(SUCCESS/FAIL 반환)
*/
create or replace procedure KosmoMemberDelete(
    member_id in varchar2,
    returnVal out varchar2
    )
is -- 변수가 필요없는 경우 생략가능
begin
    --인파라미터를 통해 delete쿼리문 작성
    delete from member where id = member_id;
    
    
    if SQL%Found then
        --회원 레코드가 정상적으로 삭제되었다면 
        returnVal := 'SUCCESS';
        --커밋한다
        commit;
    else
        --조건에 일치하는 레코드가 없는 경우 FAIL을 반환한다.
        returnVal := 'FAIL';
    end if;
end;
/
set serveroutput on;
var delete_var varchar2(10);
execute KosmoMemberDelete('test99', :delete_var);
execute KosmoMemberDelete('pro01', :delete_var);
print delete_var;


/*
시나리오] 아이디와 패스워드를 매개변수로 전달받아서 회원인지 여부를
판단하는 프로시저를 작성하시오. 

    매개변수 : 
        In -> user_id, user_pass
        Out -> returnVal
    반환값 : 
        0 -> 회원인증실패(둘다틀림)
        1 -> 아이디는 일치하나 패스워드가 틀린경우
        2 -> 아이디/패스워드 모두 일치하여 회원인증 성공
    프로시저명 : KosmoMemberAuth
*/

create or replace procedure KosmoMemberAuth(
    user_id in varchar2,
    user_pass in varchar2,
    returnVal out number
)
is
    -- count(*)를 통해 반환되는 값을 저장한다.
    member_count number(1) := 0;
    -- 조회한 회원정보의 패스워드를 저장한다.
    member_pw varchar2(50);
begin
    --해당 아이디가 존재하는지 판단하는 select문 작성
    select count(*) into member_count
    from member where id=user_id;
    
    --회원아이디가 존재하는 경우
    if member_count=1 then
        --패스워드 확인을 위해 두번째 쿼리를 실행
        select pass into member_pw 
            from member where id=user_id;
        
        --인파라미터로 전달된 비번과 DB에서 가져온 비번을 비교
        if member_pw=user_pass then
            returnVal := 2; --아이디/비밀번호 모두 일치
        else
            returnVal := 1; --비밀번호 틀림
        end if;
    else
        returnVal := 0; --회원정보가 없음
    end if;
end;
/

--정보없음, 아이디만일치, 둘다일치의 3가지 케이스를 모두 테스트 해볼 것
variable member_auth number;
select * from member;
execute KosmoMemberAuth('yugyeom', '1234', :member_auth);
print member_auth;
execute KosmoMemberAuth('test','1234패스워드틀림',:member_auth);
print member_auth;
execute KosmoMemberAuth('test','3434', :member_auth);
print member_auth;



/*
JSP에서 JDBC 실습하기
-새로운 계정 생성 및 권한 부여하기
*/

--System계정으로 변경한 후 계정과 권한을 부여해주세요


--계정생성
CREATE USER musthave IDENTIFIED BY 1234;
--Role(롤)을 통해서 접속권한과 테이블생성 권한 부여
GRANT CONNECT, RESOURCE TO musthave;


--musthave 계정으로 변경한 후 테이블 및 외래키를 생성해주세요.


--회원관리 테이블 
create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key (id)
);

--게시판 테이블(모델1 방식에서 사용)
create table board (
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);

--board 테이블이 member테이블을 참조하는 외래키(참조키) 생성
alter table board
    add constraint board_mem_fk foreign key (id)
    references member (id);
    
--시퀀스 생성(게시판 일련번호 입력시 자동증가값으로 사용함)
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
--더미데이터 입력하기
insert into member (id,pass,name) values ('musthave','1234','머스트해브');
insert into board (num,title,content,id,postdate,visitcount)
    values (seq_board_num.nextval, '제목1입니다','내용1입니다','musthave',sysdate,0);
commit;


select * from board;
delete from member where id='test1';
commit;





create table mvcboard (
    idx number primary key,
    name varchar2(50) not null,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    postdate date default sysdate not null,
    ofile varchar2(200),
    sfile varchar2(30),
    downcount number(5) default 0 not null,
    pass varchar2(50) not null,
    visitcount number default 0 not null
);



insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '김유신', '자료실 제목1 입니다.', '내용','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '장보고', '자료실 제목2 입니다.', '내용','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '이순신', '자료실 제목3 입니다.', '내용','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '강감찬', '자료실 제목4 입니다.', '내용','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '대조영', '자료실 제목5 입니다.', '내용','1234');

commit;


--게시물의 갯수 카운트
select count(*) from mvcboard;

select count(*) from mvcboard where name like '%대조%';



--로그인(회원인증)을 위한 쿼리문
--시나리오] musthave/1234라는 회원정보가 있는지 확인하시오
select * from member where id='musthave' and pass='1234';
select count(*) from member where id='musthave' and pass='1234';


--패스워드 검증을 위한 쿼리문
--시나리오]108번 게시물의 비밀번호가 1234인지 검증하시오
select * from mvcboard where idx=108 and pass='1234';

select * from mvcboard;
--게시물 삭제하기
--시나리오]108번 게시물을 삭제하시오.
delete from mvcboard where idx=108 and pass='1236';--삭제 안됨. 비밀번호 틀림
delete from mvcboard where idx=108 and pass='1234';--삭제 성공.

commit;


--게시물 수정하기
/*
회원제 게시판에서는 작성자의 아이디가 패스워드의 역할을 하게되므로
회원인증만 되면 수정 혹은 삭제처리를 해주면 된다.
하지만 비회원제 게시판에서는 패스워드를 통한 검증이 필수적이므로
수정시 패스워드에 대한 조건을 하나 더 추가해서 패스워드 검증이 끝난
게시물에 대해서만 삭제처리 될 수 있도록 해야한다.
*/
update mvcboard set title='제목수정',content='내용수정',name='수정이름',ofile='', sfile=''
where idx =114 and  pass='1234';






select * from myfile;

create table myfile(
    idx number primary key,
    name varchar2(50) not null,
    title varchar2(200) not null,
    cate varchar2(100),
    ofile varchar2(100) not null,
    sfile varchar2(30) not null,
    postdate date default sysdate not null
);
commit;



-- 개인프로젝트 
-- 멤버 테이블
create table memberp(
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    gender varchar2(3) not null,
    email varchar2(25),
    phonenum varchar2(25),
    regidate date default sysdate not null,
    birthday date not null,
    primary key (id) 
);


insert into memberp (id,pass,name,gender,email,phonenum,birthday)
    values ('admin','1234','관리자','M','admin@admin.com','01012345678','1992-04-15');
select count(*) from memberp;
select * from memberp;


insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '김유신', '자료실 제목1 입니다.', '내용','1234');

drop table memberp;

commit;



