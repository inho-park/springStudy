package org.zerock.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String userpw;
	private String userName;
	private String enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
}