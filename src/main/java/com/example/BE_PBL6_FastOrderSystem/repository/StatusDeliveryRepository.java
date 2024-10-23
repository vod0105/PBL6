package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.StatusDelivery;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusDeliveryRepository extends JpaRepository<StatusDelivery, Long> {
    StatusDelivery findByStatusName(String statusName);
}
