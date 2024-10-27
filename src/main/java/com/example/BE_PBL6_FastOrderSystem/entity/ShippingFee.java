package com.example.BE_PBL6_FastOrderSystem.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "shipping_fee")
public class ShippingFee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long fee_id;
    private double fee;
}
