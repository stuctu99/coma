package com.coma.chatting.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChattingRoom {
	private String roomNo;
	private String roomName;
	private String roomType;
	private String roomPasswordFlag;
	private String roomPassword;
	private Date roomCreateDate;
	private List<ChattingJoin> joinMember;
}
