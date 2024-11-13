package com.VendoraX.dto;

import java.time.LocalDateTime;

import jakarta.persistence.Id;
import lombok.Data;

@Data
public class EmailValidationDTO {

	@Id
	private int id;
	private String email;
	private String otp;
	private LocalDateTime createdAt;

}
