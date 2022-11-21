-- oracle 재귀복사 명령문
    insert into tbl_board (bno,title,content,writer) 
    (select SEQ_BOARD.nextval, title, content, writer from tbl_board);


-- bno 를 이용하여 정렬 -> 정렬 알고리즘 사용
    select * from tbl_board order by bno+1 DESC;
    select * from tbl_board order by bno DESC;


-- INDEX_DESC(tbl_board pk_board) 
    select * from tbl_board where bno > 0;


-- /*+ */ 를 사용해 hint 를 사용해서 사용자의 의도대로 되게 하는 방법
-- SELECT
-- /*+ Hint name (param ...) */ 
-- column name, ...
-- FROM
-- table name
-- ...
-- 장점은 오류가 나도 원래 명령문에 영향을 주지 않음
-- 아래의 두 명령은 같은 결과를 생성하지만 2번째는 아무 조건이 없음
    select * from tbl_board order by bno DESC;
    select /*+INDEX_DESC (tbl_board pk_board) */ * from tbl_board;
    

-- FULL 힌트
-- 단순히 table 을 order by 에 맞춰 full scan 함
    select /*+ FULL(tbl_board) */ * from tbl_board order by bno desc;
    

-- INDEX_ASC , INDEX_DESC 힌트
-- 목록 페이지에서 가장 많이 사용되는 힌트
    select /*+INDEX_ASC (tbl_board pk_board) */ * from tbl_board;


-- ROWNUM 적용
-- rownum 은 table 내에 존재하지 않고 가져온 데이터를 이용해서 번호를 매김
    select rownum rn, bno, title from tbl_board;
    
    select /*+ FULL(tbl_board)*/ rownum rn, bno, title from tbl_board order by bno;
    
    select /*+ INDEX_ASC(tbl_board pk_board)*/ rownum rn, bno, title, content from tbl_board;
    select /*+ INDEX_DESC(tbl_board pk_board)*/ rownum rn, bno, title, content from tbl_board;
    

-- ROWNUM 으로 where 구문을 이용하여 페이징하기
    select /*+ INDEX_DESC(tbl_board pk_board)*/rownum rn, bno, title from tbl_board where rownum<=10;
    
    -- 예외) 아무 결과 나오지 않음 ( rownum 을 where 구문에 넣을 때는 반드시 1 이 포함되도록 해야함 )
    -- 잘못된 예시 )
    select /*+ INDEX_DESC(tbl_board pk_board)*/rownum rn, bno, title from tbl_board where rownum>10 and rownum<=20;
    -- 즉 사용하려면 In-line View 처리를 하여 2 페이지 ( 11 ~ 20 ) 까지의 데이터 처리
    select bno, title, content
    from (
        select /*+INDEX_DESC(tbl_board, pk_board) */rownum rn, bno, title, content
        from tbl_board
        where rownum<=20
    )
    where rn > 10;