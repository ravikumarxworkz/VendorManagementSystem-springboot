package com.VendoraX.entity;

import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "vendor_details")


public class VendorEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="vendor_id")
	private int id;
	private String ownerName;
	private String emailId;
	private long contactNumber;
	private long altContactNumber;
	private String vendorName;
	private String GSTNumber;
	private String startDate;
	private String website;
	private String address;
	private int pincode;
	private String imagePath;
	private String loginOTP;
	private LocalDateTime OTPGenerationTime;
	private String status;

}
