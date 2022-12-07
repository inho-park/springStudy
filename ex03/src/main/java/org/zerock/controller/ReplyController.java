package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/reply/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	// 댓글을 JSON 형태로 받아와 RequestBody 를 통해 ReplyVO 형태로 바꾼 후 tbl_Reply 에 insert
	@PostMapping(
			value = "new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		
		log.info("ReplyVO : " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	// PathVariable 로 쿼리 스트링을 파라미터로 변환하여 사용
	@GetMapping( value = "/pages/{bno}/{page}",
				produces = {
						MediaType.APPLICATION_JSON_UTF8_VALUE,
						MediaType.APPLICATION_XML_VALUE
				})
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno) {
		
		Criteria cri = new Criteria(page,10);
		
		log.info("getList............................................"+cri);
		
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}
	// json 출력 값
	// [{"rno":11,"bno":1179783,"reply":"Update Reply","replyer":"replyer2","replyDate":1670338800000,"updateDate":1670338800000},
	//	{"rno":16,"bno":1179783,"reply":"댓글 테스트 7","replyer":"replyer7","replyDate":1670338800000,"updateDate":1670338800000}]


	// rno 로 댓글 하나만 가져오기
	@GetMapping(value = "/{rno}",
				produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
				})
	public ResponseEntity<ReplyVO> get(
			@PathVariable("rno") Long rno) {
		
		log.info("get : "+ rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	
	// rno 에 해당된 댓글 지우기
	@DeleteMapping(value = "/{rno}",
				produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(
			@PathVariable("rno") Long rno) {
		
		log.info("delete : " + rno);
		
		return service.remove(rno) == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	// rno 에 해당된 댓글 수정하기
	@RequestMapping(value = "/{rno}",
				method = {RequestMethod.PUT , RequestMethod.PATCH },
				produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			@PathVariable("rno") Long rno,
			@RequestBody ReplyVO vo) {
		
		log.info("modify : "+rno);
		
		vo.setRno(rno);
		
		return service.modify(vo) == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
