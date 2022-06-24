/*
Java���� ó������ JDBC ���α׷��� �غ���
*/
--�켱 system������ ������ �� ���ο� ������ �����Ѵ�.
CREATE USER kosmo IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO kosmo;

--������ ������ �� ����â�� kosmo ������ ����ϰ� �ش� ������ �����Ѵ�.
--ȸ������ ���̺� : member ����

create table member
(
    id varchar2(30) not null,
    pass varchar2(40) not null,
    name varchar2(50) not null,
    regidate date default sysdate,
    primary key (id)
);

--���̵����� �Է��ϱ�
insert into member (id, pass, name) values ('test','1234','�׽�Ʈ');
select * from member;
commit;

/*
The change of record occurred within Oracle cannot be checked immediately from outside
�ݵ�� commit����� ���� �ӽ����̺��� ������ ���� ���̺�� �ű�� �۾��� �ʿ��ϴ�
��, insert, update, delete�� ������ ���Ŀ��� commit�ؾ� �Ѵ�.
*/
insert into member (id, pass, name) values ('dummy','1234','���´���');
select * from member;
commit;

update member set pass='9x9x' where id='test2';
select * from member;
commit;

--�ش� ������ ������ �������� Ȯ�� 
select * from user_constraints;

--like�� �̿��� �˻� ����
select * from member where name like '%��%';
-------------------------------------------------------
--JDBC > CallableStatement �������̽� ����ϱ�

--substr(���ڿ� Ȥ�� �÷�, �����ε���, ����) : �����ε������� ���̸�ŭ �߶󳽴�.

select substr('hongildong',1,1) from dual;
--rpad(���ڿ� Ȥ�� �÷�, ����, ����) : ���ڿ��� ���� ���̸�ŭ�� ���ڷ� ä���ش�.
--���ڿ�(���̵�)�� ù���ڸ� ������ ������ �κ��� *�� ä���ش�. 
select rpad('h',10,'*') from dual;
select rpad(substr('hongildong',1,1), length('hongildong'), '*') from dual;

select rpad(substr('hongildong',1,),length('hongildong'), '*')
    from dual;
/*
�ó�����] �Ű������� ȸ�����̵�(���ڿ�)�� ������ ù���ڸ� ������ �������κ���
*�� ��ȯ�ϴ� �Լ��� �����Ͻÿ�
    ���� ��)  kosmo->k****
*/
create or replace function fillAsterik (
    idStr varchar2 /*�Ű������� ���������� ����*/
    )
return varchar2 /*��ȯ�� ���������� ���� */
is retStr varchar2(50); /*��������:��ȯ���� �����Ұ���*/
begin
    --���ڿ��� �����κ��� *�� ä���ش�.
    retStr := rpad(substr(idStr,1,1) , length(idStr), '*');
    return retStr;
end;
/

select fillAsterik('kosmo') from dual;
select fillAsterik('nakjasabal') from dual;

/*
�ó�����] member ���̺� ���ο� ȸ�������� �Է��ϴ� ���ν����� �����Ͻÿ�
    �Է°� : ���̵�, �н�����, �̸�
*/
create or replace procedure KosmoMemberInsert(
        p_id in varchar2,
        p_pass in varchar2,
        p_name in varchar2, /*Java���� ������ ���ڸ� ���� ���Ķ����*/
        returnVal out number /* �Է¼������� Ȯ��*/
    )
is 
begin
    --���Ķ���͸� ���� insert ������ �ۼ�
    insert into member (id, pass, name)
        values (p_id, p_pass, p_name);
    --�Է��� ���������� ó���Ǿ��ٸ�...
    if sql%found then
        --������ ���� ������ ���ͼ�, �ƿ��Ķ���Ϳ� �����Ѵ�.
        returnVal := sql%rowcount;
        commit;
    else
        --������ ��쿡�� 0�� ��ȯ�Ѵ�.
        returnVal := 0;
    end if;
end;
/
set serveroutput on;
select * from user_source where name like upper('%kosmomem%');
--���ε� ���� ���� 
var insert_count number;
execute KosmoMemberInsert('pro1','p1234','���ν���1',:insert_count);
--���Ȯ��
print insert_count;
--�Էµ� ���� Ȯ�� 
select * from member;

/*
�ó�����] member���̺��� ���ڵ带 �����ϴ� ���ν����� �����Ͻÿ�
    �Ű����� : In => member_id(���̵�)
                Out => returnVal(SUCCESS/FAIL ��ȯ)
*/
create or replace procedure KosmoMemberDelete(
    member_id in varchar2,
    returnVal out varchar2
    )
is -- ������ �ʿ���� ��� ��������
begin
    --���Ķ���͸� ���� delete������ �ۼ�
    delete from member where id = member_id;
    
    
    if SQL%Found then
        --ȸ�� ���ڵ尡 ���������� �����Ǿ��ٸ� 
        returnVal := 'SUCCESS';
        --Ŀ���Ѵ�
        commit;
    else
        --���ǿ� ��ġ�ϴ� ���ڵ尡 ���� ��� FAIL�� ��ȯ�Ѵ�.
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
�ó�����] ���̵�� �н����带 �Ű������� ���޹޾Ƽ� ȸ������ ���θ�
�Ǵ��ϴ� ���ν����� �ۼ��Ͻÿ�. 

    �Ű����� : 
        In -> user_id, user_pass
        Out -> returnVal
    ��ȯ�� : 
        0 -> ȸ����������(�Ѵ�Ʋ��)
        1 -> ���̵�� ��ġ�ϳ� �н����尡 Ʋ�����
        2 -> ���̵�/�н����� ��� ��ġ�Ͽ� ȸ������ ����
    ���ν����� : KosmoMemberAuth
