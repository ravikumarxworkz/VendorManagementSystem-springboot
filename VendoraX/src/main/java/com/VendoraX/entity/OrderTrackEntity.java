package com.VendoraX.entity;

import java.time.LocalDate;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "order_track")
public class OrderTrackEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "order_id", nullable = false)
    private int orderId;

    // Removed @Temporal annotation
    @Column(name = "update_status", nullable = false)
    private LocalDate upDateStatus;
    
    @Column(name = "order_status", nullable = false)
    private String orderStatus;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", referencedColumnName = "orderId", insertable = false, updatable = false)
    private OrderEntity order;  // Many-to-one relationship with `OrderEntity`
}
