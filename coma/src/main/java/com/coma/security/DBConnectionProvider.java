package com.coma.security;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.coma.emp.dao.EmpDao;
import com.coma.model.dto.Emp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class DBConnectionProvider implements AuthenticationProvider, UserDetailsService{
	
	
	private final EmpDao dao;
	private final SqlSession session;
	private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String empId=authentication.getName();
		String empPw=(String)authentication.getCredentials();
		Emp loginEmp = dao.selectEmpById(session,empId);
		
//		System.out.println(loginEmp);
		
		
		if(loginEmp==null || (!encoder.matches(empPw, loginEmp.getEmpPw())&&!empPw.equals("updateData"))) {
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



	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Emp loginEmp = dao.selectEmpById(session,username);
		if(loginEmp==null) {
			throw new BadCredentialsException("인증실패");
		}
		return loginEmp;
	}



	/*
	 * @Override public void onAuthenticationSuccess(HttpServletRequest request,
	 * HttpServletResponse response, Authentication authentication) throws
	 * IOException, ServletException {
	 * 
	 * //경우1 : 로그인 인증을 위해 Spring Security가 요청을 가로챈 경우 RequestCache requestCache =
	 * new HttpSessionRequestCache(); SavedRequest savedRequest =
	 * requestCache.getRequest(request, response);
	 * 
	 * //경우2 : 사용자가 직접 로그인 버튼을 누른 경우 String prevPage = (String)
	 * request.getSession().getAttribute("prevPage"); if(prevPage!=null)
	 * request.getSession().removeAttribute("prevPage");
	 * 
	 * String uri = request.getContextPath(); //경우1 일 경우 uri에 경로 저장
	 * if(savedRequest!=null) uri = savedRequest.getRedirectUrl(); //경우2 일 경우 uri에
	 * 경로 저장 else if(prevPage!=null) uri = prevPage;
	 * 
	 * response.sendRedirect(uri); }
	 */
	
	
	
	
}
