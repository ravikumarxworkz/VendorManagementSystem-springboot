package com.VendoraX.service.impl;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.VendoraX.entity.EmailValidationEntity;
import com.VendoraX.mailSending.MailSending;
import com.VendoraX.repository.VendorEmailValidationRepo;
import com.VendoraX.service.EmailIdValidationService;

import jakarta.transaction.Transactional;


@Service
@Transactional
public class EmailIdValidationServiceImpl implements EmailIdValidationService {

    @Autowired
    private VendorEmailValidationRepo emailValidationRepo;

    @Autowired
    private MailSending mailSending;

    @Override
    public boolean saveOTPByEmailId(String email) {
        if (email != null) {
            // Generate a random 6-digit OTP
            Random random = new Random();
            int generatedOtp = random.nextInt(900000) + 100000;
            String otp = String.valueOf(generatedOtp);

            // Create entity with the email, OTP, and current time
            EmailValidationEntity entity = new EmailValidationEntity();
            entity.setEmail(email);
            entity.setOtp(otp);
            entity.setOtpCreatedTime(LocalDateTime.now());

            // Save OTP to the database
            EmailValidationEntity savedOtp = this.emailValidationRepo.save(entity);

            if (savedOtp != null) {
                // Send OTP via email
                boolean isEmailSent = mailSending.sendEmailVerficationOTP(email, otp);
                if (isEmailSent) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public boolean validateOTP(String email, String otp) {
        if (email != null && otp != null) {
            // Fetch the most recent OTP for the email
            Optional<EmailValidationEntity> optionalEmailValidationEntity = this.emailValidationRepo
                    .findFirstByEmailOrderByOtpCreatedTimeDesc(email);

            if (optionalEmailValidationEntity.isPresent()) {
                EmailValidationEntity entity = optionalEmailValidationEntity.get();

                // Compare stored OTP with provided OTP
                if (entity.getOtp().equals(otp)) {
                    // Delete the OTP after successful validation
                    this.emailValidationRepo.deleteByEmail(email);
                    return true;
                }
            }
        }
        return false;
    }
}
