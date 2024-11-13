package com.VendoraX.service.impl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.VendoraX.dto.PaymentDTO;
import com.VendoraX.entity.OrderEntity;
import com.VendoraX.entity.PaymentEntity;
import com.VendoraX.entity.VendorEntity;
import com.VendoraX.repository.OrderRepository;
import com.VendoraX.repository.PaymentRepository;
import com.VendoraX.repository.VendorRepo;
import com.VendoraX.response.PaymentResponse;
import com.VendoraX.service.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private PaymentRepository paymentRepository;

	@Autowired
	private VendorRepo vendorRepo;

	@Autowired
	private OrderRepository orderRepository;

	@Override
	public boolean createPayment(PaymentDTO payment) {

		if (payment != null) {
			PaymentEntity paymentEntity = new PaymentEntity();
			BeanUtils.copyProperties(payment, paymentEntity);
			paymentEntity.setPaymentDate(new Date());

			VendorEntity vendorEntity = this.vendorRepo.findById(payment.getVendorId()).orElse(null);
			OrderEntity orderEntity = this.orderRepository.findById(payment.getOrderId()).orElse(null);

			paymentEntity.setVendor(vendorEntity);
			paymentEntity.setOrder(orderEntity);

			PaymentEntity savedEntity = paymentRepository.save(paymentEntity);

			String customPaymentId = "PAY" + String.format("%03d", savedEntity.getId());
			savedEntity.setPaymentId(customPaymentId);

			paymentRepository.save(savedEntity);

			return savedEntity != null;
		}

		return false; 
	}

	@Override
	public PaymentResponse getAllPaymentSummaryByVendorId(int vendorId, int page, int size, String query) {
		Pageable pageable = PageRequest.of(page > 0 ? page - 1 : 0, size, Sort.by(Sort.Direction.DESC, "paymentDate"));

		Page<PaymentEntity> paymentEntities;

		VendorEntity vendorEntity = this.vendorRepo.findById(vendorId).orElse(null);
		if (vendorEntity == null) {
			return new PaymentResponse(); // Return empty response if vendor not found
		}
		if (query != null && !query.isEmpty()) {
			paymentEntities = paymentRepository.findByVendorAndPaymentIdContainingIgnoreCase(vendorEntity, query,
					pageable);
		} else {
			paymentEntities = paymentRepository.findByVendor(vendorEntity, pageable);
		}

		List<PaymentDTO> payments = paymentEntities.getContent().stream().map(this::toPayment)
				.collect(Collectors.toList());
		PaymentResponse response = new PaymentResponse();
		response.setPayments(payments);
		response.setTotalPages(paymentEntities.getTotalPages());

		return response;
	}
	
	@Override
	public PaymentResponse getAllPaymentSummaryByAdmin(int page, int size, String query) {
	    // Adjust page value (Spring's pagination starts from 0)
	    Pageable pageable = PageRequest.of(page > 0 ? page - 1 : 0, size, Sort.by(Sort.Direction.DESC, "paymentDate"));

	    // Declare the variable to hold the fetched payment entities
	    Page<PaymentEntity> paymentEntities;

	    // Check if a search query is provided
	    if (query != null && !query.isEmpty()) {
	        // Fetch payments that contain the query string in their paymentId
	        paymentEntities = paymentRepository.findByPaymentIdContainingIgnoreCase(query, pageable);
	    } else {
	        // Fetch all payments without any filtering
	        paymentEntities = paymentRepository.findAll(pageable);
	    }

	    // Convert the fetched PaymentEntity objects to the required Payment DTO objects
	    List<PaymentDTO> payments = paymentEntities.getContent()
	                                           .stream()
	                                           .map(this::toPayment)
	                                           .collect(Collectors.toList());

	    // Create the response object and set the necessary fields
	    PaymentResponse response = new PaymentResponse();
	    response.setPayments(payments);
	    response.setTotalPages(paymentEntities.getTotalPages());

	    // Return the constructed response
	    return response;
	}

	private PaymentDTO toPayment(PaymentEntity entity) {
		if (entity == null) {
			return null;
		}

		PaymentDTO payment = new PaymentDTO();
		payment.setPaymentId(entity.getPaymentId());

		if (entity.getVendor() != null) {
			payment.setVendorId(entity.getVendor().getId());
		} else {
		}

		if (entity.getOrder() != null) {
			payment.setOrderId(entity.getOrder().getOrderId());
		} else {
		}

		payment.setOrderAmount(entity.getOrderAmount());
		payment.setPaymentStatus(entity.getPaymentStatus());
		payment.setPaymentDate(entity.getPaymentDate());
		payment.setPaymentInvoicePath(entity.getPaymentInvoicePath());

		return payment;
	}

}
