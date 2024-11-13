package com.VendoraX.mailSending;

import java.util.Objects;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.VendoraX.configuration.MailConfiguration;
import com.VendoraX.dto.VendorDTO;

import jakarta.mail.internet.MimeMessage;

import org.springframework.mail.SimpleMailMessage;

@Service
public class MailSending {

	@Autowired
	private MailConfiguration mailConfiguration;

	// sendEmailVerficationOTP Method
	public boolean sendEmailVerficationOTP(String email, String OTP) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
		message.setTo(email);
		message.setSubject("Email Verification OTP");
		message.setText("Dear User,\n\n" + "Your OTP for email verification is: " + OTP + "\n\n"
				+ "Please use this OTP to verify your email address.\n\n" + "Best regards,\n"
				+ "xworkz vendor management Team");

		try {
			mailSender.send(message); // Use mailSender to send the email
			System.out.println("Email verification OTP sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Send Email Rgistertion Successfully Method
	public boolean SendEmailRgisterSuccessfully(VendorDTO vendorDTO) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
		message.setTo(vendorDTO.getEmailId());
		message.setSubject("Thank you for Registering");
		message.setText("Dear " + vendorDTO.getOwnerName() + ",\n\n" + "Welcome to our community!\n\n"
				+ "As part of our commitment to transparency and excellence, we'd like to take a moment to introduce you to an integral aspect of our operations: vendor management.\n\n"
				+ "Vendor management plays a crucial role in ensuring the seamless functioning of our platform/service. It involves building and maintaining relationships with third-party vendors who provide essential goods or services that contribute to our offering. These vendors could range from technology providers to logistics partners, all of whom play a vital role in delivering the quality experience you deserve.\n\n"
				+ "Our approach to vendor management is built on principles of accountability, reliability, and trust. We carefully select our vendors based on stringent criteria, including their track record, reliability, and alignment with our values. Once onboarded, we maintain close partnerships with these vendors to uphold the standards of excellence that define our brand.\n\n"
				+ "Your security and satisfaction are paramount to us. That's why we continuously monitor and evaluate our vendors' performance to ensure they meet our high standards. Additionally, we prioritize data security and compliance in all vendor relationships, safeguarding your information at every step.\n\n"
				+ "We believe that by managing our vendors effectively, we can enhance your experience with us and deliver on our promise of excellence. Your feedback and insights are invaluable as we strive to improve and innovate continuously.\n\n"
				+ "Please note: Your account is currently under verification. Once verified, you will receive a confirmation email, and you can log in using your registered email. Below, you'll find the page for your registered details.\n\n"
				+ "Here are your registration details:\n" + "Owner Name: " + vendorDTO.getOwnerName() + "\n" + "Email: "
				+ vendorDTO.getEmailId() + "\n" + "Contact Number: " + vendorDTO.getContactNumber() + "\n"
				+ "Alternate Contact Number: " + vendorDTO.getAltContactNumber() + "\n" + "Vendor Name: "
				+ vendorDTO.getVendorName() + "\n" + "GST Number: " + vendorDTO.getGSTNumber() + "\n" + "Start Date: "
				+ vendorDTO.getStartDate() + "\n" + "Website: " + vendorDTO.getWebsite() + "\n" + "Address: "
				+ vendorDTO.getAddress() + "\n" + "Pincode: " + vendorDTO.getPincode() + "\n" + "Status: "
				+ vendorDTO.getStatus() + "\n\n"
				+ "Once again, welcome to our community! We're excited to embark on this journey with you.\n\n"
				+ "Best regards,\n" + "xworkz vendor management Team");

		try {
			mailSender.send(message); // Use mailSender to send the email
			System.out.println("Mail sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public boolean SendEmailAccountVerified(VendorDTO vendorDTO) {
	    JavaMailSender mailSender = mailConfiguration.mailConfig();
	    SimpleMailMessage message = new SimpleMailMessage();
	    message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
	    message.setTo(vendorDTO.getEmailId());
	    message.setSubject("Account Verified: Start Your Business with Us");
	    message.setText("Dear " + vendorDTO.getOwnerName() + ",\n\n"
	            + "We are pleased to inform you that your account has been successfully verified.\n\n"
	            + "You can now log in to your account using your registered email and OTP. Here are the steps to get started:\n\n"
	            + "1. Visit our login page.\n"
	            + "2. Enter your registered email: " + vendorDTO.getEmailId() + "\n"
	            + "3. Enter the OTP sent to your email.\n\n"
	            + "Once logged in, you can start managing your business with us. We are excited to have you on board and look forward to a successful partnership.\n\n"
	            + "If you have any questions or need assistance, please do not hesitate to contact our support team.\n\n"
	            + "Here are your registration details for your reference:\n"
	            + "Owner Name: " + vendorDTO.getOwnerName() + "\n"
	            + "Email: " + vendorDTO.getEmailId() + "\n"
	            + "Contact Number: " + vendorDTO.getContactNumber() + "\n"
	            + "Alternate Contact Number: " + vendorDTO.getAltContactNumber() + "\n"
	            + "Vendor Name: " + vendorDTO.getVendorName() + "\n"
	            + "GST Number: " + vendorDTO.getGSTNumber() + "\n"
	            + "Start Date: " + vendorDTO.getStartDate() + "\n"
	            + "Website: " + vendorDTO.getWebsite() + "\n"
	            + "Address: " + vendorDTO.getAddress() + "\n"
	            + "Pincode: " + vendorDTO.getPincode() + "\n"
	            + "Status: " + vendorDTO.getStatus() + "\n\n"
	            + "We look forward to a fruitful collaboration.\n\n"
	            + "Best regards,\n"
	            + "xworkz Vendor Management Team");

	    try {
	        mailSender.send(message); // Use mailSender to send the email
	        System.out.println("Mail sent successfully");
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}


	//// send Login OTP To Email Method
	public boolean sendLoginOTPToEmail(String email, String OTP) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
		message.setTo(email);
		message.setSubject("Login OTP");
		message.setText("Dear User,\n\n" + "Your OTP for login is: " + OTP + "\n\n"
				+ "Please use this OTP to log in to your account.\n\n" + "Best regards,\n"
				+ "xworkz vendor management Team");

		try {
			mailSender.send(message); // Use mailSender to send the email
			System.out.println("login  OTP Mail sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendOrderInvoiceToAdmin(String email, String orderStatus, String productName, MultipartFile file) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(email); // Set sender email
			helper.setTo("xworkzvendormanagement@gmail.com");
			helper.setSubject("Order Invoice");

			// Prepare email body
			String emailBody = "Dear Admin,\n\n";
			emailBody += "An order invoice has been generated for the product: " + productName + ".\n\n";
			emailBody += "Order Status: " + orderStatus + ".\n\n";
			emailBody += "Please find the attached invoice.\n\n";
			emailBody += "Best regards,\n";
			emailBody += "xworkz vendor management Team";

			// Set email body
			helper.setText(emailBody);

			// Attach file
			if (file != null && !file.isEmpty()) {
				helper.addAttachment(Objects.requireNonNull(file.getOriginalFilename()),
						new ByteArrayResource(file.getBytes()));
			}

			// Send email
			mailSender.send(message);
			System.out.println("Order invoice email sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendOTPAdminEmail(String email, String otp, String adminName) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
		message.setTo(email);
		message.setSubject("admin login  OTP");
		message.setText("Dear Admin" + "   " + adminName + "\n\n" + " use this OTP for login: " + otp + "\n\n"
				+ "Please use this OTP to login adimin page.\n\n" + "Best regards,\n"
				+ "xworkz vendor management Team");

		try {
			mailSender.send(message); // Use mailSender to send the email
			System.out.println("OTP Mail sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendMessage(String senderEmail, String message) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		mailMessage.setFrom(senderEmail); // Set your email here
		mailMessage.setTo("xworkzvendormanagement@gmail.com");
		mailMessage.setSubject("Message from Vendor Management");
		String emailAndMessage = "Sender's Email: " + senderEmail + "\n\n" + message;
		mailMessage.setText(emailAndMessage);

		try {
			mailSender.send(mailMessage);
			System.out.println("Email sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendCustomEmail(String recipientName, String recipientEmail, String subject, String emailContent) {
		JavaMailSender mailSender = mailConfiguration.mailConfig();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
		message.setTo(recipientEmail);
		message.setSubject(subject);
		message.setText("Dear " + recipientName + ",\n\n" + emailContent + "\n\n" + "Best regards,\n"
				+ "Xworkz Vendor Management Team");

		try {
			mailSender.send(message); // Use mailSender to send the email
			System.out.println("Custom email sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// sendOrderConfirmationEmail
	/*
	 * public boolean sendOrderConfirmationEmail(ProductEntity productEntity) {
	 * JavaMailSender mailSender = mailConfiguration.mailConfig(); SimpleMailMessage
	 * message = new SimpleMailMessage();
	 * message.setFrom("xworkzvendormanagement@gmail.com");
	 * message.setTo(productEntity.getVendor().getEmailId());
	 * message.setSubject("New Order Request:" + productEntity.getProductName());
	 * message.setText("Dear " + productEntity.getVendor().getOwnerName() + ",\n\n"
	 * + "You have received a new order request for the following product:\n\n" +
	 * "Order Request Details:\n" + "Category: " + productEntity.getCategory() +
	 * "\n" + "Product Name: " + productEntity.getProductName() + "\n" +
	 * "Description: " + productEntity.getDescriptionAboutProduct() + "\n" +
	 * "Order Quantity: " + productEntity.getOrderQuantity() + "\n" +
	 * "Delivery Address: " + productEntity.getDeliveryAddress() + "\n" +
	 * "Delivery Date: " + productEntity.getDeliveryDate() + "\n" +
	 * "Please review the order request and take necessary actions.\n\n" +
	 * "Best regards,\n" + "xworkz vendor management Team");
	 * 
	 * try { mailSender.send(message); // Use mailSender to send the email
	 * System.out.println("Mail sent successfully"); return true; } catch (Exception
	 * e) { e.printStackTrace(); return false; } }
	 * 
	 * public boolean sendOrderReceivedConfirmationEmail(ProductEntity
	 * productEntity) { JavaMailSender mailSender = mailConfiguration.mailConfig();
	 * SimpleMailMessage message = new SimpleMailMessage();
	 * message.setFrom("xworkzvendormanagement@gmail.com"); // Set your email here
	 * message.setTo(productEntity.getVendor().getEmailId());
	 * message.setSubject("Order Received : " + productEntity.getProductName());
	 * message.setText(buildEmailContent(productEntity));
	 * 
	 * try { mailSender.send(message); // Use mailSender to send the email
	 * System.out.println("Mail sent successfully"); return true; } catch (Exception
	 * e) { e.printStackTrace(); return false; } }
	 */
	/*
	 * private String buildEmailContent(ProductEntity productEntity) { int Quantity
	 * = Integer.parseInt(productEntity.getOrderQuantity()); double totalAmount =
	 * Quantity * productEntity.getProductPrice(); double gstAmount = totalAmount *
	 * 0.18; double totalAmountWithGST = totalAmount + gstAmount;
	 * 
	 * StringBuilder emailContent = new StringBuilder();
	 * emailContent.append("Dear ").append(productEntity.getVendor().getOwnerName())
	 * .append(",\n\n"); emailContent.
	 * append("You have received an order for the following product:\n\n");
	 * emailContent.append("Order Details:\n");
	 * emailContent.append("Category: ").append(productEntity.getCategory()).append(
	 * "\n");
	 * emailContent.append("Product Name: ").append(productEntity.getProductName()).
	 * append("\n"); emailContent.append("Description: ").append(productEntity.
	 * getDescriptionAboutProduct()).append("\n");
	 * emailContent.append("Order Quantity: ").append(productEntity.getOrderQuantity
	 * ()).append("\n");
	 * emailContent.append("Delivery Address: ").append(productEntity.
	 * getDeliveryAddress()).append("\n");
	 * emailContent.append("Delivery Date: ").append(productEntity.getDeliveryDate()
	 * ).append("\n\n");
	 * emailContent.append("Total Amount: $").append(String.format("%.2f",
	 * totalAmount)).append("\n");
	 * emailContent.append("GST (18%): $").append(String.format("%.2f",
	 * gstAmount)).append("\n");
	 * emailContent.append("Total Amount with GST: $").append(String.format("%.2f",
	 * totalAmountWithGST)) .append("\n\n"); emailContent.append(
	 * "Please take necessary actions to fulfill the order. If payment is not received within 5 hours, kindly contact our company.\n\n"
	 * ); emailContent.append("Best regards,\n");
	 * emailContent.append("Xworkz Vendor Management Team");
	 * 
	 * return emailContent.toString(); }
	 */

}
