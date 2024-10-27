package com.example.BE_PBL6_FastOrderSystem.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@Entity
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long paymentId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    private LocalDateTime paymentDate;
    private double amountPaid;

    @ManyToOne
    @JoinColumn(name = "payment_method_id")
    private PaymentMethod paymentMethod;

    private String status;
    private LocalDateTime createdAt;
    private String orderCode;
    private Long userId;
    private String orderInfo;
    private String lang;
    private String extraData;


    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", order=" + order +
                ", paymentDate=" + paymentDate +
                ", amountPaid=" + amountPaid +
                ", paymentMethod=" + paymentMethod +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", orderCode='" + orderCode + '\'' +
                ", userId=" + userId +
                ", orderInfo='" + orderInfo + '\'' +
                ", lang='" + lang + '\'' +
                ", extraData='" + extraData + '\'' +
                '}';
    }
}