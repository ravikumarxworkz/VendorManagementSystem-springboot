package com.VendoraX.service.impl;


import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.VendoraX.Exception.ProductNotFoundException;
import com.VendoraX.dto.ProductDTO;
import com.VendoraX.entity.ProductEntity;
import com.VendoraX.entity.VendorEntity;
import com.VendoraX.repository.ProductRepository;
import com.VendoraX.repository.VendorRepo;
import com.VendoraX.response.ProductResponse;
import com.VendoraX.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private VendorRepo vendorRepo;

	@Override
	public boolean saveProductForVendor(int vendorId, ProductDTO productDTO) {
		VendorEntity vendorEntity = this.vendorRepo.getById(vendorId);
		ProductEntity productEntity = mapToProductEntity(productDTO);
		productEntity.setVendor(vendorEntity);
		; // Set vendor ID
		try {
			productRepository.save(productEntity);
			return true;
		} catch (Exception e) {
			log.error("Error saving product for vendorId: {}. Error: {}", vendorId, e.getMessage());
			return false;
		}
	}

	@Override
	public ProductDTO getProductById(int productId) throws ProductNotFoundException {
		try {
			// Fetch the product from the repository
			ProductEntity productEntity = productRepository.findById(productId)
					.orElseThrow(() -> new ProductNotFoundException("Product not found for id: " + productId));

			// Map the entity to a DTO and return it
			return mapToProductDto(productEntity);

		} catch (ProductNotFoundException e) {
			try {
				log.error("Product not found: {}", e.getMessage());
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			throw e; // This will be caught by the controller and return a 404
		} catch (Exception e) {
			log.error("Error retrieving product with id: {}", productId, e);
			throw new RuntimeException("Error retrieving product.");
		}
	}

	// Map DTO to Entity

	@Override
	public boolean updateProduct(ProductDTO editProductDTO) {
		log.info("Attempting to update product: {}", editProductDTO);

		if (editProductDTO != null) {
			// Fetch the existing product entity from the database
			ProductEntity existingProductEntity = productRepository.findById(editProductDTO.getId()).orElse(null);

			if (existingProductEntity != null) {
				// Copy properties from the DTO to the existing entity
				BeanUtils.copyProperties(editProductDTO, existingProductEntity, "id"); // Avoid overwriting the id field

				// Save the updated entity
				productRepository.save(existingProductEntity);

				log.info("Product updated successfully: {}", editProductDTO);
				return true;
			} else {
				log.warn("Product with ID {} not found for update.", editProductDTO.getId());
			}
		} else {
			log.warn("editProductDTO is null");
		}

		return false;
	}

	public ProductResponse getAllProdctByVendorId(int vendorId, int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<ProductEntity> ProductPage;
		VendorEntity vendorEntity = this.vendorRepo.findById(vendorId).orElse(null);
		if (query != null && !query.isEmpty()) {
			ProductPage = productRepository.findByVendorAndProductNameContainingIgnoreCase(vendorEntity, query,
					pageable);
		} else {
			ProductPage = this.productRepository.findByVendor(vendorEntity, pageable);
		}

		ProductResponse response = new ProductResponse();
		response.setProducts(ProductPage.getContent().stream().map(this::mapToProductDto).collect(Collectors.toList()));
		response.setTotalPages(ProductPage.getTotalPages());

		return response;
	}

	@Override
	public ProductResponse getAllProdctByAdmin(int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<ProductEntity> ProductPage;

		if (query != null && !query.isEmpty()) {
			// If query exists, search across all vendors for the product name
			ProductPage = productRepository.findAllByProductNameContainingIgnoreCase(query, pageable);
		} else {
			// If no query, return all products for admin
			ProductPage = productRepository.findAll(pageable);
		}

		ProductResponse response = new ProductResponse();
		response.setProducts(ProductPage.getContent().stream().map(this::mapToProductDto).collect(Collectors.toList()));
		response.setTotalPages(ProductPage.getTotalPages());

		return response;
	}

	private ProductDTO mapToProductDto(ProductEntity productEntity) {
		ProductDTO productDto = new ProductDTO();
		productDto.setId(productEntity.getId());
		productDto.setCategory(productEntity.getCategory());
		productDto.setProductName(productEntity.getProductName());
		productDto.setAvailable(productEntity.getAvailable());
		productDto.setProductPrice(productEntity.getProductPrice());
		productDto.setDeliveryCharge(productEntity.getDeliveryCharge());
		productDto.setDescriptionAboutProduct(productEntity.getDescriptionAboutProduct());
		return productDto;
	}

	private ProductEntity mapToProductEntity(ProductDTO productDTO) {
		ProductEntity productEntity = new ProductEntity();
		productEntity.setCategory(productDTO.getCategory());
		productEntity.setProductName(productDTO.getProductName());
		productEntity.setProductPrice(productDTO.getProductPrice());
		productEntity.setDeliveryCharge(productDTO.getDeliveryCharge());
		productEntity.setDescriptionAboutProduct(productDTO.getDescriptionAboutProduct());
		productEntity.setAvailable(productDTO.getAvailable());
		return productEntity;
	}

}
