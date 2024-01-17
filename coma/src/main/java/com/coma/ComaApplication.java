package com.coma;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/*@EnableScheduling*/
@SpringBootApplication
public class ComaApplication {

	public static void main(String[] args) {
		SpringApplication.run(ComaApplication.class, args);
	}

}