package com.VendoraX.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.PaymentEntity;
import com.VendoraX.entity.VendorEntity;



@Repository
public interface PaymentRepository extends JpaRepository<PaymentEntity, Integer> {

	PaymentEntity findByVendor(VendorEntity vendor);

	Page<PaymentEntity> findByVendor(VendorEntity vendor, Pageable pageable);

	Page<PaymentEntity> findByVendorAndPaymentIdContainingIgnoreCase(VendorEntity vendor, String paymentId,
			Pageable pageable);

	Page<PaymentEntity> findByPaymentIdContainingIgnoreCase(String paymentId, Pageable pageable);

	Page<PaymentEntity> findAll(Pageable pageable);

}
