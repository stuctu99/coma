package com.coma.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.bind.annotation.PostMapping;

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
					request.requestMatchers("/loginpage").permitAll()
					.requestMatchers("/resource/**").permitAll()
					.requestMatchers("/WEB-INF/views/**").permitAll()
					.anyRequest().authenticated();
				})	
				.formLogin(formlogin->{
					formlogin
					.loginPage("/loginpage")
					.successForwardUrl("/loginsuccess")
					.loginProcessingUrl("/logintest");
				})
				.rememberMe(rememberMe->{
					rememberMe
					.rememberMeParameter("remember_me")
					.tokenValiditySeconds(3600*24)
	                .userDetailsService(dbpv);
				})
				.logout(logout->logout.logoutUrl("/logout"))
				.authenticationProvider(dbpv)
				.build();
				
	}
}
