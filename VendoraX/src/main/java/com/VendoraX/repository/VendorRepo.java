package com.VendoraX.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.VendorEntity;

import jakarta.transaction.Transactional;

import java.time.LocalDateTime;


@Repository
public interface VendorRepo extends JpaRepository<VendorEntity, Integer> {

	VendorEntity findByEmailId(String emailId);

	boolean existsByEmailId(String emailId);

	boolean existsByContactNumber(long contactNumber);

	boolean existsByGSTNumber(String gstNumber);

	boolean existsByWebsite(String website);

	@Modifying
	@Transactional
	@Query("UPDATE VendorEntity v SET v.loginOTP = :loginOTP, v.OTPGenerationTime = :OTPGenerationTime WHERE v.emailId = :emailId")
	int saveLoginOTPByEmailId(@Param("emailId") String email, @Param("loginOTP") String loginOTP,
			@Param("OTPGenerationTime") LocalDateTime otpGenerationTime);

	Page<VendorEntity> findAllByEmailIdContainingIgnoreCase(String emailId, Pageable pageable);

	Page<VendorEntity> findAll(Pageable pageable);
}
