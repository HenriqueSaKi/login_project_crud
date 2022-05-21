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
import com.api.loginproject.dtos.SignUpDto;
import com.api.loginproject.models.Login;
import com.api.loginproject.models.SignUp;
import com.api.loginproject.services.LoginService;
import com.api.loginproject.services.SignUpService;

@RestController
@CrossOrigin(origins= "*", maxAge = 3600)
@RequestMapping("/login_project")
public class SingUpController {
	
	@Autowired
	SignUpService signUpService;
	@Autowired
	LoginService loginService;
	
	@PostMapping
	@RequestMapping(value = "/register", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<Object> registerAccount (@Valid SignUpDto signUpDto){
		var signUp = new SignUp();
		BeanUtils.copyProperties(signUpDto, signUp);
		
		if(signUpService.existsByEmail(signUp.getEmail())) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("Email already registered.");
		}
		
		signUpService.save(signUp);
		
		if(signUp.getId() != 0) {
			var login = new Login(signUp.getId(), signUp.getEmail(), signUp.getPassword());
			return ResponseEntity.status(HttpStatus.OK).body(loginService.save(login));
		}
		else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed request.");
		}
		
	}
	
	@PostMapping 
	@RequestMapping(value = "/user", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<Object> userData (@Valid LoginDto loginDto){
		var login = new Login();
		BeanUtils.copyProperties(loginDto, login);
		return ResponseEntity.status(HttpStatus.OK)
				.body(signUpService
						.findAllByEmailAndPassword(login.getEmail(), login.getPassword()));
	}
	
	@PostMapping
	@RequestMapping(value= "/update", consumes = "application/x-www-form-urlencoded")
	public ResponseEntity<Object> update (@Valid SignUpDto signUpDto){
		var signUp = new SignUp();
		BeanUtils.copyProperties(signUpDto, signUp);
		
		var signUpOld = signUpService.findAllByEmail(signUp.getEmail());
		var signUpNew = new SignUp();
		
		if(signUpOld.getFirstName() != signUp.getFirstName()) {
			signUpNew.setFirstName(signUp.getFirstName());
		}
		else {
			signUpNew.setFirstName(signUpOld.getFirstName());
		}
		
		if(signUpOld.getLastName() != signUp.getLastName()) {
			signUpNew.setLastName(signUp.getLastName());
		}
		else {
			signUpNew.setLastName(signUpOld.getLastName());
		}
		
		if(signUpOld.getPassword() != signUp.getPassword()) {
			signUpNew.setPassword(signUp.getPassword());
			loginService.updatePasswordByEmail(signUp.getPassword(), signUp.getEmail());
		}
		else {
			signUpNew.setPassword(signUpOld.getPassword());
		}
		
		signUpNew.setEmail(signUp.getEmail());
		
		signUpService.updateValuesByEmail(signUpNew.getFirstName(), signUpNew.getLastName(), signUpNew.getPassword(), signUpNew.getEmail());
		
		return ResponseEntity.status(HttpStatus.OK).body("Updated successfully!");
		
	}

}
