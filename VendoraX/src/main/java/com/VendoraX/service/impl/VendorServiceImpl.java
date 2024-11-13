package com.VendoraX.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.VendoraX.Exception.AccountUnderVerificationException;
import com.VendoraX.Exception.InValidateOTPException;
import com.VendoraX.Exception.OTPExpiredException;
import com.VendoraX.dto.NotificationDTO;
import com.VendoraX.dto.OrderStatisticsDTO;
import com.VendoraX.dto.PaymentSummaryDTO;
import com.VendoraX.dto.VendorDTO;
import com.VendoraX.dto.VendorDashboardDTO;
import com.VendoraX.entity.OrderEntity;
import com.VendoraX.entity.VendorEntity;
import com.VendoraX.mailSending.MailSending;
import com.VendoraX.repository.OrderRepository;
import com.VendoraX.repository.ProductRepository;
import com.VendoraX.repository.VendorRepo;
import com.VendoraX.response.VendorResponse;
import com.VendoraX.service.NotificationService;
import com.VendoraX.service.VendorService;
import com.VendoraX.violation.CustomConstraintViolation;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class VendorServiceImpl implements VendorService {

	@Autowired
	private MailSending mailSending;

	@Autowired
	private VendorRepo vendorRepo;

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private NotificationService notificationService;

	@Override
	public boolean isEmailExists(String email) {
		log.info("checkEmailExistence method exit");
		return this.vendorRepo.existsByEmailId(email);
	}

	@Override
	public boolean isContactNumberExists(long contactNumber) {
		log.info("checkContactNumberExistence method exit");
		return this.vendorRepo.existsByContactNumber(contactNumber);
	}

	@Override
	public boolean isGSTNumberExists(String GSTnumber) {
		log.info("checkGSTNumberExistence method exit");
		return this.vendorRepo.existsByGSTNumber(GSTnumber);
	}

	@Override
	public boolean isWebsiteExists(String website) {
		log.info("checkWebsiteExistence method exit");
		return this.vendorRepo.existsByWebsite(website);
	}

	@Override
	public Set<ConstraintViolation<VendorDTO>> registerVendor(VendorDTO vendorDTO) {

		boolean CheckEmailExitences = vendorRepo.existsByEmailId(vendorDTO.getEmailId());
		boolean checkContactNumberExistence = vendorRepo.existsByContactNumber(vendorDTO.getContactNumber());
		boolean checkWebsiteExistence = vendorRepo.existsByWebsite(vendorDTO.getWebsite());
		boolean checkGSTNumberExistence = vendorRepo.existsByGSTNumber(vendorDTO.getGSTNumber());

		Set<ConstraintViolation<VendorDTO>> constraintViolations = new HashSet<>();

		if (CheckEmailExitences) {
			constraintViolations.add(new CustomConstraintViolation<>("email", "Email already exists"));
		}

		if (checkContactNumberExistence) {
			constraintViolations.add(new CustomConstraintViolation<>("contacNumber", "Contact number already exists"));
		}

		if (checkWebsiteExistence) {
			constraintViolations.add(new CustomConstraintViolation<>("website", "Contact number already exists"));
		}
		if (checkGSTNumberExistence) {
			constraintViolations.add(new CustomConstraintViolation<>("GSTNumber", "GSTNumber already exists"));
		}

		Set<ConstraintViolation<VendorDTO>> dtoConstraintViolations = validate(vendorDTO);
		constraintViolations.addAll(dtoConstraintViolations);

		if (!constraintViolations.isEmpty()) {
			log.error("Constraint violations in SignUpDTO: " + vendorDTO);
			return constraintViolations;
		}
		VendorEntity vendorEntity = new VendorEntity();
		vendorDTO.setImagePath("defaultUserImage.png");
		vendorDTO.setStatus("pending");

		BeanUtils.copyProperties(vendorDTO, vendorEntity);
		VendorEntity save = this.vendorRepo.save(vendorEntity);
		VendorEntity vendor = vendorRepo.findByEmailId(save.getEmailId());
		NotificationDTO notification = new NotificationDTO();
		notification.setSenderId(String.valueOf(vendor.getId())); // Set sender as vendor
		notification.setReceiverId("admin");
		notification.setMessage("A new vendor has registered. Vendor ID: " + vendor.getId());
		notification.setType("NEW_REGISTER");
		notification.setTimestamp(LocalDateTime.now());
		this.notificationService.createNotification(notification.getReceiverId(), notification);

		if (save != null) {
			boolean sendRegisterEmail = mailSending.SendEmailRgisterSuccessfully(vendorDTO);
			if (sendRegisterEmail) {
				log.info("DTO is saved successfully. and Email sent to owmer email Id");
			}
		}

		return Collections.emptySet();

	}

	private Set<ConstraintViolation<VendorDTO>> validate(VendorDTO DTO) {
		ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
		Validator validator = factory.getValidator();
		Set<ConstraintViolation<VendorDTO>> violations = validator.validate(DTO);
		return violations;
	}

	@Override
	public boolean generateLoginOTP(String email) {
		if (email != null) {
			Random random = new Random();
			int generatedOtp = random.nextInt(900000) + 100000;
			String OTP = String.valueOf(generatedOtp);
			LocalDateTime OTPGenerationTime = LocalDateTime.now();

			int updatedRows = this.vendorRepo.saveLoginOTPByEmailId(email, OTP, OTPGenerationTime);
			if (updatedRows > 0) {
				boolean sent = mailSending.sendLoginOTPToEmail(email, OTP);
				System.err.println("login vendor otp=" + generatedOtp);
				return true; // OTP sent successfully or failed
			}
		}
		return false;
	}

	@Override
	public VendorDTO validateOTPAndAuthenticate(String email, String otp)
			throws InValidateOTPException, OTPExpiredException, AccountUnderVerificationException {
		if (email == null || otp == null) {
			throw new IllegalArgumentException("Email and OTP cannot be null.");
		}

		// Fetch vendor entity using email
		VendorEntity vendorEntity = vendorRepo.findByEmailId(email);
		if (vendorEntity == null) {
			throw new InValidateOTPException("No account found with this email.");
		}

		// Assuming vendorEntity contains OTP, OTP generation time, and status
		String storedOTP = vendorEntity.getLoginOTP(); // Assuming 'otp' field exists in VendorEntity
		LocalDateTime generationTime = vendorEntity.getOTPGenerationTime(); // Assuming 'otpGenerationTime' field exists
		String status = vendorEntity.getStatus(); // Assuming 'status' field exists to check account status

		// Check if OTP matches
		if (!otp.equals(storedOTP)) {
			throw new InValidateOTPException("Invalid OTP.");
		}

		// Check if OTP has expired (valid for 2 minutes)
		LocalDateTime currentTime = LocalDateTime.now();
		long minutesPassed = ChronoUnit.MINUTES.between(generationTime, currentTime);

		if (minutesPassed > 2) {
			throw new OTPExpiredException("OTP has expired.");
		}

		// Check if account is under verification
		if ("pending".equalsIgnoreCase(status)) {
			throw new AccountUnderVerificationException(
					"Your account is under verification. You cannot log in at the moment.");
		}

		// If all checks pass, return a VendorDTO object (convert VendorEntity to DTO)
		return convertToVendorDTO(vendorEntity);
	}

	@Override
	public VendorDTO getVendorById(int vendorId) {
		VendorEntity vendorEntity = this.vendorRepo.findById(vendorId).orElse(null);
		if (vendorEntity == null) {
			return null;
		}
		return convertToVendorDTO(vendorEntity);
	}

	@Override
	public Set<ConstraintViolation<VendorDTO>> validateAndUpdateVendorProfile(int vendorId, VendorDTO vendorDTO)
			throws IOException {
		// Validate and update vendor profile
		saveImage(vendorDTO);
		return validateAndUpdateVendor(vendorId, vendorDTO);
	}

	private void saveImage(VendorDTO vendorDTO) throws IOException {
		if (vendorDTO.getImageFile() != null && !vendorDTO.getImageFile().isEmpty()) {
			byte[] fileBytes = vendorDTO.getImageFile().getBytes();
			String filePath = "E:\\vendorManageMentUserProfileImage\\" + vendorDTO.getImageFile().getOriginalFilename();
			File newFile = new File(filePath);
			Path path = Paths.get(newFile.getAbsolutePath());
			Files.write(path, fileBytes);

			vendorDTO.setImagePath(vendorDTO.getImageFile().getOriginalFilename().toString());
		} else {
			VendorEntity entity = this.vendorRepo.findByEmailId(vendorDTO.getEmailId());
			String existingUserImagePath = (entity.getImagePath());
			vendorDTO.setImagePath(existingUserImagePath);
		}
	}

	public Set<ConstraintViolation<VendorDTO>> validateAndUpdateVendor(int vendorId, VendorDTO vendorDTO) {
		// Fetch all vendors and the current vendor details by ID
		List<VendorEntity> allVendors = vendorRepo.findAll();
		VendorEntity vendorOldDetails = vendorRepo.findById(vendorId).orElse(null);

		// Set to hold any constraint violations
		Set<ConstraintViolation<VendorDTO>> constraintViolations = new HashSet<>();

		if (vendorOldDetails == null) {
			// Handle the case when the vendor with the given ID is not found
			constraintViolations.add(new CustomConstraintViolation<>("vendorId", "Vendor not found"));
			return constraintViolations;
		}

		// Check for changes
		boolean emailChanged = !vendorOldDetails.getEmailId().equals(vendorDTO.getEmailId());
		boolean GSTNumberChanged = vendorOldDetails.getGSTNumber() != null
				&& !vendorOldDetails.getGSTNumber().equals(vendorDTO.getGSTNumber());
		boolean websiteChanged = vendorOldDetails.getWebsite() != null
				&& !vendorOldDetails.getWebsite().equals(vendorDTO.getWebsite());
		boolean contactChanged = vendorOldDetails.getContactNumber() != vendorDTO.getContactNumber();

		// Validate email uniqueness
		if (emailChanged
				&& allVendors.stream().anyMatch(entity -> entity.getEmailId().equals(vendorDTO.getEmailId()))) {
			constraintViolations.add(new CustomConstraintViolation<>("email", "Email already exists"));
		}

		// Validate contact number uniqueness
		if (contactChanged
				&& allVendors.stream().anyMatch(entity -> !entity.getEmailId().equals(vendorOldDetails.getEmailId())
						&& entity.getContactNumber() == (vendorDTO.getContactNumber()))) {
			constraintViolations.add(new CustomConstraintViolation<>("contactNumber", "Contact number already exists"));
		}

		// Validate GST number uniqueness
		if (GSTNumberChanged
				&& allVendors.stream().anyMatch(entity -> !entity.getEmailId().equals(vendorOldDetails.getEmailId())
						&& entity.getGSTNumber().equals(vendorDTO.getGSTNumber()))) {
			constraintViolations.add(new CustomConstraintViolation<>("GSTNumber", "GST number already exists"));
		}

		// Validate website uniqueness
		if (websiteChanged
				&& allVendors.stream().anyMatch(entity -> !entity.getEmailId().equals(vendorOldDetails.getEmailId())
						&& entity.getWebsite().equals(vendorDTO.getWebsite()))) {
			constraintViolations.add(new CustomConstraintViolation<>("website", "Website already exists"));
		}

		// If there are violations, return them early
		if (!constraintViolations.isEmpty()) {
			log.error("Constraint violations in vendor update operation for vendorId: " + vendorId);
			return constraintViolations;
		}

		// If the fields haven't changed, retain the old values
		if (!emailChanged) {
			vendorDTO.setEmailId(vendorOldDetails.getEmailId());
		}
		if (!GSTNumberChanged) {
			vendorDTO.setGSTNumber(vendorOldDetails.getGSTNumber());
		}
		if (!websiteChanged) {
			vendorDTO.setWebsite(vendorOldDetails.getWebsite());
		}
		if (!contactChanged) {
			vendorDTO.setContactNumber(vendorOldDetails.getContactNumber());
		}

		// Update other fields
		vendorOldDetails.setOwnerName(vendorDTO.getOwnerName());
		vendorOldDetails.setEmailId(vendorDTO.getEmailId());
		vendorOldDetails.setContactNumber(vendorDTO.getContactNumber());
		vendorOldDetails.setAltContactNumber(vendorDTO.getAltContactNumber());
		vendorOldDetails.setVendorName(vendorDTO.getVendorName());
		vendorOldDetails.setStartDate(vendorDTO.getStartDate());
		vendorOldDetails.setGSTNumber(vendorDTO.getGSTNumber());
		vendorOldDetails.setPincode(vendorDTO.getPincode());
		vendorOldDetails.setImagePath(vendorDTO.getImagePath());
		vendorOldDetails.setAddress(vendorDTO.getAddress());

		// Save updated vendor details
		boolean update = vendorRepo.save(vendorOldDetails) != null;

		if (update) {
			log.info("Vendor with email " + vendorOldDetails.getEmailId() + " updated successfully.");
		} else {
			log.error("Failed to update vendor with email: " + vendorOldDetails.getEmailId());
			constraintViolations.add(new CustomConstraintViolation<>("update", "Failed to update vendor profile"));
		}

		return constraintViolations;
	}

	private VendorDTO convertToVendorDTO(VendorEntity vendorEntity) {
		VendorDTO vendorDTO = new VendorDTO();
		BeanUtils.copyProperties(vendorEntity, vendorDTO);

		return vendorDTO;
	}

	@Override
	public VendorDashboardDTO getVendorDashboard(int vendorId) {
		VendorEntity vendorEntity = this.vendorRepo.findById(vendorId).orElse(null);
		if (vendorEntity == null) {
			return null; // or throw an exception if preferred
		}
		long totalProducts = this.productRepository.countByVendor(vendorEntity);
		List<OrderEntity> orderEntities = this.orderRepository.findByVendor(vendorEntity);

		// Calculate order statistics
		long totalOrders = orderEntities.size();
		long deliveredCount = orderEntities.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus().equalsIgnoreCase("delivered")).count();
		long confirmedOrders = orderEntities.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus().equalsIgnoreCase("Confirmed")).count();
		long pendingOrders = confirmedOrders; // Assuming confirmed includes received orders

		// Calculate payment summary
		double totalAmountToPay = orderEntities.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus() != null
						&& orderEntity.getOrderStatus().equalsIgnoreCase("received"))
				.mapToDouble(OrderEntity::getOrderAmount).sum();

		double amountPaid = orderEntities.stream()
				.filter(orderEntity -> orderEntity.getPaymentStatus() != null
						&& orderEntity.getPaymentStatus().equalsIgnoreCase("paid"))
				.mapToDouble(OrderEntity::getOrderAmount).sum();

		double remainingBalance = totalAmountToPay - amountPaid;

		// Prepare OrderStatisticsDTO
		OrderStatisticsDTO orderStatistics = new OrderStatisticsDTO();
		orderStatistics.setTotalProducts(totalProducts);
		orderStatistics.setTotalOrders(totalOrders);
		orderStatistics.setDeliveredCount(deliveredCount);
		// orderStatistics.setConfirmedOrders(confirmedOrders);
		orderStatistics.setPendingOrders(pendingOrders); // Include pending orders count

		// Prepare PaymentSummaryDTO
		PaymentSummaryDTO paymentSummary = new PaymentSummaryDTO();
		paymentSummary.setTotalAmountToPay(totalAmountToPay);
		paymentSummary.setAmountPaid(amountPaid);
		paymentSummary.setRemainingBalance(remainingBalance);

		// Prepare VendorDashboardDTO
		VendorDashboardDTO dashboardDTO = new VendorDashboardDTO();
		dashboardDTO.setOrderStatistics(orderStatistics);
		dashboardDTO.setPaymentSummary(paymentSummary);

		return dashboardDTO;
	}

	@Override
	public VendorResponse getAllVendorsByAdmin(int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<VendorEntity> vendorPage;

		if (query != null && !query.isEmpty()) {
			// If query exists, search across all vendors for the product name
			vendorPage = vendorRepo.findAllByEmailIdContainingIgnoreCase(query, pageable);
		} else {
			// If no query, return all products for admin
			vendorPage = vendorRepo.findAll(pageable);
		}

		VendorResponse response = new VendorResponse();
		response.setVendors(
				vendorPage.getContent().stream().map(this::convertToVendorDTO).collect(Collectors.toList()));
		response.setTotalPages(vendorPage.getTotalPages());

		return response;
	}

	public boolean updateVendorStatus(int vendorId, String status) {
		Optional<VendorEntity> vendorOptional = vendorRepo.findById(vendorId);
		if (vendorOptional.isPresent()) {
			VendorEntity vendor = vendorOptional.get();
			vendor.setStatus(status);
			vendorRepo.save(vendor);
			if (status.equalsIgnoreCase("approved")) {
				NotificationDTO notification = new NotificationDTO();
				notification.setSenderId("admin"); // Set sender as vendor
				notification.setReceiverId(String.valueOf(vendorId));
				notification.setMessage("Welcome to our company! Your vendor status has been approved.");
				notification.setType("WELCOME");
				notification.setTimestamp(LocalDateTime.now());
				this.notificationService.createNotification(notification.getReceiverId(), notification);
				return true;
			}
			return true;
		} else {
			return false; // Vendor not found
		}
	}

}
