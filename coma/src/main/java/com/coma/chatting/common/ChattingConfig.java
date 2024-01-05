package com.coma.chatting.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import com.coma.model.dto.ChattingRoom;
import com.coma.model.dto.ChattingRoomType;

@Configuration
public class ChattingConfig {

	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		return new ServerEndpointExporter();
	}
}
