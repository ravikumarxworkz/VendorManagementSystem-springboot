package com.VendoraX.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.VendoraX.entity.NotificationEntity;

import jakarta.transaction.Transactional;


@Repository
public interface NotificationRepository extends JpaRepository<NotificationEntity, Long> {
    
    // Fetch unread notifications for a specific receiver
    List<NotificationEntity> findByReceiverIdAndIsReadFalse(String receiverId); 
    
    
    @Modifying
    @Transactional
    @Query("UPDATE NotificationEntity n SET n.isRead = true WHERE n.receiverId = :receiverId")
    int markAllAsReadForUser(@Param("receiverId") String userId);
}
