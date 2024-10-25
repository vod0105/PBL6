package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.DiscountCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface DiscountCodeRepository extends JpaRepository<DiscountCode, Long> {
    @Query("SELECT p FROM DiscountCode p WHERE p.startDate < ?1 AND p.endDate > ?1 AND p.status = true")
    List<DiscountCode> findByStartDateBeforeAndEndDateAfterAndStatus(LocalDateTime date);

    Optional<DiscountCode> findByCode(String code);
}
