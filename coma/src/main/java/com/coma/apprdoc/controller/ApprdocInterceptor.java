package com.coma.apprdoc.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.coma.model.dto.Emp;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ApprdocInterceptor implements HandlerInterceptor, WebMvcConfigurer{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

       String empId = request.getParameter("empId");
       
       Emp principal = (Emp)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
       
       
       
       
        if (principal.getEmpId().equals(empId)) {
            return true; 
        } else {
            response.sendRedirect(request.getContextPath()+"/error-page/403");
            return false; 
        }
	}

	

		
}
