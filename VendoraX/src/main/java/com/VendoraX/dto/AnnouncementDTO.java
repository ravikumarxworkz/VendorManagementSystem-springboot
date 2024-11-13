package com.VendoraX.dto;


import jakarta.persistence.Id;
import lombok.Data;

@Data
public class AnnouncementDTO {

	@Id
	private int id;
	private String title;
	private String message;
}
