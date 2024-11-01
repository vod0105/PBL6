package com.example.BE_PBL6_FastOrderSystem.response;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@RequiredArgsConstructor
@Data
public class ShipperReportResponse {
    private Long shipperOrderId;
    private Long shipperId;
    private String ShipperName;
    private String status;
    private LocalDateTime receivedAt;
    private LocalDateTime deliveredAt;
    private Double shippingFee;
    private String storeName;
    public ShipperReportResponse(Long shipperOrderId, Long shipperId, String ShipperName, String status, LocalDateTime receivedAt, LocalDateTime deliveredAt, Double shippingFee, String storeName) {
        this.shipperOrderId = shipperOrderId;
        this.shipperId = shipperId;
        this.ShipperName = ShipperName;
        this.status = status;
        this.receivedAt = receivedAt;
        this.deliveredAt = deliveredAt;
        this.shippingFee = shippingFee;
        this.storeName = storeName;
    }

}
