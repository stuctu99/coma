package com.coma.chatting.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.coma.chatting.model.service.MessengerService;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class MessengerServer extends TextWebSocketHandler {
	private final MessengerService service;
	private final ObjectMapper mapper; // Jackson Converter
	private Map<String, WebSocketSession> clients = new HashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("[MessengerServer]: 접속");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("[MessengerServer]: 메세지 정상 전송");
		MessengerMessage msg = mapper.readValue(message.getPayload(), MessengerMessage.class);
		switch (msg.getType()) {
		case "exec":
			addClient(msg, session);
			break;
		case "new":
			createChatroom(msg);
			break;
		case "privateNew":
			privateRoomAlarm(msg);
			break;
		case "delete":
			deleteRoom(msg);
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("접속 유지중인 세션" + clients);
		System.out.println("[MessengerServer]: 종료");
	}

	private void addClient(MessengerMessage msg, WebSocketSession session) {
		clients.put(msg.getLoginId(), session);
		System.out.println("메신저 접속 세션" + clients);
		try {
			session.sendMessage(messageConverter(msg));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void createChatroom(MessengerMessage msg) {
		String roomNo = service.selectNowCreateChatRoomNo();
		msg.setRoomNo(roomNo);
		msg.setMsg("new");
		try {
			for(Map.Entry<String, WebSocketSession> client : clients.entrySet()) {
				WebSocketSession session = client.getValue();
				session.sendMessage(messageConverter(msg));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
//	1:1채팅방 알림 메소드
	private void privateRoomAlarm(MessengerMessage msg) {
		String roomNo = service.selectNowCreateChatRoomNo();
		msg.setRoomNo(roomNo);
		String loginId = msg.getLoginId();
		String targetId = msg.getTargetId();
		List<String> list = new ArrayList<String>();
		list.add(loginId);
		list.add(targetId);
		
		msg.setMsg(loginId+"로 부터 대화 요청이 들어왔습니다.");
		try {
			if(clients.get(targetId)!=null) {
				for(String id : list) {
					WebSocketSession session = clients.get(id);
					session.sendMessage(messageConverter(msg));				
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void deleteRoom(MessengerMessage msg) {
		try {
			for(Map.Entry<String, WebSocketSession> client : clients.entrySet()) {
				WebSocketSession session = client.getValue();
				session.sendMessage(messageConverter(msg));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

//	데이터 전송 메세지 Jackson mppaer 이용하여 변환하기
	private TextMessage messageConverter(MessengerMessage msg) throws Exception{
		String message = null;
		 message = mapper.writeValueAsString(msg);
		return new TextMessage(message);
	}

}
