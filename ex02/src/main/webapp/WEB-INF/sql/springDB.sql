-- oracle ��ͺ��� ��ɹ�
    insert into tbl_board (bno,title,content,writer) 
    (select SEQ_BOARD.nextval, title, content, writer from tbl_board);


-- bno �� �̿��Ͽ� ���� -> ���� �˰��� ���
    select * from tbl_board order by bno+1 DESC;
    select * from tbl_board order by bno DESC;


-- INDEX_DESC(tbl_board pk_board) 
    select * from tbl_board where bno > 0;


-- /*+ */ �� ����� hint �� ����ؼ� ������� �ǵ���� �ǰ� �ϴ� ���
-- SELECT
-- /*+ Hint name (param ...) */ 
-- column name, ...
-- FROM
-- table name
-- ...
-- ������ ������ ���� ���� ��ɹ��� ������ ���� ����
-- �Ʒ��� �� ����� ���� ����� ���������� 2��°�� �ƹ� ������ ����
    select * from tbl_board order by bno DESC;
    select /*+INDEX_DESC (tbl_board pk_board) */ * from tbl_board;
    

-- FULL ��Ʈ
-- �ܼ��� table �� order by �� ���� full scan ��
    select /*+ FULL(tbl_board) */ * from tbl_board order by bno desc;
    

-- INDEX_ASC , INDEX_DESC ��Ʈ
-- ��� ���������� ���� ���� ���Ǵ� ��Ʈ
    select /*+INDEX_ASC (tbl_board pk_board) */ * from tbl_board;

