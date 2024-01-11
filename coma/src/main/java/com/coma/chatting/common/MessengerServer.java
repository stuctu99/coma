package com.coma.chatting.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
@Component
@RequiredArgsConstructor
public class MessengerServer extends TextWebSocketHandler{
	private final ObjectMapper mapper; // Jackson Converter
	private Map<String,WebSocketSession> clients = new HashMap<String,WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("MessengerServer: 접속");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		MessengerMessage msg = mapper.readValue(message.getPayload(), MessengerMessage.class);
		switch(msg.getType()) {
			case "open":addClient(msg,session); break;
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("접속 유지중인 세션"+clients);
		System.out.println("MessengerServer: 종료");
	}
	
	private void addClient(MessengerMessage msg,WebSocketSession session) {
		clients.put(msg.getEmpId(),session );
		System.out.println("메신저 접속 세션"+clients);
	}
	
	/*
	 * private void removeClient(WebSocketSession session) { for(Map.Entry<String,
	 * WebSocketSession> client : clients.entrySet()) {
	 * if(client.getValue()==session) { String delClient = client.getKey();
	 * clients.remove(delClient); } } }
	 */

}
