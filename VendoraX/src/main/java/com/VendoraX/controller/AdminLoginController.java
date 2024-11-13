package com.VendoraX.controller;

import java.io.IOException;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.VendoraX.dto.AdminDTO;
import com.VendoraX.dto.AdminDashboardDTO;
import com.VendoraX.service.AdminService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/")
public class AdminLoginController {

    @Autowired
    private AdminService adminService;
    
    

	

	/*---------------------------------- CHECK ADMIN EMAIL AND GENERATE LOGIN OTP  METHOD------------------------------------ */

	@GetMapping("/email/check")
	public ResponseEntity<String> checkAdminEmail(@RequestParam String email) {
		boolean emailExists = adminService.generateAndSendOTP(email);
		if (emailExists) {
			return ResponseEntity.ok("email_exists");
		} else {
			return ResponseEntity.ok("email_not_found");
		}
	}

	/*---------------------------------- VALIDATE ADMIN LFOIN OTP  METHOD------------------------------------ */
	@PostMapping("/otp/validate")
	public ResponseEntity<String> validateAdminOTP(@RequestParam String email, @RequestParam String otp) {
		boolean isOtpValid = adminService.validateOTP(email, otp);
		if (isOtpValid) {
			return ResponseEntity.ok("otp_valid");
		} else {
			return ResponseEntity.ok("otp_invalid");
		}
	}

	@GetMapping("/overview")
	@ResponseBody
	public ResponseEntity<AdminDashboardDTO> getAdminDashboard(HttpSession session) {
		// Check if the session contains the logged-in admin's email or ID
		String adminEmail = (String) session.getAttribute("loggedInAdminEmail");
		if (adminEmail == null) {
			// If the admin is not logged in, return an unauthorized response
			return ResponseEntity.status(401).body(null); // 401 Unauthorized
		}

		// Fetch the admin dashboard data
		AdminDashboardDTO adminDashboardDTO = adminService.getAdminDashboard();
		if (adminDashboardDTO != null) {
			return ResponseEntity.ok(adminDashboardDTO);
		} else {
			return ResponseEntity.status(404).body(null); // 404 Not Found if dashboard data is unavailable
		}
	}

    /*----------------------------------ADMIN LOGIN WITH PASSWORD METHOD------------------------------------ */
    @PostMapping("/adminLogin")
    public String adminLogin(@RequestParam String email, @RequestParam String password, Model model,
                             HttpServletRequest request, HttpSession session) {
        // Service returns an AdminDTO if credentials are correct
        AdminDTO login = adminService.adminLogin(email, password);

        if (login != null) {
            // Invalidate the previous session if exists to prevent session fixation
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            // Create a new session for the logged-in admin
            HttpSession newSession = request.getSession(true);

            // Set session attributes with necessary admin details
            newSession.setAttribute("loggedInAdminEmail", login.getEmailId());
            newSession.setAttribute("loggedInAdminId", login.getId());

            // Set session timeout (optional, in seconds)
            newSession.setMaxInactiveInterval(1800); // 30 minutes

            return "adminpage"; // Redirect to the admin page
        } else {
            // Incorrect login credentials, return an error message
            model.addAttribute("error", "Invalid email or password");
            return "adminlogin"; // Redirect back to the login page with error
        }
    }

    /*----------------------------------ADMIN LOGOUT METHOD------------------------------------ */
    @GetMapping("/adminLogout")
    public String logOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get the current session without creating a new one
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidate the session to log out the user
            session.invalidate();
        }

        // Prevent the browser from caching the sensitive admin pages
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Redirect to the homepage or login page after logout
        return "redirect:/homePage";
    }
    

    
}
