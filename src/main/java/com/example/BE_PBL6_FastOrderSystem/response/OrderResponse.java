package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.entity.Order;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;


@Data
public class OrderResponse {
    private Long orderId;
    private String orderCode;
    private Long userId;
    private LocalDateTime orderDate;
    private Double totalAmount;
    private String status;
    private String deliveryAddress;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<OrderDetailResponse> orderDetails;

    public OrderResponse(Order order) {
        this.orderId = order.getOrderId();
        this.orderCode = order.getOrderCode();
        this.userId = order.getUser().getId();
        this.orderDate = order.getOrderDate();
        this.totalAmount = order.getTotalAmount();
        this.status = order.getStatus().getStatusName();
        this.deliveryAddress = order.getDeliveryAddress();
        this.createdAt = order.getCreatedAt();
        this.updatedAt = order.getUpdatedAt();
        this.orderDetails = order.getOrderDetails().stream().map(OrderDetailResponse::new).collect(Collectors.toList());
    }
}