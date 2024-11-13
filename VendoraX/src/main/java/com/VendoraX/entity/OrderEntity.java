package com.VendoraX.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "orders_details")

public class OrderEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	//@Column(name = "order_id")
	private int orderId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private ProductEntity product;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "vendor_id")
	private VendorEntity vendor;
	//@Column(name = "product_name")
	private String productName;
	//@Column(name = "product_price")
	private double productPrice;
	//@Column(name = "delivery_charge")
	private double deliveryCharge;
	//@Column(name = "descriptionAboutProduct")
	private String descriptionAboutProduct;
	//@Column(name = "order_quantity")
	private int orderQuantity;
	//@Column(name = "order_date")
	private LocalDateTime orderDate;
	//@Column(name = "order_status")
	private String orderStatus;
	//@Column(name = "delivery_date")
	private String deliveryDate;
	//@Column(name = "delivery_address")
	private String deliveryAddress;
	//@Column(name = "message")
	private String message;
	//@Column(name = "orderAmount")
	private double orderAmount;
	private String paymentStatus;
	private String orderInvoicePath;
	private String PaymentInovicePath;

}
