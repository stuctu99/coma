package com.coma.model.dto;

import java.sql.Date;
import java.util.List;
import java.util.Map;

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
	/* private String roomType; */
	private String roomPasswordFlag;
	private String roomPassword;
	private Date roomCreateDate;
	private ChattingRoomType roomTypeObj;
	private Map<String,String> idList;
	private String endMsg;
	private Emp empObj;
	private int memberCount;
	/* private List<ChattingJoin> joinMember; */
}