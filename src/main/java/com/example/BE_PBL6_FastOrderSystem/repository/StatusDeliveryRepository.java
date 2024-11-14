package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.StatusDelivery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface StatusDeliveryRepository extends JpaRepository<StatusDelivery, Long> {
    @Query("SELECT s FROM StatusDelivery s WHERE s.statusName = ?1")
    StatusDelivery findByStatusName(String statusName);
}
