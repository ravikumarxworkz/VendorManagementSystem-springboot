package com.VendoraX.service;


import com.VendoraX.Exception.ProductNotFoundException;
import com.VendoraX.dto.ProductDTO;
import com.VendoraX.response.ProductResponse;

public interface ProductService {

	boolean saveProductForVendor(int vendorId, ProductDTO productDTO);

	boolean updateProduct(ProductDTO productDTO);

	ProductDTO getProductById(int ProductId) throws ProductNotFoundException;

	ProductResponse getAllProdctByVendorId(int vendorId, int page, int size, String query);

	ProductResponse getAllProdctByAdmin(int page, int size, String query);


}
