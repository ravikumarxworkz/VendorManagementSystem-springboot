package com.VendoraX.service;

import java.util.List;

import com.VendoraX.dto.NotificationDTO;

public interface NotificationService {

	NotificationDTO createNotification(String userId, NotificationDTO newNotification);

	List<NotificationDTO> findByUserIdAndReadFalse(String userId);

	boolean markNotificationAsViewed(long notificationId, String userId);

	int markAllNotificationsAsRead(String userId);

}