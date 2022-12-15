package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
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
	@Before( "execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("================================================");
	}
	
	// && args(변수명 .. ) 을 통해서 advice메서드의 파라미터 설정
	@Before("execution(* org.zerock.service.SampleService*.doAdd(String,String)) && "
			+ "args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		
		log.info("str1 : "+str1);
		log.info("str2 : "+str2);
		
	}
	
	// pointcut 과 throwing 을 설정해서 advice 의 메서드 변수명과 일치시키기
	@AfterThrowing(
			pointcut = "execution(* org.zerock.service.SampleService*.*(..))",
			throwing = "exception")
	public void logException(Exception exception) {
		
		log.info("Exception ............");
		log.info("exception : " + exception);
	}
	
	
	@Around("execution(* org.zerock.service.SampleService*.*(..))")
	public Object logTime( ProceedingJoinPoint pjp) {
		
		long start = System.currentTimeMillis();
		
		log.info("Target : " + pjp.getTarget());
		log.info("Param : " + Arrays.toString(pjp.getArgs()));
		
		//invoke method
		Object result = null;
		
		try {
			result = pjp.proceed();
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		
		log.info("TIME : " + (end - start));
	
		return result;
	}
}
