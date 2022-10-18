package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Data;

// @Component 는 @ContextConfiguration 에 해당되는 root_context.xml 의 context:component-scan, 
// 혹은 java class 에서  @Configuration 을 통해 명시해주는 @ComponentScan() 을 통해 생성할 Bean 명시
@Component
@Data
public class Chef {
	
}