*/

create or replace procedure KosmoMemberAuth(
    user_id in varchar2,
    user_pass in varchar2,
    returnVal out number
)
is
    -- count(*)�� ���� ��ȯ�Ǵ� ���� �����Ѵ�.
    member_count number(1) := 0;
    -- ��ȸ�� ȸ�������� �н����带 �����Ѵ�.
    member_pw varchar2(50);
begin
    --�ش� ���̵� �����ϴ��� �Ǵ��ϴ� select�� �ۼ�
    select count(*) into member_count
    from member where id=user_id;
    
    --ȸ�����̵� �����ϴ� ���
    if member_count=1 then
        --�н����� Ȯ���� ���� �ι�° ������ ����
        select pass into member_pw 
            from member where id=user_id;
        
        --���Ķ���ͷ� ���޵� ����� DB���� ������ ����� ��
        if member_pw=user_pass then
            returnVal := 2; --���̵�/��й�ȣ ��� ��ġ
        else
            returnVal := 1; --��й�ȣ Ʋ��
        end if;
    else
        returnVal := 0; --ȸ�������� ����
    end if;
end;
/

--��������, ���̵���ġ, �Ѵ���ġ�� 3���� ���̽��� ��� �׽�Ʈ �غ� ��
variable member_auth number;
select * from member;
execute KosmoMemberAuth('yugyeom', '1234', :member_auth);
print member_auth;
execute KosmoMemberAuth('test','1234�н�����Ʋ��',:member_auth);
print member_auth;
execute KosmoMemberAuth('test','3434', :member_auth);
print member_auth;



/*
JSP���� JDBC �ǽ��ϱ�
-���ο� ���� ���� �� ���� �ο��ϱ�
*/

--System�������� ������ �� ������ ������ �ο����ּ���


--��������
CREATE USER musthave IDENTIFIED BY 1234;
--Role(��)�� ���ؼ� ���ӱ��Ѱ� ���̺���� ���� �ο�
GRANT CONNECT, RESOURCE TO musthave;


--musthave �������� ������ �� ���̺� �� �ܷ�Ű�� �������ּ���.


--ȸ������ ���̺� 
create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key (id)
);

--�Խ��� ���̺�(��1 ��Ŀ��� ���)
create table board (
    num number primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    id varchar2(10) not null,
    postdate date default sysdate not null,
    visitcount number(6)
);

--board ���̺��� member���̺��� �����ϴ� �ܷ�Ű(����Ű) ����
alter table board
    add constraint board_mem_fk foreign key (id)
    references member (id);
    
--������ ����(�Խ��� �Ϸù�ȣ �Է½� �ڵ����������� �����)
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
--���̵����� �Է��ϱ�
insert into member (id,pass,name) values ('musthave','1234','�ӽ�Ʈ�غ�');
insert into board (num,title,content,id,postdate,visitcount)
    values (seq_board_num.nextval, '����1�Դϴ�','����1�Դϴ�','musthave',sysdate,0);
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
    values (seq_board_num.nextval, '������', '�ڷ�� ����1 �Դϴ�.', '����','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '�庸��', '�ڷ�� ����2 �Դϴ�.', '����','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '�̼���', '�ڷ�� ����3 �Դϴ�.', '����','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����4 �Դϴ�.', '����','1234');
insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����5 �Դϴ�.', '����','1234');

commit;


--�Խù��� ���� ī��Ʈ
select count(*) from mvcboard;

select count(*) from mvcboard where name like '%����%';



--�α���(ȸ������)�� ���� ������
--�ó�����] musthave/1234��� ȸ�������� �ִ��� Ȯ���Ͻÿ�
select * from member where id='musthave' and pass='1234';
select count(*) from member where id='musthave' and pass='1234';


--�н����� ������ ���� ������
--�ó�����]108�� �Խù��� ��й�ȣ�� 1234���� �����Ͻÿ�
select * from mvcboard where idx=108 and pass='1234';

select * from mvcboard;
--�Խù� �����ϱ�
--�ó�����]108�� �Խù��� �����Ͻÿ�.
delete from mvcboard where idx=108 and pass='1236';--���� �ȵ�. ��й�ȣ Ʋ��
delete from mvcboard where idx=108 and pass='1234';--���� ����.

commit;


--�Խù� �����ϱ�
/*
ȸ���� �Խ��ǿ����� �ۼ����� ���̵� �н������� ������ �ϰԵǹǷ�
ȸ�������� �Ǹ� ���� Ȥ�� ����ó���� ���ָ� �ȴ�.
������ ��ȸ���� �Խ��ǿ����� �н����带 ���� ������ �ʼ����̹Ƿ�
������ �н����忡 ���� ������ �ϳ� �� �߰��ؼ� �н����� ������ ����
�Խù��� ���ؼ��� ����ó�� �� �� �ֵ��� �ؾ��Ѵ�.
*/
update mvcboard set title='�������',content='�������',name='�����̸�',ofile='', sfile=''
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



-- ����������Ʈ 
-- ��� ���̺�
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
    values ('admin','1234','������','M','admin@admin.com','01012345678','1992-04-15');
select count(*) from memberp;
select * from memberp;


insert into mvcboard  (idx, name, title, content, pass)
    values (seq_board_num.nextval, '������', '�ڷ�� ����1 �Դϴ�.', '����','1234');

drop table memberp;

commit;



