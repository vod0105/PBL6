package com.example.BE_PBL6_FastOrderSystem.response;

import com.example.BE_PBL6_FastOrderSystem.entity.Product;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class ProductStoreDTO {
    private Product product;
    private Integer stockQuantity;

    public ProductStoreDTO(Product product, Integer stockQuantity) {
        Product pro = new Product();
        pro.setProductId(product.getProductId());
        pro.setProductName(product.getProductName());
        pro.setProductStores(product.getProductStores());
        pro.setStockQuantity(stockQuantity);
        pro.setPrice(product.getPrice());
        pro.setImage(product.getImage());
        pro.setCategory(product.getCategory());
        pro.setDescription(product.getDescription());
        pro.setPromotions(product.getPromotions());
        pro.setBestSale(product.getBestSale());
        pro.setCombos(product.getCombos());
        pro.setCreatedAt(product.getCreatedAt());
        pro.setUpdatedAt(product.getUpdatedAt());
        pro.setRates(product.getRates());
        pro.setStockQuantity(stockQuantity);
        this.product = pro;
        this.stockQuantity = stockQuantity;

    }
}
