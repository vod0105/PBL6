package com.example.BE_PBL6_FastOrderSystem.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
@Table(name = "shipper_order")
public class ShipperOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "shipper_id", nullable = false)
    private User shipper;
    @ManyToOne
    @JoinColumn(name = "store_id", nullable = false)
    private Store store;
    @OneToMany(mappedBy = "shipperOrder", fetch = FetchType.EAGER)
    private List<OrderDetail> orderDetails;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    @ManyToOne
    @JoinColumn(name = "status_id")
    private StatusDelivery status;
    private LocalDateTime receivedAt;
    private LocalDateTime deliveredAt;
    private String note;
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    @PreUpdate protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

}