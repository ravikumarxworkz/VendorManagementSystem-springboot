package com.VendoraX.service;

import com.VendoraX.dto.PaymentDTO;
import com.VendoraX.response.PaymentResponse;

public interface PaymentService {

	boolean createPayment(PaymentDTO pyment);

	PaymentResponse getAllPaymentSummaryByVendorId(int vendorId, int page, int size, String query);

	PaymentResponse getAllPaymentSummaryByAdmin(int page, int size, String query);

}
