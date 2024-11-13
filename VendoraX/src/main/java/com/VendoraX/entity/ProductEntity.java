package com.VendoraX.entity;

import jakarta.persistence.*;

import lombok.Data;

@Entity
@Data
@Table(name = "product_details")
public class ProductEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="product_id")
	private int id;
	private String category;
	private String productName;
	private String available;
	private double productPrice;
	private double deliveryCharge;
	private String descriptionAboutProduct;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "vendor_id")
	private VendorEntity vendor;
	

}
