package com.example.BE_PBL6_FastOrderSystem.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoucherResponse {
    private Long voucherId;
    private List<Long> storeId;
    private String code;
    private Double discountPercent;
    private String description;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
}
