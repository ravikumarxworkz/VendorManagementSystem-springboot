package com.VendoraX.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "email_validation")
public class EmailValidationEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	//@Column(name = "id")
	private int id;
	//@Column(name = "validation_emailId")
	private String email;
	//@Column(name = "validation_OTP")
	private String otp;
	//@Column(name = "OTP_Created_Time")
	private LocalDateTime otpCreatedTime;

}
