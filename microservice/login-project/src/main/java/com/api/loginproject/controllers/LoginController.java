package com.api.loginproject.controllers;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.api.loginproject.dtos.LoginDto;
import com.api.loginproject.models.Login;
import com.api.loginproject.services.LoginService;
import com.api.loginproject.services.SignUpService;

@RestController
@CrossOrigin(origins= "*", maxAge = 3600)
@RequestMapping("/login_project")
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	SignUpService signUpService;
	
	@PostMapping
	@RequestMapping(value = "/login", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<Object> login (@Valid LoginDto loginDto){
		var login = new Login();
		BeanUtils.copyProperties(loginDto, login);
		
		if(!loginService.existsByEmail(login.getEmail())) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("There's no account associated with this email. Try another email address or create a new account.");
		}
		
		if(loginService.existsByEmailAndPassword(
						login.getEmail(), login.getPassword())) {
			return ResponseEntity.status(HttpStatus.OK)
					.body("Accepted!");
		}
		else{
			return ResponseEntity.status(HttpStatus.CONFLICT)
					.body("Invalid Credentials!");
		}
	}
	
	@PostMapping
	@RequestMapping(value= "/delete", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<Object> delete (@Valid LoginDto loginDto){
		var login = new Login();
		BeanUtils.copyProperties(loginDto, login);
		loginService.deleteByEmail(login.getEmail());
		signUpService.deleteByEmail(login.getEmail());
		return ResponseEntity.status(HttpStatus.OK).body("Account deleted successfully!");
	}
	
}
