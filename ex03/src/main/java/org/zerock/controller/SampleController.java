package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	// string 순수 데이터 전달
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText()	{
		
		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요";
	}
	
	
	// XML 이 출력되지만 뒤에 .json 을 추가하면 JSON 형태로 전달 가능
	@GetMapping(value = "/getSample",
				produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE })
	public SampleVO getSample() {
		
		log.info("getSample : " + this.toString());
		
		return new SampleVO(112,"스프링","노잼");
	}
	// produces 는 필수 속성이 아님
	// => 또한 입력하지 않아도 XML, JSON 형태 받기 가능
	@GetMapping(value = "/getSample2")
	public SampleVO getSample2() {
	
		log.info("getSample2 : " + this.toString());
		
		return new SampleVO(113,"스프링","노잼");
	}
	
	
	// list 도 XML , JSON 다 결과 도출 가능
	@GetMapping(value = "/getList")
	public List<SampleVO> getList() {
		
		log.info("getList : " + this.toString());
		
		return IntStream.range(1, 10).mapToObj(mapper -> new SampleVO(
				mapper, mapper + "First", mapper + "Last"
				))
				.collect(Collectors.toList());
	}
	
	
	// map 또한 XML, JSON 결과 도출 가능
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap() {
		
		log.info("getMap : " + this.toString());
		
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111,"aaa","bbb"));
		return map;
	}
	
	
	// ResponseEntity 는 데이터와 함께 HTTP 헤더의 상태 메시지 등을 전달하는 용도로 사용
	// HTTP 의 상태 코드와 에러 메시지 등을 함꼐 데이터를 전달할 수 있기 때문에 받는 입장에서 결과를 확실히 인지 가능
	@GetMapping(value = "/check", params = {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		
		SampleVO vo = new SampleVO(0, "" + height, "" + weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {
			// 특정 상황에 따라 http 헤더의 상태 메시지나 데이터 등을 같이 전달할 수 있다
			result = ResponseEntity
					.status(HttpStatus.BAD_GATEWAY)
					.body(vo);
		}else {
			result = ResponseEntity
					.status(HttpStatus.OK)
					.body(vo);
		}
		return result;
	}
	
	
	// PathVariable은 URL에서 {}로 처리된 부분을 parameter 로서 사용할 수 있게 해주는 어노테이션
	// 얘도 XML , JSON 결과 나옴
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(
		@PathVariable("cat") String cat,
		@PathVariable("pid") Integer pid) {
		
		String[] str = new String[] { "Category : " + cat, "productID : " + pid };
		log.info("getPath : "+str);
		return str;
	}
}
