package com.api.loginproject.services;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.api.loginproject.models.SignUp;
import com.api.loginproject.repositories.SignUpRepository;

@Service
public class SignUpService {
	
	@Autowired
	SignUpRepository signUpRepository;
	
	@Transactional
	public SignUp save(SignUp signUp) {
		return signUpRepository.save(signUp);
	}
	
	@Transactional
	public void deleteByEmail(String email) {
		signUpRepository.deleteByEmail(email);
	}
	
	@Transactional
	public void updateValuesByEmail (String firstName, String lastName, String password, String email) {
		signUpRepository.updateValuesByEmail(firstName, lastName, password, email);
	}
	
	public boolean existsByEmail(String email) {
		return signUpRepository.existsByEmail(email);
	}
	
	public SignUp findAllByEmail(String email) {
		return signUpRepository.findAllByEmail(email);
	}
	
	public SignUp findAllByEmailAndPassword(String email, String password) {
		return signUpRepository.findAllByEmailAndPassword(email, password);
	}
	
	public int findIdByEmailAndPassword(String email, String password) {
		return signUpRepository.findIdByEmailAndPassword(email, password);
	}

}
