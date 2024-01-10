package com.coma.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChattingRoom {
	private String roomNo;
	private String roomName;
	/* private String roomType; */
	private String roomPasswordFlag;
	private String roomPassword;
	private Date roomCreateDate;
	private ChattingRoomType roomTypeObj;
	private String empId;
	private int memberCount;
	/* private List<ChattingJoin> joinMember; */
}
