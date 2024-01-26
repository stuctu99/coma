package com.coma.chatting.common;

import java.util.Map;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.HandlerInterceptor;

import com.coma.chatting.model.service.ChattingService;
import com.coma.model.dto.ChattingJoin;
import com.coma.model.dto.Emp;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChattingRoomInterceptor implements HandlerInterceptor {
	private final ChattingService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean check = false;
		Emp loginMember = (Emp)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String roomNo = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1);
		Map<String,String> enterCheck = Map.of("empId",loginMember.getEmpId(),"roomNo",roomNo);
		ChattingJoin joinEmp = service.selectJoinCheckByEmpId(enterCheck);
		if(joinEmp!=null) {
			check = true;
		}
		if(!check) {
			 response.sendRedirect(request.getContextPath()+"/error"); 
		}
		System.err.println(loginMember.getEmpId());
		System.err.println(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1));
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
}
