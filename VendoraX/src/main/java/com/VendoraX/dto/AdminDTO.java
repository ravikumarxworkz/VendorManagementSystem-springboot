package com.VendoraX.dto;


import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminDTO {

	@Id
	private int id;
	private String adminName;
	private String emailId;
	private String password;
	private String otp;

}
