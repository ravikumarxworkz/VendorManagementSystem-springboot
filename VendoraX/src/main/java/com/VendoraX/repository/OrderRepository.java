package com.VendoraX.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.OrderEntity;
import com.VendoraX.entity.VendorEntity;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {

	List<OrderEntity> findByVendor(VendorEntity vendor);

	Page<OrderEntity> findByVendorAndOrderStatusIn(VendorEntity vendor, List<String> orderStatuses, Pageable pageable);

	Page<OrderEntity> findByVendorAndOrderStatusInAndProductNameContainingIgnoreCase(VendorEntity vendor,
			List<String> orderStatuses, String productName, Pageable pageable);

	Page<OrderEntity> findByVendorAndProductNameContainingIgnoreCaseAndOrderStatusNotIn(VendorEntity vendor,
			String productName, List<String> excludedStatuses, Pageable pageable);

	Page<OrderEntity> findByVendorAndOrderStatusNotIn(VendorEntity vendor, List<String> excludedStatuses,
			Pageable pageable);

	Page<OrderEntity> findByOrderStatusInAndProductNameContainingIgnoreCase(List<String> orderStatus,
			String productName, Pageable pageable);

	// Fetch orders by status (no product name filtering)
	Page<OrderEntity> findByOrderStatusIn(List<String> orderStatus, Pageable pageable);

	// Fetch orders by status and payment status with product name filtering
	Page<OrderEntity> findByOrderStatusInAndPaymentStatusAndProductNameContainingIgnoreCase(List<String> orderStatuses,
			String paymentStatus, String productName, Pageable pageable);

	// Fetch orders by status and payment status without product name filtering
	Page<OrderEntity> findByOrderStatusInAndPaymentStatus(List<String> orderStatuses, String paymentStatus,
			Pageable pageable);
}
