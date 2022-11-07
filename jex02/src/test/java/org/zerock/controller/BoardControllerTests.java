package org.zerock.controller;


import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes={
	org.zerock.config.RootConfig.class,
	org.zerock.config.ServletConfig.class
})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	// 쉽게 말해 가짜 MVC 
	// 가짜로 URL 과 파라미터를 브라우저에서 사용하는 것처럼 만들어서 Controller 를 실행
	private MockMvc mockMvc;
	
	@Before //JUnit 어노테이션 중 하나로
	// Test 메소드가 실행되기 전 항상 실행되며 공통적으로 환경을 구축하는 코드를 위한 어노테이션
	// 순서는 각 Test 마다
	// @BeforeClass -> @Before -> @Test -> @After -> @AfterClass
	// @BeforeClass 와 @AfterClass 는 
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		log.info("MockMvcBuilders.webAppContextSetup........................");
	}
	
	@Test
	public void testList() throws Exception  {
		
		log.info(
			mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
			.andReturn()
			.getModelAndView()
			.getModelMap());
	}
	
	@Test
	public void testRegister() throws Exception {
		
		String resultPage = mockMvc
							.perform(MockMvcRequestBuilders
									.post("/board/register")
									.param("title", "테스트 새글 제목")
									.param("content","테스트 새글 내용")
									.param("writer", "테스트 새작가"))
							.andReturn().getModelAndView().getViewName();
		
		log.info("resultPage.........................................");
		log.info(resultPage);
	}
	
	@Test
	public void testGet() throws Exception {
		
		log.info(mockMvc
				.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno", "2"))
			.andReturn()
			.getModelAndView()
			.getModelMap());
	}
	
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc
							.perform(MockMvcRequestBuilders.post("/board/modify")
							.param("bno", "1")
							.param("title", "수정된 테스트 새글 제목")
							.param("content", "수정된 테스트 새글 내용")
							.param("writer","수정된 새로운 작가래유"))
						.andReturn()
						.getModelAndView()
						.getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc
							.perform(MockMvcRequestBuilders.post("/board/remove")
							.param("bno", "22"))
						.andReturn()
						.getModelAndView()
						.getViewName();
		
		log.info(resultPage);
	}
}