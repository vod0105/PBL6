package com.example.BE_PBL6_FastOrderSystem.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DiscountResponse {
    private Long promoCodeId;
    private String promoCode;
    private Double discountPercent;
    private String description;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
}
