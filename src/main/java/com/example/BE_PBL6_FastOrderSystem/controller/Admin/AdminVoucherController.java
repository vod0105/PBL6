package com.example.BE_PBL6_FastOrderSystem.controller.Admin;

import com.example.BE_PBL6_FastOrderSystem.request.VoucherRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.service.IVoucherService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/admin/voucher")
public class AdminVoucherController {
    final IVoucherService voucherService;
    @PostMapping("/add")
    public ResponseEntity<APIRespone> addDiscountCode(@RequestBody VoucherRequest voucherRequest) {
        return voucherService.add(voucherRequest);
    }
    @PostMapping("/apply/store")
    public ResponseEntity<APIRespone> applyDiscountCodeToStore(@RequestParam("voucherIds")List<Long> voucherIds, @RequestParam("storeId") Long storeId) {
        return voucherService.applyVouchersToStore(storeId,voucherIds);

    }
    @PostMapping("/remove/store")
    public ResponseEntity<APIRespone> removeDiscountCodeFromStore(@RequestParam("voucherIds")List<Long> voucherIds, @RequestParam("storeId") Long storeId) {
        return voucherService.removeVouchersFromStore(storeId,voucherIds);
    }
}
