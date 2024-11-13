package com.VendoraX.dto;

import jakarta.persistence.Id;
import lombok.Data;

@Data
public class ProductDTO {

	@Id
	private int id;
	private int vendorId;
	private String category;
	private String productName;
	private String available;
	private double productPrice;
	private double deliveryCharge;
	private String descriptionAboutProduct;

}
