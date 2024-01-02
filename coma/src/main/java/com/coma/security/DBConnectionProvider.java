package com.coma.security;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.coma.emp.dao.EmpDao;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class DBConnectionProvider implements AuthenticationProvider{
	
	
	private final EmpDao dao;
	private final SqlSession session;
	private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String empId=authentication.getName();
		String empPw=(String)authentication.getCredentials();
		
		Emp loginEmp = dao.selectEmpById(session,empId);
		
		System.out.println(loginEmp);
		
		if(loginEmp==null || !encoder.matches(empPw, loginEmp.getEmpPw())) {
			throw new BadCredentialsException("인증실패!");
		}
		
		
		return new UsernamePasswordAuthenticationToken(
								loginEmp, loginEmp.getEmpPw(),loginEmp.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return UsernamePasswordAuthenticationToken
				.class.isAssignableFrom(authentication);
	}
	
	
	
}
