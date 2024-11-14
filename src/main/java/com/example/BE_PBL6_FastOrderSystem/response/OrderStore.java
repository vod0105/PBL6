package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.entity.OrderDetail;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class OrderStore {
    private String orderCode;
    private Double totalPrice;
    private Long storeId;
    private String status;
    private String deliveryAddress;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String imageUser;
    private String fullName;

    public OrderStore(List<OrderDetail> orderDetails) {
        if (!orderDetails.isEmpty()) {
            this.orderCode = orderDetails.get(0).getOrder().getOrderCode();
            this.status = orderDetails.get(0).getStatus().getStatusName();
            this.deliveryAddress = orderDetails.get(0).getOrder().getDeliveryAddress();
            this.createdAt = orderDetails.get(0).getOrder().getCreatedAt();
            this.updatedAt = orderDetails.get(0).getOrder().getUpdatedAt();
            this.fullName = orderDetails.get(0).getOrder().getUser().getFullName();
            this.imageUser = orderDetails.get(0).getOrder().getUser().getAvatar();
            this.storeId = orderDetails.get(0).getStore().getStoreId();
        }
        this.totalPrice = orderDetails.stream()
                .mapToDouble(OrderDetail::getTotalPrice)
                .sum();
    }
}
