package com.VendoraX.service;

public interface EmailIdValidationService {

	boolean saveOTPByEmailId(String email);
	
	boolean validateOTP(String email, String otp);

}
