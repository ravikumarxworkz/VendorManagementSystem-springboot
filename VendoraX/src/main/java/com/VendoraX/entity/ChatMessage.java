package com.VendoraX.entity;

import lombok.Data;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Data
@Entity
@Table(name = "chat_messages")
public class ChatMessage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String fromUser;
	@Column(name = "to_user")
	private String toUser;
	private String message;
	private LocalDateTime timestamp;

	// Getters and setters
}
