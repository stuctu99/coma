package com.coma.chatting.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.coma.model.dto.Message;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ChattingServer extends TextWebSocketHandler {
	
	//동일한 아이디는 하나의 Session을 유지하기 위해 Map을 이용
	//Map<String,Map<String,WebSocketSession>> clients; // room별 분리?
	private Map<String, WebSocketSession> clients = new HashMap<String, WebSocketSession>();
	private final ObjectMapper mapper; //Jackson Converter
	private int count = 0;
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		System.out.println("채팅서버 접속!!!");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 받았다.");
		System.out.println(message.getPayload()); // 클라이언트가 전송한 메세지
		Message msg = mapper.readValue(message.getPayload(), Message.class);
		switch(msg.getType()) {
			case "open":addClient(session,msg); break;
			case "msg":sendMessage(msg);break;
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅서버 나갔다!!!");
		System.out.println(status.getReason() + " " + status.getCode());
	}
	
	private void addClient(WebSocketSession session, Message msg) {
		clients.put(msg.getSender(), session);
		sendMessage(msg);
	}
	
	private void sendMessage(Message msg) {
//		모든접속자에게 메세지 전송 => 특정 방 접속자에게 보낼 수 있는 로직 구현하기
		for(Map.Entry<String, WebSocketSession> client : clients.entrySet()) {
			WebSocketSession session = client.getValue();
			try {
				String message  = mapper.writeValueAsString(msg);
				session.sendMessage(new TextMessage(message));
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	
	

	/*
	 * private static Set<Session> clients = Collections.synchronizedSet(new
	 * HashSet<Session>());
	 * 
	 * @OnOpen public void onOpen(Session session) {
	 * System.out.println("open session : "+session.toString());
	 * if(!clients.contains(session)) { clients.add(session);
	 * System.out.println("session open : "+session.getUserPrincipal()); }else {
	 * System.out.println("이미 연결된 세션"); } }
	 * 
	 * @OnMessage public void onMessage(String msg, Session session) throws
	 * Exception{ System.out.println("receive message : "+msg); for(Session s :
	 * clients) { System.out.println("send data : "+msg);
	 * s.getBasicRemote().sendText(msg); } }
	 * 
	 * @OnClose public void onClose(Session session) {
	 * System.out.println("session close : "+session.getUserPrincipal());
	 * clients.remove(session); }
	 */

}
