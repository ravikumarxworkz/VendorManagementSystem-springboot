package com.VendoraX.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.VendoraX.dto.NotificationDTO;
import com.VendoraX.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class NotificationController {

	@Autowired
	private NotificationService notificationService;

	@GetMapping("notifications/{currentUserId}")
	public ResponseEntity<List<NotificationDTO>> getUserNotifications(@PathVariable String currentUserId) {
		List<NotificationDTO> notifications = notificationService
				.findByUserIdAndReadFalse(String.valueOf(currentUserId));
		return ResponseEntity.ok(notifications);
	}

	@PutMapping("notificationsRead/{notificationId}")
	public ResponseEntity<?> markAsRead(@PathVariable long notificationId, @RequestParam String userId) {
		boolean notificationOpt = notificationService.markNotificationAsViewed(notificationId, String.valueOf(userId));
		if (notificationOpt) {
			return ResponseEntity.ok("read");
		}
		return ResponseEntity.notFound().build();
	}

	@PutMapping("/markAllAsRead/{userId}")
	public ResponseEntity<String> markAllAsRead(@PathVariable Long userId) {
		int updatedCount = notificationService.markAllNotificationsAsRead(String.valueOf(userId));

		if (updatedCount > 0) {
			return ResponseEntity.ok("All notifications marked as read.");
		} else {
			return ResponseEntity.status(404).body("No notifications found for user.");
		}
	}

}
