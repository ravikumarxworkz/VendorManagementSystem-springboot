package com.VendoraX.response;

import java.util.List;

import com.VendoraX.dto.PaymentDTO;

import lombok.Data;

@Data
public class PaymentResponse {

	private List<PaymentDTO> payments;
	private int totalPages;

}
