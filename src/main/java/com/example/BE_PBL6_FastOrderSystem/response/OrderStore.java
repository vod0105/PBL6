package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.model.OrderDetail;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class OrderStore {
    private List<OrderDetailResponse> orderDetails;
    private String orderCode;
    private Double totalPrice;

    public OrderStore(List<OrderDetail> orderDetails) {
        this.orderDetails = new ArrayList<>();

        for (OrderDetail orderDetail : orderDetails) {
            this.orderDetails.add(new OrderDetailResponse(orderDetail));
        }

        if (!orderDetails.isEmpty()) {
            this.orderCode = orderDetails.get(0).getOrder().getOrderCode();
        }

        this.totalPrice = orderDetails.stream()
                .mapToDouble(OrderDetail::getTotalPrice)
                .sum();
    }
}
