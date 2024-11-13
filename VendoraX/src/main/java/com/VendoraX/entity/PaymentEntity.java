package com.VendoraX.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "payment")
@Data
public class PaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id; // Internal auto-incremented ID

    @Column(name = "payment_code", unique = true)
    private String paymentId; // Custom payment ID like "PAY001"

    @ManyToOne // Many payments can belong to one vendor
    @JoinColumn(name = "vendor_id", nullable = false) // Foreign key column
    private VendorEntity vendor; // Reference to the VendorEntity

    @ManyToOne // Many payments can belong to one order
    @JoinColumn(name = "order_id", nullable = false) // Foreign key column
    private OrderEntity order; // Reference to the OrderEntity

    @Column(name = "order_amount", nullable = false)
    private double orderAmount;

    @Column(name = "payment_status", nullable = false)
    private String paymentStatus;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "payment_date", nullable = false)
    private Date paymentDate;

    @Column(name = "payment_invoice_path")
    private String paymentInvoicePath;

    // Constructors, Getters, and Setters
}
