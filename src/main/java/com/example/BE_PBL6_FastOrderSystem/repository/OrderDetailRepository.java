package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.model.OrderDetail;
import com.example.BE_PBL6_FastOrderSystem.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface OrderDetailRepository  extends JpaRepository<OrderDetail, Long> {
    List<OrderDetail> findOrderDetailsByProductIn(List<Product> products);
    @Query("SELECT od FROM OrderDetail od WHERE od.order.orderId = ?1")
    List<OrderDetail> findByOrderId(Long orderId);
    @Query("SELECT od FROM OrderDetail od WHERE od.store.manager.id = ?1")
    Optional<OrderDetail> findByStoreManagerId(Long ownerId);

    @Query("SELECT od FROM OrderDetail od WHERE od.status.statusName = ?1")
    List<OrderDetail> findAllByStatus(String status);

    @Query("SELECT SUM(od.quantity) FROM OrderDetail od JOIN od.order o WHERE od.product.productId = :productId AND FUNCTION('DAY', o.createdAt) = :day AND FUNCTION('MONTH', o.createdAt) =  :month AND FUNCTION('YEAR', o.createdAt) = :year ")
    Long getCountProductSoldDay(@Param("day") int day,@Param("month") int month, @Param("year") int year, @Param("productId") Long productId);

    @Query("SELECT SUM(od.quantity) FROM OrderDetail od JOIN od.order o WHERE od.product.productId = :productId AND FUNCTION('MONTH', o.createdAt) = :month AND FUNCTION('YEAR', o.createdAt) = :year ")
    Long getCountProductSoldMonth(@Param("month") int month, @Param("year") int year, @Param("productId") Long productId);

    @Query("SELECT SUM(od.quantity) FROM OrderDetail od JOIN od.order o WHERE od.product.productId = :productId AND FUNCTION('YEAR', o.createdAt) = :year")
    Long getCountProductSoldYear(@Param("year") int day, @Param("productId") Long productId);

    @Query("SELECT SUM(od.quantity) FROM OrderDetail od JOIN od.order o WHERE od.product.productId = :productId AND FUNCTION('DAY', o.createdAt) = :day AND FUNCTION('MONTH', o.createdAt) =  :month AND FUNCTION('YEAR', o.createdAt) = :year and od.store.storeId = :storeId")
    Long getCountProductSoldDayStore(@Param("storeId") Long storeId,@Param("day") int day,@Param("month") int month, @Param("year") int year, @Param("productId") Long productId);

    @Query("SELECT SUM(od.quantity) FROM OrderDetail od JOIN od.order o WHERE od.product.productId = :productId AND FUNCTION('MONTH', o.createdAt) = :month AND FUNCTION('YEAR', o.createdAt) = :year and od.store.storeId = :storeId")
    Long getCountProductSoldMonthStore(@Param("storeId") Long storeId,@Param("month") int month, @Param("year") int year, @Param("productId") Long productId);

    @Query("SELECT SUM(od.quantity) FROM OrderDetail od JOIN od.order o WHERE od.product.productId = :productId AND FUNCTION('YEAR', o.createdAt) = :year and od.store.storeId = :storeId")
    Long getCountProductSoldYearStore(@Param("storeId") Long storeId,@Param("year") int day, @Param("productId") Long productId);
}
