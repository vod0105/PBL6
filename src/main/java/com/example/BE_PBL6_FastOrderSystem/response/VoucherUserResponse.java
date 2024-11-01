package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.entity.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VoucherUserResponse {
    private Long voucherId;
    private List<Long> storeId;
    private String code;
    private Double discountPercent;
    private String description;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Boolean used;


}
