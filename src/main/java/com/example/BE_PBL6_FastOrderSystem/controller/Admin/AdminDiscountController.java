package com.example.BE_PBL6_FastOrderSystem.controller.Admin;

import com.example.BE_PBL6_FastOrderSystem.request.DiscountCodeRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.service.IDiscountCodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/admin/discount")
public class AdminDiscountController {
    final IDiscountCodeService discountCodeService;
    @PostMapping("/add")
    public ResponseEntity<APIRespone> addDiscountCode(@RequestBody DiscountCodeRequest discountCodeRequest) {
        return discountCodeService.add(discountCodeRequest);
    }
    @GetMapping("/all")
    public ResponseEntity<APIRespone> getAllDiscountCode() {
        return discountCodeService.getAllDiscountCode();
    }
}
