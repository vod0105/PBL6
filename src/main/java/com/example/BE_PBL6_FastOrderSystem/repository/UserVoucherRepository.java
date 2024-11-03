package com.example.BE_PBL6_FastOrderSystem.repository;

import com.example.BE_PBL6_FastOrderSystem.entity.UserVoucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserVoucherRepository extends JpaRepository<UserVoucher, Long> {

    @Query("Select uv FROM UserVoucher uv WHERE uv.voucher.code = :code")
    UserVoucher findByCode(@Param("code") String code);
}
