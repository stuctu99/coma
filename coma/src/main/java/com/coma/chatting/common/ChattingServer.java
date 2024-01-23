package com.coma.chatting.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.coma.chatting.controller.ChattingController;
import com.coma.chatting.model.service.ChattingService;
import com.coma.model.dto.ChattingMessage;
import com.coma.model.dto.Emp;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ChattingServer extends TextWebSocketHandler {

	// 동일한 아이디는 하나의 Session을 유지하기 위해 Map을 이용

	// Map<String,Map<String,WebSocketSession>> clients; // room별 분리?
	private Map<String, Map<String, WebSocketSession>> room = new HashMap<String, Map<String, WebSocketSession>>();
	private Map<String, WebSocketSession> clients = new HashMap<String, WebSocketSession>();
	private List<ChattingMessage> msgPackages = new ArrayList<>();

	private final ObjectMapper mapper; // Jackson Converter
	private final ChattingService service;
	private final ChattingController controller;
	private ChattingMessage tempMsg;

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.err.println("[ChattingServer] : 채팅서버 접속!!!");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		/* System.err.println("[ChattingServer] : 메세지 받았다."); */
		System.err.println("[ChattingServer 전송메세지 정보] :" + message.getPayload()); // 클라이언트가 전송한 메세지
		ChattingMessage msg = mapper.readValue(message.getPayload(), ChattingMessage.class);
		Emp emp = service.selectEmpByEmpId(msg.getEmpId());
		msg.setEmpObj(emp);

		for (Map.Entry<String, Map<String, WebSocketSession>> chatRoom : room.entrySet()) {
			System.err.println("[ChattingServer] 현재 유지중인 채팅방 : " + chatRoom);
		}

		switch (msg.getType()) {
		case "open":
			addClient(session, msg);
			break;
		case "msg":
			sendMessage(msg);
			break;
		case "invite":
			sendMessage(msg);
		case "rest":
			clientOut(msg);
			break;
		case "out":
			clientOut(msg);
			break;
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		if (msgPackages.size() > 0) {
			saveChattingMessage();
		}

		for (Map.Entry<String, Map<String, WebSocketSession>> chatRoom : room.entrySet()) {
			if (chatRoom.getValue().isEmpty()) {
				room.remove(chatRoom.getKey());
			} else {
				Iterator<Map.Entry<String, WebSocketSession>> client = chatRoom.getValue().entrySet().iterator();
				while (client.hasNext()) {
					Map.Entry<String, WebSocketSession> c = client.next();
					if (c.getValue().equals(session)) {
						String roomNo = chatRoom.getKey();
						String empId = c.getKey();
						client.remove();
						sendMessage(tempMessage(roomNo, empId));
					}
				}
			}
		}

		System.err.println("[ChattingServer] : 채팅서버종료");
	}

	private void addClient(WebSocketSession session, ChattingMessage msg) {
		// 이미 세션이 연결되어 있는 채팅방 존재 체크
		boolean roomCheck = room.containsKey(msg.getRoomNo());

		// 채팅방 존재 시 존재하는 채팅방에 세션정보 추가
		if (roomCheck) {
			for (Map.Entry<String, Map<String, WebSocketSession>> chatRoom : room.entrySet()) {
				System.err.println("[ChattingServer] : 현재 세션 유지중인 채팅방 리스트 : " + chatRoom);
				if (chatRoom.getKey().equals(msg.getRoomNo())) {
					/* clients.put(msg.getEmpId(), session); */
					chatRoom.getValue().put(msg.getEmpId(), session);
					room.put(msg.getRoomNo(), chatRoom.getValue());

				}
			}
			sendMessage(msg);
		} else {
			// 채팅방 정보가 없을 때 최초 입장하는 세션을 기준으로 방정보를 session에 먼저 넣기
			/* System.err.println("[ChattingServer] : 최초입장"); */
			clients = new HashMap<String, WebSocketSession>();
			clients.put(msg.getEmpId(), session);
			room.put(msg.getRoomNo(), clients);
			sendMessage(msg);
		}
		System.err.println("[ChattingServer] : 채팅방에 존재하는 세션정보: " + room.get(msg.getRoomNo()));

	}

	private void sendMessage(ChattingMessage msg) {
		String message = null;
//		모든접속자에게 메세지 전송 => 특정 방 접속자에게 보낼 수 있는 로직 구현하기
		if (msg.getType().equals("msg") && room.get(msg.getRoomNo()).size() != 1) {
			msgPackages.add(msg);
			if (msgPackages.size() >= 30) {
				saveChattingMessage();
			}
		} else if (msg.getType().equals("msg") && room.get(msg.getRoomNo()).size() == 1) {
			msgPackages.add(msg);
			saveChattingMessage();
		} else if (msg.getType().equals("invite") && msgPackages.size() > 0) {
			saveChattingMessage();
		}

		for (Map.Entry<String, Map<String, WebSocketSession>> chatRoom : room.entrySet()) {
			if (chatRoom.getKey().equals(msg.getRoomNo())) {
				for (Map.Entry<String, WebSocketSession> client : chatRoom.getValue().entrySet()) {
					WebSocketSession session = client.getValue();
					/* System.err.println("[ChattingServer 전달 세션 정보] : "+session); */
					try {
						if (!chatRoom.getValue().isEmpty()) {
							switch(msg.getType()) {
							case "open":
								if(!client.getKey().equals(msg.getEmpId())) {
									message = mapper.writeValueAsString(msg);
									session.sendMessage(new TextMessage(message));
								}
								break;
							case "invite":
								if(!client.getKey().equals(msg.getEmpId())) {
									message = mapper.writeValueAsString(msg);
									session.sendMessage(new TextMessage(message));
								}
								break;
							case "msg":
								message = mapper.writeValueAsString(msg);
								session.sendMessage(new TextMessage(message));
								break;
								
							case "rest":
								message = mapper.writeValueAsString(msg);
								session.sendMessage(new TextMessage(message));
								break;
								
							case "out":
								message = mapper.writeValueAsString(msg);
								session.sendMessage(new TextMessage(message));
								break;
							}
						
							
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}

	}

	private void clientOut(ChattingMessage msg) {
		for (Map.Entry<String, Map<String, WebSocketSession>> chatRoom : room.entrySet()) {
			if (chatRoom.getValue().isEmpty()) {
				room.remove(chatRoom.getKey());
				continue;
			}
			// 채팅방 전체 순회
			if (chatRoom.getKey().equals(msg.getRoomNo())) {
				// 요청들어온 채팅방 일때만 실행
				Iterator<Map.Entry<String, WebSocketSession>> client = chatRoom.getValue().entrySet().iterator();
				while (client.hasNext()) {
					// 채팅방 세션 멤버 Map 순회
					Map.Entry<String, WebSocketSession> c = client.next();
					if (c.getKey().equals(msg.getEmpId())) {
						// 채팅방 이벤트 발생 사원 아이디와 일치시 채팅방에서 세션 제거
						try {
//								c.getValue().close();
							client.remove();
//							if(chatRoom.getValue().isEmpty()) {
//								
//							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						System.err.println("[ChattingServer 전체조회] :" + chatRoom);
					}

				}
			}
		}
		System.err.println("[ChattingServer 메세지 전송 전] : " + msg);
		System.err.println("[ChattingServer Room]" + room);
		if (!room.get(msg.getRoomNo()).isEmpty()) {
			sendMessage(msg);
		} else {
			sendMessage(msg);
			room.remove(msg.getRoomNo());
		}
	}

//	채팅메시지 DB저장 (현재 30개 기준)
	private void saveChattingMessage() {
		int result = 0;
		if (!msgPackages.isEmpty()) {
			result = service.insertChattingMessage(msgPackages);
		}
		if (result > 0) {
			System.out.println("[ChattingServer] : 메세지 저장 완료");
			msgPackages.clear();
		} else {
			System.out.println("[ChattingServer] : 메세지 저장 실패");
		}
	}

	private ChattingMessage tempMessage(String roomNo, String empId) {
		ChattingMessage msg = new ChattingMessage();
		msg.setType("rest");
		msg.setRoomNo(roomNo);
		msg.setEmpId(empId);
		tempMsg = msg;
		return tempMsg;
	}

}