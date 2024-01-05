package com.coma.chatting.common;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@ServerEndpoint(value = "/chattingServer")
public class ChattingServer extends TextWebSocketHandler {

	
	  private static Set<Session> clients = Collections.synchronizedSet(new
	  HashSet<Session>());
	  
	  @OnOpen public void onOpen(Session session) {
	  System.out.println("open session : "+session.toString());
	  if(!clients.contains(session)) { clients.add(session);
	  System.out.println("session open : "+session.getUserPrincipal()); }else {
	  System.out.println("이미 연결된 세션"); } }
	  
	  @OnMessage public void onMessage(String msg, Session session) throws
	  Exception{ System.out.println("receive message : "+msg); for(Session s :
	  clients) { System.out.println("send data : "+msg);
	  s.getBasicRemote().sendText(msg); } }
	  
	  @OnClose public void onClose(Session session) {
	  System.out.println("session close : "+session.getUserPrincipal());
	  clients.remove(session); }
	 

	/*
	 * @Override public void afterConnectionEstablished(WebSocketSession session)
	 * throws Exception { System.out.println("채팅서버 접속!!!");
	 * System.out.println(session.getId()); }
	 * 
	 * @Override protected void handleTextMessage(WebSocketSession session,
	 * TextMessage message) throws Exception { System.out.println("메세지 받았다.");
	 * System.out.println(message.getPayload()); //클라이언트가 전송한 메세지 }
	 * 
	 * @Override public void afterConnectionClosed(WebSocketSession session,
	 * CloseStatus status) throws Exception { System.out.println("채팅서버 나갔다!!!");
	 * System.out.println(status.getReason()+" "+status.getCode()); }
	 */

}
