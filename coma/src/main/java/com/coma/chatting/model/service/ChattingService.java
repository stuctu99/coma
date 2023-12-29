package com.coma.chatting.model.service;

import java.util.List;

import com.coma.chatting.model.dto.Emp;

public interface ChattingService {
	List<Emp> selectEmpAll();
	
	List<String> chattingList();
}
