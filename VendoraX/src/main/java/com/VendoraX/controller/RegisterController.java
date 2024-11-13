package com.VendoraX.controller;

import java.util.Set;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.VendoraX.dto.VendorDTO;
import com.VendoraX.service.VendorService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintViolation;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/")
@Slf4j
@EnableWebMvc
public class RegisterController {

    @Autowired
    private VendorService vendorService;

    @GetMapping(value = "/checkEmailExistence/{email}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String checkEmailExistence(@PathVariable String email) {
        log.info("Received request to check email existence for email: {}", email);
        boolean emailExistsInDatabase = vendorService.isEmailExists(email);
        if (emailExistsInDatabase) {
            log.info("Email exists in the database: {}", email);
            return "EmailIDexists";
        } else {
            log.info("Email does not exist in the database: {}", email);
            return "EmailID not exists";
        }
    }

    @GetMapping(value = "/checkGSTNumberExistence/{GSTNumber}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String checkGSTNumberExistence(@PathVariable String GSTNumber) {
        log.info("Received request to check GST Number existence for GST Number: {}", GSTNumber);
        boolean exists = vendorService.isGSTNumberExists(GSTNumber);
        if (exists) {
            log.info("GST Number exists in the database: {}", GSTNumber);
            return "GSTNumberExist";
        } else {
            log.info("GST Number does not exist in the database: {}", GSTNumber);
            return "GSTNumberExists is not exit";
        }
    }

    @GetMapping(value = "/checkContactNumberExistence/{contactNumber}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String checkContactNumberExistence(@PathVariable Long contactNumber) {
        log.info("Received request to check contact number existence for contact number: {}", contactNumber);
        boolean exists = vendorService.isContactNumberExists(contactNumber);
        if (exists) {
            log.info("Contact number exists in the database: {}", contactNumber);
            return "contactNumberexists";
        } else {
            log.info("Contact number does not exist in the database: {}", contactNumber);
            return "contactNumberexists is not exit";
        }
    }

    @GetMapping(value = "/checkWebsiteExistence/{website}", produces = MediaType.APPLICATION_JSON_VALUE)
    public String checkWebsiteExistence(@PathVariable String website) {
        log.info("Received request to check website existence for website: {}", website);
        boolean exists = vendorService.isWebsiteExists(website);
        if (exists) {
            log.info("Website exists in the database: {}", website);
            return "websiteExists";
        } else {
            log.info("Website does not exist in the database: {}", website);
            return "website is not exit";
        }
    }
    
    @PostMapping("/vendorRegister")
    @ResponseBody
    public ResponseEntity<String> saveVendorDTO(@ModelAttribute @Validated VendorDTO dto, HttpSession session) {
        log.info("Registering vendor with data: {}", dto);

        // Validate the DTO
        Set<ConstraintViolation<VendorDTO>> constraintViolations = vendorService.registerVendor(dto);

        // If no violations, proceed with successful registration
        if (constraintViolations.isEmpty()) {
            // Set a session attribute (if needed)
            session.setAttribute("accountCreateMessage", "Account created successfully. Please sign in.");
            log.info("Vendor registration successful: {}", dto.getEmailId());

            // Return success message with HTTP status 200 (OK)
            return ResponseEntity.ok("Registration successful");

        } else {
            // Log the errors
            log.warn("Vendor registration failed with errors: {}", constraintViolations);

            // Create an error message from the validation issues
            StringBuilder errorMessage = new StringBuilder("Registration failed due to the following errors: ");
            constraintViolations.forEach(violation -> errorMessage.append(violation.getMessage()).append("; "));

            // Return error message with HTTP status 400 (Bad Request)
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorMessage.toString());
        }
    }
}
