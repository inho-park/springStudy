package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;



@RunWith(SpringRunner.class)

//java config
//@ContextConfiguration(classes = { org.zerock.config.RootConfig.class })
//root-context.xml config
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	private Long[] bnoArr = { 1179784l,1179783l,1179782l,1179781l,1179761l };
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		
		log.info(mapper);
	}

	
	
	// insert Test
	@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			// 게시물의 번호
			vo.setBno(bnoArr[(i-1) % 5]);
			vo.setReply("댓글 테스트 " + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	
	
	
	// select Test
	@Test
	public void testRead() {
		
		Long targetRno = 15L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	
	
	// delete Test
	@Test
	public void testDelete() {
		
		Long targetRno = 10L;
		
		mapper.delete(targetRno);
	}
	
	
	
	// update Test
	@Test
	public void testUpdate() {
		
		Long targetRno = 11l;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update Reply");
		
		log.info("Update Count : "+mapper.update(vo));
	}
	
	
	
	// getListWithPaging Test
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
}

