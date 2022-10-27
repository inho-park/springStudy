package com.zerock.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


@Data
public class TodoDTO {
	private String title;

	@DateTimeFormat(pattern="yyyy/MM/dd") // @InitBinder 를 대신해서 간편하게 사용 가능
	private Date dueDate;
}
