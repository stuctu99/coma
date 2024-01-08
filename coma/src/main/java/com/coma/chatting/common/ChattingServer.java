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

import com.coma.chatting.model.service.ChattingService;
import com.coma.model.dto.ChattingMessage;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ChattingServer extends TextWebSocketHandler {
	
	//동일한 아이디는 하나의 Session을 유지하기 위해 Map을 이용
	
	//Map<String,Map<String,WebSocketSession>> clients; // room별 분리?
	private Map<String,Map<String,WebSocketSession>> room = new HashMap<String,Map<String,WebSocketSession>>();
	private Map<String, WebSocketSession> clients = new HashMap<String, WebSocketSession>();
	private List<ChattingMessage> msgPackages = new ArrayList<>();
	
	private final ObjectMapper mapper; //Jackson Converter
	private final ChattingService service;

	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅서버 접속!!!");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메세지 받았다.");
		System.out.println(message.getPayload()); // 클라이언트가 전송한 메세지
		ChattingMessage msg = mapper.readValue(message.getPayload(), ChattingMessage.class);
		System.out.println("데이터가 어떻게 들어오는거니? "+msg);
		switch(msg.getType()) {
			case "open":addClient(session,msg); break;
			case "msg":sendMessage(msg);break;
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅서버 나갔다!!!");
		for(Map.Entry<String, Map<String,WebSocketSession>> t : room.entrySet()) {
			System.out.println("이걸봐야한다!!!!!!!!!!"+t.getKey()+" : "+t.getValue());
		}
	}
	
	private void addClient(WebSocketSession session, ChattingMessage msg) {
		//이미 세션이 연결되어 있는 채팅방 존재 체크
		boolean roomCheck = room.containsKey(msg.getRoomNo());
		
		//채팅방 존재 시 존재하는 채팅방에 세션정보 추가
		if(roomCheck) {
			for(Map.Entry<String,Map<String,WebSocketSession>> chatRoom : room.entrySet()) {
				System.out.println("현재 세션 유지중인 채팅방 리스트 : "+chatRoom);
				if(chatRoom.getKey().equals(msg.getRoomNo())) {
					clients.put(msg.getEmpId(), session);
					
				}
			}
			room.put(msg.getRoomNo(), clients);
			sendMessage(msg);
		}else {
			//채팅방 정보가 없을 때 최초 입장하는 세션을 기준으로 방정보를 session에 먼저 넣기
			clients.put(msg.getEmpId(),session);
			room.put(msg.getRoomNo(), clients);
			sendMessage(msg);
		}
		System.out.println("채팅방에 존재하는 세션정보: "+room.get(msg.getRoomNo()));
		
	}
	
	private void sendMessage(ChattingMessage msg) {
//		모든접속자에게 메세지 전송 => 특정 방 접속자에게 보낼 수 있는 로직 구현하기
		
		if(msg.getType().equals("msg")) {
			msgPackages.add(msg);
			if(msgPackages.size()>=30) {
				System.out.println("=========================================================="+msgPackages);
				 int result = service.insertChattingMessage(msgPackages); 
				
				if(result>0) { 
					System.out.println("메세지 저장 완료");
			  }else {
				  System.out.println("메세지 저장 실패"); 
			   } 
			}
			 
		}
		System.out.println("Message정보출력 ======= "+msg);
		for(Map.Entry<String, Map<String,WebSocketSession>> chatRoom : room.entrySet()) {
			if(chatRoom.getKey().equals(msg.getRoomNo())) {
			for(Map.Entry<String, WebSocketSession> client : clients.entrySet()) {
				WebSocketSession session = client.getValue();
				System.out.println("session INFO : "+ session);
				try {
					String message  = mapper.writeValueAsString(msg);
					session.sendMessage(new TextMessage(message));
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
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
