package com.coma.chatting.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {
	private final ChattingServer chattingServer;
	private final MessengerServer messengerServer;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(messengerServer, "/messengerServer").setAllowedOrigins("*");
		registry.addHandler(chattingServer, "/chattingServer").setAllowedOrigins("*");
		
	}
}