package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;

@Component
@Data
public class Restaurant {
	
    // Restaurant 객체에 Chef 가 객체가 필요하다는 @Autowired 를 설정하여
    // Spring 이 Chef 객체의 reference => bean 을 주입
	@Setter (onMethod_ =  @Autowired )
	private Chef chef;
}
