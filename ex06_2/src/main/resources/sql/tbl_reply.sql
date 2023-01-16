-- tbl_reply DDL

-- tbl_reply table 생성
create table tbl_reply (
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

-- rno 를 위한 시퀀스 추가
create sequence seq_reply;

-- rno 를 기본 키로 지정
alter table tbl_reply add constraint pk_reply primary key (rno);

-- FK (fk_reply_board) : bno 를 tbl_board (bno) 를 참조하는 외래키로 지정
alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references tbl_board (bno);


update tbl_board set replycnt = 
(select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);