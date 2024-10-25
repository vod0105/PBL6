package com.example.BE_PBL6_FastOrderSystem.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "discount_codes")
public class DiscountCode {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "discount_code_id")
    private Long discountCodeId;
    @Column(name = "code")
    private String code;
    @Column(name = "discount_percent", columnDefinition = "DOUBLE")
    private Double discountPercent;
    @Column(name = "description")
    private String description;
    @Column(name = "start_date")
    private LocalDateTime startDate;
    @Column(name = "end_date")
    private LocalDateTime endDate;
    @Column(name = "status", columnDefinition = "BOOLEAN DEFAULT true")
    private boolean status;
}
