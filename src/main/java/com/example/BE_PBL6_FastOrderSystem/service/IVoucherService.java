package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.request.VoucherRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface IVoucherService {
    ResponseEntity<APIRespone> getAllDiscountCode();

    ResponseEntity<APIRespone> getDiscountCodeById(Long discountCodeId);

    ResponseEntity<APIRespone> getDiscountCodeByCode(String code);

    ResponseEntity<APIRespone> getDiscountCodeByStore(Long storeId);

    ResponseEntity<APIRespone> add(VoucherRequest voucherRequest);

    ResponseEntity<APIRespone> applyVouchersToStore(Long storeId, List<Long> voucherIds);

    ResponseEntity<APIRespone> removeVouchersFromStore(Long storeId, List<Long> voucherIds);

    ResponseEntity<APIRespone> getVouchersByStoreId(Long storeId);

    ResponseEntity<APIRespone> applyVoucherToUser(List<Long> voucherIds, Long userId);

    ResponseEntity<APIRespone> getVouchersByUserId(Long userId);
}
