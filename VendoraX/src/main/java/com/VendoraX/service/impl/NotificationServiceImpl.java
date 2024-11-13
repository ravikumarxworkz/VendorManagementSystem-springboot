package com.VendoraX.service.impl;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.VendoraX.dto.NotificationDTO;
import com.VendoraX.entity.NotificationEntity;
import com.VendoraX.repository.NotificationRepository;
import com.VendoraX.service.NotificationService;


@Service
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	private NotificationRepository notificationRepository;
	
	
	@Override
	 @CacheEvict(value = "notificationCache", key = "#userId")
    public NotificationDTO createNotification(String userId, NotificationDTO newNotification) {
        NotificationEntity notificationEntity = new NotificationEntity();
        notificationEntity.setMessage(newNotification.getMessage());
        //notificationEntity.setRead(false);
        notificationEntity.setReceiverId(userId);
        notificationEntity.setTimestamp(newNotification.getTimestamp());
        notificationEntity.setType(newNotification.getType());
        
        notificationRepository.save(notificationEntity);

        // Evict cache to refresh data
        return newNotification;
    }

	@Override
	@CacheEvict(value = "notificationCache", key = "#userId")
	public boolean markNotificationAsViewed(long notificationId, String userId) {
	    Optional<NotificationEntity> notificationOpt = notificationRepository.findById(notificationId);
	    if (notificationOpt.isPresent()) {
	        NotificationEntity notification = notificationOpt.get();
	        
	        // Check if the notification belongs to the user
	        if (notification.getReceiverId().equals(userId)) {
	            notification.setRead(true);

	            NotificationEntity savedNotification = notificationRepository.save(notification);
	            if (savedNotification != null) {
	                return true;
	            }
	        }
	    }
	    return false; // Return false if notification not found or does not belong to the user
	}


//	 new code 

    @Override
    @Cacheable(value = "notificationCache", key = "#userId")
	public List<NotificationDTO> findByUserIdAndReadFalse(String userId) {

		List<NotificationEntity> notificationEntities = this.notificationRepository
				.findByReceiverIdAndIsReadFalse(userId);
		System.out.println(notificationEntities);

		return notificationEntities.stream().map(this::convertoDto).collect(Collectors.toList());

	}

	private NotificationDTO convertoDto(NotificationEntity notificationEntity) {
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setId(notificationEntity.getId());
		notificationDTO.setMessage(notificationEntity.getMessage());
		notificationDTO.setRead(notificationEntity.isRead());
		notificationDTO.setTimestamp(notificationEntity.getTimestamp());
		notificationDTO.setType(notificationEntity.getType());
		return notificationDTO;

	}

	@Override
    @CacheEvict(value = "notificationCache", key = "#userId")
    public int markAllNotificationsAsRead(String userId) {
        int updatedCount = notificationRepository.markAllAsReadForUser(userId);
    
        return updatedCount;
    }
}