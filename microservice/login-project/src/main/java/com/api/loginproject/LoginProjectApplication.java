package com.api.loginproject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class LoginProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(LoginProjectApplication.class, args);
	}

	@GetMapping("/login_project/isAvailable")
	public String index (){
		return "The service is available!";
	}

}
