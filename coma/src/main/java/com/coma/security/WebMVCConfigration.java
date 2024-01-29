package com.coma.security;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.coma.apprdoc.controller.ApprdocInterceptor;
import com.coma.chatting.common.ChattingRoomInterceptor;
import com.coma.model.dto.Emp;

import lombok.RequiredArgsConstructor;

@Configuration
@MapperScan("com.coma.emp.mapper")
@RequiredArgsConstructor
public class WebMVCConfigration implements WebMvcConfigurer{

	private final ChattingRoomInterceptor chattingRoomInterceptor;
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/loginpage").setViewName("login/loginpage");
		registry.addViewController("/noticelist").setViewName("board/noticelist");
		registry.addViewController("/freelist").setViewName("board/freelist");
//		registry.addViewController("/writePost").setViewName("board/writePost");
//		registry.addViewController("/proceedList").setViewName("apprdoc/proceedList");
//		registry.addViewController("/docList").setViewName("apprdoc/docList");
		
	}
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(chattingRoomInterceptor).addPathPatterns("/chatting/room/*");
		registry.addInterceptor(new ApprdocInterceptor())
        .addPathPatterns("/apprdoc/allList/**");
	}


	@Bean
	Emp emp() {
		return new Emp();
	}
	
}
