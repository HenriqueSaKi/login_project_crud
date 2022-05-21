package com.api.loginproject.services;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.api.loginproject.models.Login;
import com.api.loginproject.repositories.LoginRepository;

@Service
public class LoginService {
	
	@Autowired
	LoginRepository loginRepository;
	
	@Transactional
	public Login save(Login login) {
		return loginRepository.save(login);
	}
	
	@Transactional
	public void deleteByEmail(String email) {
		loginRepository.deleteByEmail(email);
	}
	
	public boolean existsByEmailAndPassword(String email, String password) {
		return loginRepository.existsByEmailAndPassword(email, password);
	}

	public void updatePasswordByEmail(String password, String email) {
		loginRepository.updatePasswordByEmail(password, email);
	}

	public boolean existsByEmail(String email) {
		return loginRepository.existsByEmail(email);
	}
	
}
