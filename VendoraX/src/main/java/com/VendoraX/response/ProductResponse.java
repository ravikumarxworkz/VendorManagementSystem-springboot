package com.VendoraX.response;

import java.util.List;

import com.VendoraX.dto.ProductDTO;

import lombok.Data;

@Data
public class ProductResponse {
	
	List<ProductDTO> products;
	  private int totalPages;


}
