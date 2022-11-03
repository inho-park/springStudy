package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = org.zerock.config.RootConfig.class)
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		assertNotNull(service);
	}
	
	// register 삽입 확인하기
		@Test
		public void testRegister() {
			
			BoardVO board = new BoardVO();
			board.setTitle("새로 작성하는 글");
			board.setContent("new Contents");
			board.setWriter("newwwwwwwwwwbie");
			
			service.register(board);
			
			log.info("생성된 게시물의 번호 : "+board.getBno());
		}
		
		// board 리스트 객체 확인하기
		@Test
		public void testGetList() {
			service.getList().forEach(board -> log.info(board));
		}
		
		// 원하는 bno 로 select 를 사용해 R 구현
		@Test
		public void testGet() {
			log.info("service.get(1l) : "+service.get(1l));
		}
		
		// 원하는 select 로 원하는 bno 의 columns 를 가져와 U 구현
		@Test
		public void testModify() {
			BoardVO board = service.get(1l);
			
			if (board == null) return;
			
			board.setTitle("Modified Title");
			log.info("MODIFY RESULT : "+service.modify(board));
		}
		
		// 원하는 bno 에 해당하는 columns 를 삭제하는 D 구현
		@Test
		public void testRemove() {
			log.info("REMOVE RESULT : "+service.remove(9l));
		}
	
	
}
