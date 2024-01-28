package com.coma.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.coma.MyAuthority;

import static org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfing {

	
	@Autowired
	private DBConnectionProvider dbpv;
	
	@Bean
	SecurityFilterChain authenticationPath(HttpSecurity http) throws Exception {
		return http
				.csrf(csrf->csrf.disable())
				.authorizeHttpRequests(request->{
					request
					.requestMatchers("/WEB-INF/views/**").permitAll()
					.requestMatchers("/resource/**").permitAll()
					.requestMatchers("/loginpage").permitAll()
					//사원관리 페이지 COMA_1(원장), COMA_2(행정부장)
					.requestMatchers(antMatcher("/admin/adminEmp")).hasAnyAuthority(MyAuthority.ADMIN.name(),MyAuthority.DIRECTOR1.name())
					//학생관리 페이지 COMA_1(원장), COMA_3(교육부장)
					.requestMatchers(antMatcher("/admin/adminStudent")).hasAnyAuthority(MyAuthority.ADMIN.name(),MyAuthority.DIRECTOR2.name())
					//학생 출결 COMA_10~14(강사)
					.requestMatchers(antMatcher("/student/student")).hasAnyAuthority(MyAuthority.ADMIN.name(),MyAuthority.TEACHER.name())
					//학생 취업 COMA_4~8(취업)
					.requestMatchers(antMatcher("/student/studentEmp")).hasAnyAuthority(MyAuthority.ADMIN.name(),MyAuthority.EMPTEAM.name())
					.anyRequest().authenticated();
					
				})	
				.formLogin(formlogin->{
					formlogin
					.loginPage("/loginpage")
					.successForwardUrl("/loginsuccess")
					.loginProcessingUrl("/logintest");
				}).rememberMe(remember->{
					remember
					.rememberMeParameter("rememberck")
					.userDetailsService(dbpv);
				})
				.exceptionHandling(exceptionHandlingConfigurer ->
                exceptionHandlingConfigurer
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect("/error-page/403");
                }))
				.logout(logout->logout.logoutUrl("/logout"))
				.authenticationProvider(dbpv)
				.build();
				
	}
	

}
