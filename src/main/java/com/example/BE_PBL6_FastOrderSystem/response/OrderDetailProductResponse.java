package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.entity.OrderDetail;
import lombok.Data;

import java.util.List;

@Data
public class OrderDetailProductResponse {
    private Long orderDetailId;
    private Long productId;
    private String productName;
    private String description;
    private String productImage;
    private String category;
    private boolean isBestSeller;
    private Integer quantity;
    private Double unitPrice;
    private Double totalPrice;
    private String size;
    private List<Long> drinkId;
    private Long storeId;
    private String status;
    private String nameProduct;
    private String image;

    public OrderDetailProductResponse(OrderDetail orderDetail) {
        this.orderDetailId = orderDetail.getOrderDetailId();
        this.productId = orderDetail.getProduct().getProductId();
        this.productName = orderDetail.getProduct().getProductName();
        this.description = orderDetail.getProduct().getDescription();
        this.productImage = orderDetail.getProduct().getImage();
        this.category = orderDetail.getProduct().getCategory().getCategoryName();
        this.isBestSeller = orderDetail.getProduct().getBestSale();
        this.quantity = orderDetail.getQuantity();
        this.unitPrice = orderDetail.getUnitPrice();
        this.totalPrice = orderDetail.getTotalPrice();
        this.size = orderDetail.getSize().getName();
        this.drinkId = orderDetail.getDrinkProducts().stream().map(product -> product.getProductId()).toList();
        this.storeId = orderDetail.getStore() != null ? orderDetail.getStore().getStoreId() : null;
        this.status = orderDetail.getStatus().getStatusName();
        this.nameProduct = orderDetail.getProduct().getProductName();
        this.image = orderDetail.getProduct().getImage();
    }
}