package com.VendoraX.response;

import java.util.List;

import com.VendoraX.dto.VendorDTO;

import lombok.Data;

@Data
public class VendorResponse {

	private List<VendorDTO> vendors;
	private int totalPages;
}
