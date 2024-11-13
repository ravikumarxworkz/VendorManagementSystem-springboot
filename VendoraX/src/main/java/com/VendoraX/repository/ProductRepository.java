package com.VendoraX.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.ProductEntity;
import com.VendoraX.entity.VendorEntity;



@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {

	long countByVendor(VendorEntity vednor);

	Page<ProductEntity> findByVendor(VendorEntity vednor, Pageable pageable);

	Page<ProductEntity> findByVendorAndProductNameContainingIgnoreCase(VendorEntity vednor, String productName,
			Pageable pageable);

	Page<ProductEntity> findAllByProductNameContainingIgnoreCase(String productName, Pageable pageable);

	// Method to find all products for admins (when there's no search query)
	Page<ProductEntity> findAll(Pageable pageable);

}
