package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.ShipperOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface ShipperOrderRepository extends JpaRepository<ShipperOrder, Long> {
    @Query("SELECT so FROM ShipperOrder so WHERE so.shipper.id = ?1")
    List<ShipperOrder> findAllByShipperId(Long shipperId);


    @Query("SELECT so FROM ShipperOrder so WHERE so.id = ?1 AND so.shipper.id = ?2")
    List<ShipperOrder> findByIdAndShipperId(Long shipperOrderId, Long shipperId);
    @Query("SELECT so FROM ShipperOrder so WHERE so.status.statusName IN ?1")
    List<ShipperOrder> findAllByStatusIn(List<String> statuses);

    @Query("SELECT so FROM ShipperOrder so WHERE so.shipper.id = ?1 AND so.status.statusName= ?2")
    List<ShipperOrder> findAllByShipperIdAndStatus(Long shipperId, String status);
    @Query("SELECT so FROM ShipperOrder so WHERE so.shipper.id = ?1")
    ShipperOrder findByIdandShipperId(Long shipperOrderId, Long shipperId);
}