package com.VendoraX.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.VendoraX.Exception.AccountUnderVerificationException;
import com.VendoraX.Exception.InValidateOTPException;
import com.VendoraX.Exception.OTPExpiredException;
import com.VendoraX.dto.VendorDTO;
import com.VendoraX.dto.VendorDashboardDTO;
import com.VendoraX.response.VendorResponse;
import com.VendoraX.service.VendorService;
import com.VendoraX.utils.SessionManager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintViolation;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/")
@Slf4j
@SessionAttributes("userProfile")
public class VendorController {

	@Autowired
	private VendorService vendorService;

	@Autowired
	private SessionManager sessionManager;

	@GetMapping("/genrateLoginOTPAndSave")
	@ResponseBody
	public ResponseEntity<String> genrateOTPAndSave(@RequestParam String email) {
		boolean emailExistsInDatabase = vendorService.generateLoginOTP(email);
		if (emailExistsInDatabase) {
			return ResponseEntity.ok("OPTSentSuccessfully");
		} else {
			return ResponseEntity.ok("OPTSentnotSuccessfully");
		}
	}

	@PostMapping("/logInProfile")
	public String logIn(@RequestParam String email, @RequestParam String OTP, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		log.info("Attempting login for email: {}", email);
		log.info("Attempting login for email: {}", email);
		if (sessionManager.isUserLoggedIn(email)) {
			redirectAttributes.addFlashAttribute("errorMessage", "User is already logged in from another session.");
			return "redirect:/logInPage";
		}
		try {
			VendorDTO vendor = vendorService.validateOTPAndAuthenticate(email, OTP);

			if (vendor != null) {
				HttpSession session = request.getSession();
				session.setAttribute("loggedInUserEmail", vendor.getEmailId());
				session.setAttribute("loggedInUserId", vendor.getId());
				session.setAttribute("userProfile", vendor);
				session.setAttribute("userProfileImage", vendor.getImagePath());

				// Register session to allow only one session per user
				sessionManager.registerSession(vendor.getEmailId(), session);

				log.info("Login successful for email: {}, userId: {}", vendor.getEmailId(), vendor.getId());
				log.info("Redirecting to profile page after successful login.");
				return "redirect:/profile"; // Redirect to profile page
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "Login failed. Please check your credentials.");
				log.warn("Login failed for email: {}", email);
				return "redirect:/logInPage"; // Redirect to login page on failure
			}
		} catch (InValidateOTPException | AccountUnderVerificationException | OTPExpiredException e) {
			redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
			log.error("Login error for email: {}. Error: {}", email, e.getMessage());
			return "redirect:/logInPage"; // Redirect to login page on error
		}
	}

	@GetMapping("/profile")
	public String getProfilePage(HttpSession session, Model model, HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		
		Object loggedInUserId = session.getAttribute("loggedInUserId");
		log.warn("User is not logged in. Redirecting to login page.",loggedInUserId);
		System.out.println("User is  logged in. Redirecting to profile page"+loggedInUserId);
		if (loggedInUserId == null) {
			log.warn("User is not logged in. Redirecting to login page.");
			return "redirect:/logInPage";
		}

		Object userProfile = session.getAttribute("userProfile");
		Object userProfileImage = session.getAttribute("userProfileImage");

		model.addAttribute("userProfile", userProfile);
		model.addAttribute("userProfileImage", userProfileImage);

		return "profile"; // Ensure that 'profile' corresponds to the view name
	}

	// Logout method
	@GetMapping("/vendorLogout")
	public String logout(HttpSession session) {
		String email = (String) session.getAttribute("loggedInUserEmail");
		if (email != null) {
			// Unregister the session on logout
			sessionManager.unregisterSession(email);
		}
		// Invalidate session to log out the user
		session.invalidate();
		return "redirect:/logInPage"; // Redirect to login page after logout
	}

	@GetMapping("/getVendorById")
	public ResponseEntity<?> getVendorById(@RequestParam("vendorId") int vendorId) {
		try {
			VendorDTO vendor = vendorService.getVendorById(vendorId);
			if (vendor == null) {
				return ResponseEntity.status(404).body("Vendor not found.");
			}
			return ResponseEntity.ok(vendor);
		} catch (Exception e) {
			// Log the error for debugging purposes
			System.err.println("Error fetching vendor details: " + e.getMessage());
			return ResponseEntity.status(500).body("An error occurred while fetching vendor details.");
		}
	}

	@PostMapping("/updateVendorProfile")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateVendorProfile1(@ModelAttribute VendorDTO dto,
			HttpSession session) {
		log.info("Updating vendor profile for email: {}", dto.getEmailId());
		Map<String, Object> response = new HashMap<>();

		try {
			int loggedInUserId = (int) session.getAttribute("loggedInUserId");
			log.info("Updating vendor profile for email: {}", loggedInUserId);
			// Validate and update vendor profile
			Set<ConstraintViolation<VendorDTO>> violations = vendorService
					.validateAndUpdateVendorProfile(loggedInUserId, dto);

			if (violations.isEmpty()) {
				VendorDTO vendor = vendorService.getVendorById(loggedInUserId);
				session.setAttribute("userProfileImage", vendor.getImagePath());
				// Success: Return a success message only
				response.put("message", "Profile updated successfully!");
				log.info("Profile updated successfully for email: {}", dto.getEmailId());
				return ResponseEntity.ok(response);
			} else {
				// Failure: Collect error messages
				List<String> errorMessages = new ArrayList<>();
				for (ConstraintViolation<VendorDTO> violation : violations) {
					String field = violation.getPropertyPath() != null ? violation.getPropertyPath().toString()
							: "Unknown Field";
					String message = violation.getMessage();
					log.warn("Validation failed for field: {}, message: {}", field, message);
					errorMessages.add(message);
				}

				// Return specific error messages
				response.put("errors", errorMessages);
				return ResponseEntity.ok(response);
			}
		} catch (Exception e) {
			// Catch any unexpected exceptions
			response.put("error", "An error occurred while updating the profile. Please try again.");
			log.error("Profile update failed for email: {} with error: {}", dto.getEmailId(), e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@GetMapping("/getVendorDashboard/{vendorId}")
	@ResponseBody
	public VendorDashboardDTO getVendorDashboard(@PathVariable int vendorId) {
		// Your logic to retrieve the dashboard data for the given vendorId
		return vendorService.getVendorDashboard(vendorId);
	}

	@GetMapping("/getAllVendorsByAdmin")
	public ResponseEntity<VendorResponse> getAllVednorsByAdmin(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query) {
		try {
			VendorResponse response = this.vendorService.getAllVendorsByAdmin(page, size, query);

			return ResponseEntity.ok(response);
		} catch (Exception e) {
			// Log error details
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@PostMapping("/updateVendorStatus")
	public ResponseEntity<?> updateVendorStatus(@RequestParam("vendorId") int vendorId,
			@RequestParam("status") String status) {
		try {
			boolean isUpdated = vendorService.updateVendorStatus(vendorId, status);
			if (isUpdated) {
				return ResponseEntity.ok().body(Collections.singletonMap("success", true));
			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("success", false));
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Collections.singletonMap("error", e.getMessage()));
		}
	}

}
