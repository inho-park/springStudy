package org.zerock.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

// @Aspect : 해당 클래스가 Aspect 를 구현한 것임을 알려주기 위해
@Aspect
@Log4j
@Component // Bean 인식을 위해
public class LogAdvice {
	// @Before("AspectJ의 표현식(expression)(접근제한자 특정 클래스와 메서드)")
	@Before("execution(* org.rerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("================================================");
	}
}
