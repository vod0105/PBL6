package com.example.BE_PBL6_FastOrderSystem.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
@Data
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId;
    private String orderCode;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetails;
    private LocalDateTime orderDate;
    private double totalAmount;
    @ManyToOne
    @JoinColumn(name = "status_id")
    private StatusOrder status;
//    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
//    private List<Cart> carts;
    private String deliveryAddress;
    @Column(name = "longitude")
    private double longitude;
    @Column(name = "latitude")
    private double latitude;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean isFeedBack;
    @ManyToOne
    @JoinColumn(name = "discount_code_id")
    private DiscountCode discountCode;
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", orderCode='" + orderCode + '\'' +
                ", user=" + user +
                ", orderDetails=" + orderDetails +
                ", orderDate=" + orderDate +
                ", totalAmount=" + totalAmount +
                ", status=" + status +
                ", deliveryAddress='" + deliveryAddress + '\'' +
                ", longitude=" + longitude +
                ", latitude=" + latitude +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", isFeedBack=" + isFeedBack +
                ", discountCode=" + discountCode +
                '}';
    }
}