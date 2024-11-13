package com.VendoraX.service;

import com.VendoraX.dto.AdminDTO;
import com.VendoraX.dto.AdminDashboardDTO;

public interface AdminService {

	boolean generateAndSendOTP(String email);

	boolean validateOTP(String email, String otp);

	AdminDTO adminLogin(String email, String password);

	AdminDashboardDTO getAdminDashboard();

}
