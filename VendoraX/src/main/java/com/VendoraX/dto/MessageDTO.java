package com.VendoraX.dto;

import java.time.LocalDateTime;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageDTO {
	@Id
	private Long id;
	private String fromUser;
	private String toUser;
	private String message;
	private LocalDateTime timestamp;

}
