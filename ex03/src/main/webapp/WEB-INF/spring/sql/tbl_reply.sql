-- tbl_reply 댓글 구현을 위한 db 구현
create table tbl_reply (
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

-- 시퀀스 생성
create sequence seq_reply;

-- 별도의 PK를 rno로 지정
alter table tbl_reply add constraint pk_reply primary key (rno);

-- FK (fk_reply_board) 로 bno 가 tbl_board (bno) 를 참조하는 외래키라는 것을 명시
alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references tbl_board (bno);