package com.VendoraX.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.VendoraX.response.PaymentResponse;
import com.VendoraX.service.PaymentService;

@RestController
@RequestMapping("/")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	@GetMapping("getAllPaymentSummaryByVendorId")
	public ResponseEntity<PaymentResponse> getAllPaymentSummaryByVendorId(@RequestParam int vendorId,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size,
			@RequestParam(required = false) String query) {

		// Fetch payment summaries using the service
		PaymentResponse paymentResponse = paymentService.getAllPaymentSummaryByVendorId(vendorId, page, size, query);

		return new ResponseEntity<>(paymentResponse, HttpStatus.OK);
	}

	@GetMapping("getAllPaymentSummaryByAdmin")
	public ResponseEntity<PaymentResponse> getAllPaymentSummaryByAdmin(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size, @RequestParam(required = false) String query) {

		// Fetch payment summaries using the service
		PaymentResponse paymentResponse = paymentService.getAllPaymentSummaryByAdmin(page, size, query);

		return new ResponseEntity<>(paymentResponse, HttpStatus.OK);
	}

}
