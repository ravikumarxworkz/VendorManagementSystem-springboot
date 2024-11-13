package com.VendoraX.dto;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Id;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VendorDTO {

    @Id
    private int id;
    
    @Size(min = 3, max = 20, message = "Owner name should contain between 3 and 20 characters")
    private String ownerName;
    
    @Email(message = "Invalid email format")
    private String emailId;
    
    @Digits(integer = 10, fraction = 0, message = "Contact number should be a valid 10-digit number")
    private long contactNumber;
    
    @Digits(integer = 10, fraction = 0, message = "Alternate contact number should be a valid 10-digit number")
    private long altContactNumber;
    
    @Size(min = 3, max = 30, message = "Vendor name should contain between 3 and 30 characters")
    private String vendorName;
    
    @Pattern(regexp = "^[A-Z0-9]{15}$", message = "GST number should contain exactly 15 alphanumeric characters")
    private String GSTNumber;
    
    private String startDate;
    
    @NotBlank(message = "Website URL should not be blank")
    private String website;
    
    @NotNull(message = "Address cannot be null")
    private String address;
    
    @Min(value = 100000, message = "Pincode should be at least 6 digits long")
    @Max(value = 999999, message = "Pincode should not exceed 6 digits")
    private int pincode;
    
    private MultipartFile imageFile;
    
    private String imagePath;
    
    private String status;
}
