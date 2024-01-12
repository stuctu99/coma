package com.coma.security;

import java.util.Properties;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.coma.model.dto.Emp;

@Configuration
@MapperScan("com.coma.emp.mapper")
public class WebMVCConfigration implements WebMvcConfigurer{

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/loginpage").setViewName("login/loginpage");
		registry.addViewController("/noticelist").setViewName("board/noticelist");
		registry.addViewController("/freelist").setViewName("board/freelist");
//		registry.addViewController("/writePost").setViewName("board/writePost");
		registry.addViewController("/doclist").setViewName("apprdoc/doclist");
		
	}
	
	
	@Bean
	Emp emp() {
		return new Emp();
	}
	
}
