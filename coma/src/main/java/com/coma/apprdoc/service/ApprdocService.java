package com.coma.apprdoc.service;

import java.util.List;
import java.util.Map;

import com.coma.model.dto.ApprovalDoc;

public interface ApprdocService {
	
	
	//진행중인 문서리스트
	List<ApprovalDoc> selectProceedList(Map<String, Integer> page, String docProgress);
	//문서함 문서리스트
	List<ApprovalDoc> selectDocList(Map<String, Integer> page, String docProgress);
}
