package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.request.DiscountCodeRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import org.springframework.http.ResponseEntity;

public interface IDiscountCodeService {
    ResponseEntity<APIRespone> getAllDiscountCode();

    ResponseEntity<APIRespone> getDiscountCodeById(Long discountCodeId);

    ResponseEntity<APIRespone> getDiscountCodeByCode(String code);

    ResponseEntity<APIRespone> add(DiscountCodeRequest discountCodeRequest);
}
