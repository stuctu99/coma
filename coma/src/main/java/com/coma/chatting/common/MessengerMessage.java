package com.coma.chatting.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MessengerMessage {
	private String type;
	private String loginId;
	private String targetId;
	private String roomNo;
	private String msg;
}
