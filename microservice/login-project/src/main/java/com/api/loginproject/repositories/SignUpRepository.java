package com.api.loginproject.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.api.loginproject.models.SignUp;

@Repository
public interface SignUpRepository extends JpaRepository<SignUp, Integer>{
	
	@Transactional
	void deleteByEmail(String email);
	
	@Transactional
	@Modifying
	@Query("UPDATE SignUp s SET s.firstName = :firstname , s.lastName = :lastname , s.password = :password WHERE s.email = :email")
	void updateValuesByEmail(@Param("firstname") String firstName, @Param("lastname") String lastName, @Param("password") String password, @Param("email") String email);
	
	boolean existsByEmail(String email);

	int findIdByEmailAndPassword(String email, String password);

	SignUp findAllByEmail(String email);

	SignUp findAllByEmailAndPassword(String email, String password);

}
