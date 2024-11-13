package com.VendoraX.repository;

import com.VendoraX.entity.OrderTrackEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderTrackRepository extends JpaRepository<OrderTrackEntity, Long> {
    
    // Custom query to fetch by orderId
    List<OrderTrackEntity> findByOrderId(int orderId);
}
