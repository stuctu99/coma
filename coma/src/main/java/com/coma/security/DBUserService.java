//package com.coma.security;
//
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.stereotype.Component;
//
//import com.coma.emp.mapper.EmpMapper;
//import com.coma.model.dto.Emp;
//
//import lombok.RequiredArgsConstructor;
//
//@Component
//@RequiredArgsConstructor
//public class DBUserService implements UserDetailsService{
//		
//		private final EmpMapper dao;
//		private final BCryptPasswordEncoder encoder;
//		
//		@Override
//		public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//			Emp loginemp=dao.selectEmpById(username);
//			return loginemp;
//		}
//
//		
//		
//	}
//
//}
