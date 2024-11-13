package com.VendoraX.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "admin_details")
public class AdminEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	@Column(name = "admin_Id")
	private int id;
	// @Column(name = "admin_Name")
	private String adminName;
	// @Column(name = "admin_emailId")
	private String emailId;
	// @Column(name = "admin_password")
	private String password;
	// @Column(name = "login_otp")
	private String otp;

}
