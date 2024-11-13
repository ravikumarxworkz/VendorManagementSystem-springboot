package com.VendoraX.service;

import java.io.IOException;
import java.util.Set;

import com.VendoraX.Exception.AccountUnderVerificationException;
import com.VendoraX.Exception.InValidateOTPException;
import com.VendoraX.Exception.OTPExpiredException;
import com.VendoraX.dto.VendorDTO;
import com.VendoraX.dto.VendorDashboardDTO;
import com.VendoraX.response.VendorResponse;

import jakarta.validation.ConstraintViolation;

public interface VendorService {

	boolean isEmailExists(String email);

	boolean isContactNumberExists(long contactNumber);

	boolean isGSTNumberExists(String gstNumber);

	boolean isWebsiteExists(String website);

	VendorDashboardDTO getVendorDashboard(int VendorId);

	VendorDTO getVendorById(int vendorId);

	Set<ConstraintViolation<VendorDTO>> registerVendor(VendorDTO vendorDTO);

	boolean generateLoginOTP(String email);

	boolean updateVendorStatus(int vendorId, String status);

	VendorDTO validateOTPAndAuthenticate(String email, String otp)
			throws InValidateOTPException, OTPExpiredException, AccountUnderVerificationException;

	Set<ConstraintViolation<VendorDTO>> validateAndUpdateVendorProfile(int vendorId, VendorDTO vendorDTO)
			throws IOException;

	VendorResponse getAllVendorsByAdmin(int page, int size, String query);


}
