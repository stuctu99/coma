package com.coma.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;


@Configuration
@EnableWebSecurity
public class SecurityConfing {
	
	@Autowired
	private DBConnectionProvider dbpv;
	
	public void configure(WebSecurity web) throws Exception{
		web.httpFirewall(defaultHttpFirewall());
	}
	
	@Bean
	public HttpFirewall defaultHttpFirewall() {
		return new DefaultHttpFirewall();
	}
	
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
				.logout(logout->logout.logoutUrl("/logout"))
				.authenticationProvider(dbpv)
				.build();
				
		}
	}




