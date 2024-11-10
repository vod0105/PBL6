package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.CodeShipper;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface CodeShipperRepository extends JpaRepository<CodeShipper, Long> {
    @Query("SELECT c FROM CodeShipper c WHERE c.code = ?1")
    Optional<CodeShipper> findByCode(String code);
}
