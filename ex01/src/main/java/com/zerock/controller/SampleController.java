package com.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zerock.domain.SampleDTO;

import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	@RequestMapping("")
	public void basic() {
		
		log.info("basic.....................................................");
	}
	
	
	@RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		
		log.info("basic GET.....................................................");
	}
	
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		
		log.info("basic GET 2.....................................................");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		
		log.info(""+dto);
		
		return "ex01";
	}
}

