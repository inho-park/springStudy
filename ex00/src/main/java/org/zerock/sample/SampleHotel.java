package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NonNull;
import lombok.ToString;

@Component
@ToString
@Getter
@AllArgsConstructor
@Data
public class SampleHotel {
	
	@NonNull
	private Chef chef;
	
	SampleHotel(){}
}
