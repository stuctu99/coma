package com.coma.security;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class CustomErrorController implements ErrorController {
	
	@GetMapping("/error-page/404")
    public String errorPage404() {
        return "errors/404";
    }

	@GetMapping("/error-page/500")
    public String errorPage500() {
        return "errors/500";
    }
	
}
