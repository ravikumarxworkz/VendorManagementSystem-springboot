package com.VendoraX.dto;


import java.util.Date;

import lombok.Data;

@Data
public class PaymentDTO {
	 
	private int id;
	private String paymentId;
	private int vendorId;
	private int orderId;
	private double orderAmount;
	private String paymentStatus;
	private Date paymentDate;
	private String paymentInvoicePath;
	
}
