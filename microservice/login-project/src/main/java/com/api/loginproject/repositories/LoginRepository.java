package com.api.loginproject.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.api.loginproject.models.Login;

@Repository
public interface LoginRepository extends JpaRepository<Login, Integer>{
	
	@Transactional
	void deleteByEmail(String email);
	
	@Transactional
	@Modifying
	@Query("UPDATE Login l SET l.password = :password WHERE l.email = :email")
	void updatePasswordByEmail(@Param("password") String password, @Param("email") String email);

	boolean existsByEmailAndPassword (String email, String password);

	boolean existsByEmail(String email);

}
