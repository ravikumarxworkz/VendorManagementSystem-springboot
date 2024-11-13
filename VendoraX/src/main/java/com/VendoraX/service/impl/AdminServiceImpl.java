package com.VendoraX.service.impl;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.VendoraX.dto.AdminDTO;
import com.VendoraX.dto.AdminDashboardDTO;
import com.VendoraX.dto.OrderStatisticsDTO;
import com.VendoraX.dto.PaymentSummaryDTO;
import com.VendoraX.entity.AdminEntity;
import com.VendoraX.entity.OrderEntity;
import com.VendoraX.entity.ProductEntity;
import com.VendoraX.mailSending.MailSending;
import com.VendoraX.repository.AdminRepository;
import com.VendoraX.repository.OrderRepository;
import com.VendoraX.repository.ProductRepository;
import com.VendoraX.repository.VendorRepo;
import com.VendoraX.service.AdminService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class AdminServiceImpl implements AdminService {

	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);

	@Autowired
	private MailSending mailSending;

	@Autowired
	private AdminRepository adminRepository;

	@Autowired
	private VendorRepo vendorRepository;

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private ProductRepository productRepository;



	@Override
	@Transactional
	public boolean generateAndSendOTP(String email) {
		try {
			AdminEntity adminEntity = adminRepository.findByEmailId(email);

			// Check if the email exists in the database
			if (adminEntity == null || adminEntity.getEmailId() == null) {
				logger.error("Email ID not found in the database: {}", email);

				return false;
			}

			// Generate OTP and save to the entity
			String otp = generateOTP();
			adminEntity.setOtp(otp);
			adminRepository.save(adminEntity); // Save the OTP in the database
			mailSending.sendOTPAdminEmail(email, otp, adminEntity.getAdminName());
			System.err.println("OTP successfully sent to=" + otp);
			logger.info("OTP successfully sent to {}", adminEntity.getEmailId());
			return true;
		} catch (Exception e) {
			logger.error("Error occurred while generating and sending OTP", e);
			return false;
		}
	}

	@Override
	@Transactional
	public boolean validateOTP(String email, String otp) {
		try {
			AdminEntity adminEntity = adminRepository.findByEmailId(email);

			// Check if the email and OTP exist and match
			if (adminEntity != null && adminEntity.getOtp() != null && adminEntity.getOtp().equals(otp)) {
				// Reset OTP after validation
				adminEntity.setOtp(null);
				adminRepository.save(adminEntity);
				logger.info("OTP validated and reset for email: {}", email);
				return true;
			} else {
				logger.error("Invalid OTP for email: {}", email);
				return false;
			}
		} catch (Exception e) {
			logger.error("Error validating OTP for email: {}", email, e);
			return false;
		}
	}

	@Override
	public AdminDTO adminLogin(String email, String password) {
		try {
			if (email != null && password != null) {
				AdminEntity adminEntity = adminRepository.findByEmailId(email);

				// Verify if email and password match
				if (adminEntity != null && adminEntity.getPassword().equals(password)) {
					logger.info("Admin login successful for email: {}", email);
					return convertEntityToDTO(adminEntity);
				} else {
					logger.error("Invalid email or password for email: {}", email);
					return null;
				}
			}
		} catch (Exception e) {
			logger.error("Error during admin login", e);
		}
		return null;
	}

	/**
	 * Generate a 6-digit OTP.
	 */
	private String generateOTP() {
		Random random = new Random();
		int otpNumber = 100000 + random.nextInt(900000); // Generates a 6-digit OTP
		return String.valueOf(otpNumber);
	}

	private AdminDTO convertEntityToDTO(AdminEntity adminEntity) {
		AdminDTO adminDTO = new AdminDTO();
		adminDTO.setId(adminEntity.getId());
		adminDTO.setEmailId(adminEntity.getEmailId());
		adminDTO.setAdminName(adminEntity.getAdminName());
		// Set additional properties as needed
		return adminDTO;
	}

	@Override
	public AdminDashboardDTO getAdminDashboard() {
		// Step 1: Fetch total vendor count
		long totalVendorCount = this.vendorRepository.count(); // Assuming there's a count() method to get total vendors

		// Step 2: Fetch all orders for admin to calculate order statistics
		List<OrderEntity> allOrders = this.orderRepository.findAll(); // Assuming admin has access to all orders
		List<ProductEntity> allProducts = this.productRepository.findAll();
		// Step 3: Calculate order statistics
		long totalOrders = allOrders.size();
		long totalProducts = allProducts.size();
		long deliveredCount = allOrders.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus().equalsIgnoreCase("delivered")).count();
		long confirmedOrders = allOrders.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus().equalsIgnoreCase("Confirmed")).count();
		long receivedOrders = allOrders.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus().equalsIgnoreCase("received")).count();
		long pendingOrders = confirmedOrders; // Assuming confirmed includes received orders

		// Step 4: Calculate payment summary for admin
		double totalAmountToPay = allOrders.stream()
				.filter(orderEntity -> orderEntity.getOrderStatus() != null
						&& orderEntity.getOrderStatus().equalsIgnoreCase("received"))
				.mapToDouble(OrderEntity::getOrderAmount).sum();

		double amountPaid = allOrders.stream()
				.filter(orderEntity -> orderEntity.getPaymentStatus() != null
						&& orderEntity.getPaymentStatus().equalsIgnoreCase("paid"))
				.mapToDouble(OrderEntity::getOrderAmount).sum();

		double remainingBalance = totalAmountToPay - amountPaid;

		// Step 5: Prepare OrderStatisticsDTO for admin
		OrderStatisticsDTO orderStatistics = new OrderStatisticsDTO();
		orderStatistics.setTotalOrders(totalOrders);
		orderStatistics.setDeliveredCount(deliveredCount);
		orderStatistics.setPendingOrders(pendingOrders);
		orderStatistics.setTotalProducts(totalProducts);
		orderStatistics.setReceivedOrders(receivedOrders);

		// Step 6: Prepare PaymentSummaryDTO for admin
		PaymentSummaryDTO paymentSummary = new PaymentSummaryDTO();
		paymentSummary.setTotalAmountToPay(totalAmountToPay);
		paymentSummary.setAmountPaid(amountPaid);
		paymentSummary.setRemainingBalance(remainingBalance);

		// Step 7: Prepare AdminDashboardDTO
		AdminDashboardDTO adminDashboardDTO = new AdminDashboardDTO();
		adminDashboardDTO.setTotalVendorCount(totalVendorCount);
		adminDashboardDTO.setOrderStatistics(orderStatistics);
		adminDashboardDTO.setPaymentSummary(paymentSummary);

		return adminDashboardDTO;
	}

}
