package com.example.BE_PBL6_FastOrderSystem.controller.User;

import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.security.user.FoodUserDetails;
import com.example.BE_PBL6_FastOrderSystem.service.IVoucherService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/user/voucher")
@RequiredArgsConstructor
public class UserVoucherController {
    private final IVoucherService voucherService;
    @PostMapping("/apply")
    public ResponseEntity<APIRespone> applyVoucherToUser(@RequestParam("voucherId") List<Long> voucherId) {
        Long currentUserId = FoodUserDetails.getCurrentUserId();
        return voucherService.applyVoucherToUser(voucherId, currentUserId);
    }
    @GetMapping("/get")
    public ResponseEntity<APIRespone> getVoucherByUserId() {
        Long currentUserId = FoodUserDetails.getCurrentUserId();
        return voucherService.getVouchersByUserId(currentUserId);
    }
}