package com.VendoraX.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;

import lombok.Data;

@Entity
@Data
@Table(name = "notification")
public class NotificationEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	// @Column(name = "sender_id")
	private String senderId;
	// @Column(name = "receiver_id")
	private String receiverId;
	private String message;
	private String type;
	// @Column(name = "is_read")
	private boolean isRead;
	private LocalDateTime timestamp;

}
