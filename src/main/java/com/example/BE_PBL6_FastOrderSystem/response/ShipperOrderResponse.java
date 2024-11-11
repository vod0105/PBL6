package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.entity.ShipperOrder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Data
public class ShipperOrderResponse {
    private Long shipperOrderId;
    private Long shipperId;
    private String status;
    private LocalDateTime receivedAt;
    private LocalDateTime deliveredAt;
    private Long storeId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long orderId;
    private String orderCode;
    private Long userId;
    private String fullName;
    private String phone;
    private Integer rewardPoints;
    private LocalDateTime orderDate;
    private Double totalAmount;
    private Double shippingFee;
    private String deliveryAddress;
    private Double longitude;
    private Double latitude;
    private List<OrderDetailResponse> orderDetails;


    public ShipperOrderResponse(ShipperOrder shipperOrder) {
        this.shipperOrderId = shipperOrder.getId();
        this.shipperId = shipperOrder.getShipper().getId();
        this.status = (shipperOrder.getStatus() != null && !shipperOrder.getStatus().getStatusName().isEmpty())
                ? shipperOrder.getStatus().getStatusName()
                : null;
        this.receivedAt = shipperOrder.getReceivedAt();
        this.deliveredAt = shipperOrder.getDeliveredAt();
        this.storeId = shipperOrder.getStore() != null ? shipperOrder.getStore().getStoreId() : null;
        this.createdAt = shipperOrder.getCreatedAt();
        this.updatedAt = shipperOrder.getUpdatedAt();

        // Check if orderDetails is not empty before accessing its elements
        if (!shipperOrder.getOrderDetails().isEmpty()) {
            this.orderId = shipperOrder.getOrderDetails().get(0).getOrder().getOrderId();
            this.orderCode = shipperOrder.getOrderDetails().get(0).getOrder().getOrderCode();
            this.userId = shipperOrder.getOrderDetails().get(0).getOrder().getUser().getId();
            this.fullName = shipperOrder.getOrderDetails().get(0).getOrder().getUser().getFullName();
            this.phone = shipperOrder.getOrderDetails().get(0).getOrder().getUser().getPhoneNumber();
            this.rewardPoints = shipperOrder.getOrderDetails().get(0).getOrder().getUser().getRewardPoints();
            this.orderDate = shipperOrder.getOrderDetails().get(0).getOrder().getOrderDate();
            this.deliveryAddress = shipperOrder.getOrderDetails().get(0).getOrder().getDeliveryAddress();
            this.longitude = shipperOrder.getOrderDetails().get(0).getOrder().getLongitude();
            this.latitude = shipperOrder.getOrderDetails().get(0).getOrder().getLatitude();
        } else {
            // Default values in case orderDetails is empty
            this.orderId = null;
            this.orderCode = "Unknown";
            this.userId = null;
            this.fullName = "Unknown";
            this.phone = "Unknown";
            this.rewardPoints = 0;
            this.orderDate = null;
            this.deliveryAddress = "Unknown";
            this.longitude = null;
            this.latitude = null;
        }

        this.totalAmount = shipperOrder.getOrderDetails().stream()
                .filter(orderDetail -> orderDetail.getStore().getStoreId().equals(this.storeId))
                .mapToDouble(orderDetail -> orderDetail.getTotalPrice())
                .sum();

        this.shippingFee = (shipperOrder.getOrderDetails().isEmpty() || shipperOrder.getOrderDetails().get(0).getShippingFee() == null)
                ? null
                : shipperOrder.getOrderDetails().get(0).getShippingFee().getFee();

        // Handle the orderDetails list mapping
        this.orderDetails = shipperOrder.getOrderDetails().isEmpty()
                ? List.of()
                : shipperOrder.getOrderDetails().stream()
                .map(OrderDetailResponse::new)
                .collect(Collectors.toList());
    }



}
