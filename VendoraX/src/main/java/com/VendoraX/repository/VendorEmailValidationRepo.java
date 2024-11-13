package com.VendoraX.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.EmailValidationEntity;


@Repository
public interface VendorEmailValidationRepo extends JpaRepository<EmailValidationEntity, Integer> {

	
	 // Find the most recent OTP by email
    Optional<EmailValidationEntity> findFirstByEmailOrderByOtpCreatedTimeDesc(String email);

    // Delete all email validation data by email
    void deleteByEmail(String email);
}
