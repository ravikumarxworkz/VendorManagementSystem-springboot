package com.VendoraX.dto;

import java.time.LocalDateTime;

import jakarta.persistence.Id;
import lombok.Data;

@Data
public class OrderDTO {

	@Id
	int orderId;
	private int productId;
	private int vendorId;
	private String productName;
	private double productPrice;
	private double deliveryCharge;
	private String descriptionAboutProduct;
	private int orderQuantity;
	private LocalDateTime orderDate;
	private String deliveryDate;
	private String deliveryAddress;
	private String message;
	private String orderStatus;
	private double orderAmount;
	private String paymentStatus;
	private String orderInvoicePath;
	private String paymentInvoicePath;
	private double amountPaid;
	private double totalAmountToPay;
	private double BalanceAmount;

	/* private String deliveryStatus; */
}
