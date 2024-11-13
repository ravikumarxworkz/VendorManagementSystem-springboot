package com.VendoraX.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class OrderTrackDTO {

	private long id;
	private int orderId;
	private LocalDate upDateStatus;
	private OrderDTO orderDTO;
	private String orderStatus;

}
