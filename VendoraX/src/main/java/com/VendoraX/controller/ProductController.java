package com.VendoraX.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.VendoraX.dto.ProductDTO;
import com.VendoraX.response.ProductResponse;
import com.VendoraX.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/")
@Slf4j
public class ProductController {

	@Autowired
	private ProductService productService;

	@PostMapping("/addProduct")
	public ResponseEntity<String> addProduct(

			@RequestBody ProductDTO productDTO) {
		log.info("Attempting to save product for vendorId: {}", productDTO.getVendorId());

		boolean isProductSaved = productService.saveProductForVendor(productDTO.getVendorId(), productDTO);
		if (isProductSaved) {
			log.info("Product saved successfully for vendorId: {}", productDTO.getVendorId());
			return ResponseEntity.ok("Product saved successfully");
		} else {
			log.warn("Failed to save product for vendorId: {}", productDTO.getVendorId());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Product not saved successfully");
		}
	}

	@PostMapping("/updateProduct")
	public ResponseEntity<String> updateProduct(@RequestBody ProductDTO productDTO) {
		try {
			boolean isUpdated = productService.updateProduct(productDTO);
			if (isUpdated) {
				log.info("Product updated successfully with ID: {}", productDTO.getId());
				return ResponseEntity.ok("Product updated successfully");
			} else {
				log.warn("Failed to update product with ID: {}", productDTO.getId());
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update product");
			}
		} catch (Exception e) {
			log.error("Error updating product with ID: {}. Error: {}", e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Error updating product: " + e.getMessage());
		}
	}

	@GetMapping("/getProductById")
	public ResponseEntity<?> getProductById(@RequestParam(value = "productId") int productId) {
		log.info("Fetching product details for productId: {}", productId);

		try {
			ProductDTO product = productService.getProductById(productId);
			if (product == null) {
				log.error("Product not found for productId: {}", productId);
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found.");
			}

			return ResponseEntity.ok(product);

		} catch (Exception e) {
			log.error("Error fetching product details for productId: {}. Error: {}", productId, e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching product details.");
		}
	}

	@PostMapping("/productUpdate")
	@ResponseBody
	public ResponseEntity<String> productUpdate(ProductDTO productDTO, Model model) {
		log.info("Attempting to update product: {}", productDTO);
		boolean updateProduct = this.productService.updateProduct(productDTO);
		if (updateProduct) {
			log.info("Product updated successfully: {}", productDTO);
			return ResponseEntity.ok().body("Product updated successfully");
		} else {
			log.warn("Failed to update product: {}", productDTO);
			return ResponseEntity.ok().body("Product not updated successfully");
		}
	}

	@GetMapping("/getAllProductsByVendorId")
	public ResponseEntity<ProductResponse> getAllProductsByVendorId(@RequestParam(value = "vendorId") int vendorId,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query) {
		try {
			ProductResponse response = this.productService.getAllProdctByVendorId(vendorId, page, size, query);

			return ResponseEntity.ok(response);
		} catch (Exception e) {
			// Log error details
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}
	
	@GetMapping("/getAllProductsByAdmin")
	public ResponseEntity<ProductResponse> getAllProductsByAdmin(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query) {
		try {
			ProductResponse response = this.productService.getAllProdctByAdmin( page, size, query);

			return ResponseEntity.ok(response);
		} catch (Exception e) {
			// Log error details
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

}
