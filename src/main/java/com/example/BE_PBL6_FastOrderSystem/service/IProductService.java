package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.request.ProductRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.ProductResponse;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

public interface IProductService {
    List<ProductResponse> getAllProduct();

    ResponseEntity<APIRespone> getProductById(Long productId);
    ResponseEntity<APIRespone> getProductsByStoreId(Long storeId);

    ResponseEntity<APIRespone> getProductsByStore_CategoryId(Long storeId,Long categoryId);

    ResponseEntity<APIRespone> applyAllProductsToAllStores(int quantity);

    ResponseEntity<APIRespone> applyAllProductsToStore(Long storeId, int quantity);

    ResponseEntity<APIRespone> applyProductsToStore(List<Long> productIds, Long storeId, List<Integer> quantity);

    ResponseEntity<APIRespone> removeProductsFromStore(List<Long> productIds, Long storeId);

    ResponseEntity<APIRespone> getProductsByCategoryId(Long categoryId);
    ResponseEntity<APIRespone> getProductByNames(String productName);
    ResponseEntity<APIRespone> getBestSaleProduct();
    ResponseEntity<APIRespone> addProduct(ProductRequest productRequest);
    ResponseEntity<APIRespone> updateProduct(Long id, ProductRequest productRequest);
    ResponseEntity<APIRespone> deleteProduct(Long id);
    ResponseEntity<APIRespone> applyProductToAllStores(List<Long> productId, List<Integer> quantity);
    ResponseEntity<APIRespone> removeProductFromStore(Long storeId, Long productId);
    ResponseEntity<APIRespone> applyProductsToStoreOfOwner(Long managerId, Long storeId, List<Long> productIds, List<Integer> quantity);
    ResponseEntity<APIRespone> applyProductsToStores(List<Long> productIds, Long storeId, List<Integer> quantity);
    ResponseEntity<APIRespone> getProductsByStore(Long owner);

    ResponseEntity<APIRespone> removeProductFromStoreId(Long ownerId, Long productId);
    ResponseEntity<APIRespone> updateQuantityProductOfOwner(Long managerId, Long storeId, Long productId, int quantity);
    ResponseEntity<APIRespone> getDrinksByListStoreId(List<Long> storeIds);

    ResponseEntity<APIRespone> addProductsToStore(List<Long> productIds, Long ownerId, List<Integer> quantity);
}