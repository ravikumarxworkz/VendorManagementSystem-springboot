package com.VendoraX.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class NotificationDTO {

	private Long id;
	private String senderId;
	private String receiverId;
	private String message;
	private String type;
	private boolean read;
	private LocalDateTime timestamp;
	
	 public String getTimestampAsString() {
	        // Convert LocalDateTime to ISO 8601 string
	        return timestamp.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
	    }

}
