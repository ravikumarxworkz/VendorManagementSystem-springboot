package com.VendoraX.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.VendoraX.service.EmailIdValidationService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/")
@EnableWebMvc
@Slf4j
public class EmailVerificationController {

    @Autowired
    private EmailIdValidationService emailIdValidationService;

    @GetMapping("/genrateOTPAndSave")
    public ResponseEntity<String> genrateOTPAndSave(@RequestParam String email) {
        log.info("Received request to generate OTP and save for email: {}", email);
        boolean emailExistsInDatabase = emailIdValidationService.saveOTPByEmailId(email);
        if (emailExistsInDatabase) {
            log.info("OTP generated and saved for email: {}", email);
            return ResponseEntity.ok("Exists");
        } else {
            log.warn("Email does not exist in the database: {}", email);
            return ResponseEntity.ok("not exists");
        }
    }

    @PostMapping("/validateEmailVerificationOTP")
    public ResponseEntity<String> validateOTP(@RequestParam String email, @RequestParam String otp) {
        log.info("Received request to validate OTP for email: {}", email);
        boolean validate = emailIdValidationService.validateOTP(email, otp);
        if (validate) {
            log.info("OTP validation successful for email: {}", email);
            return ResponseEntity.ok("valid");
        } else {
            log.warn("OTP validation failed for email: {}", email);
            return ResponseEntity.ok("not valid");
        }
    }
}
