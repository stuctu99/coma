package com.coma.security;

import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;

//@Component
//public class WebServerCustomizer implements WebServerFactoryCustomizer<ConfigurableWebServerFactory> {

//	@Override
//	public void customize(ConfigurableWebServerFactory factory) {
//		ErrorPage errorPage404 = new ErrorPage(HttpStatus.NOT_FOUND, "/GDJ71_COMA_final/error-page/404");
//        ErrorPage errorPage500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/GDJ71_COMA_final/error-page/500");
//        ErrorPage errorPageRuntimeException = new ErrorPage(RuntimeException.class, "/GDJ71_COMA_final/error-page/500");
//        factory.addErrorPages(errorPage404, errorPage500, errorPageRuntimeException);
//	}
	
//}
