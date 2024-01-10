package com.coma.student.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.coma.student.dao.StudentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentService {
	private final StudentDao dao;
	private final SqlSession session;
}
