package com.VendoraX.response;

import java.util.List;

import com.VendoraX.dto.OrderDTO;

import lombok.Data;


@Data
public class OrderResponse {
	
	
	private	List<OrderDTO> orders;
	  private int totalPages;

}
