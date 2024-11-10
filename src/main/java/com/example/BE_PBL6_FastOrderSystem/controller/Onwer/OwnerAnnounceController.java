package com.example.BE_PBL6_FastOrderSystem.controller.Onwer;

import com.example.BE_PBL6_FastOrderSystem.repository.PaymentRepository;
import com.example.BE_PBL6_FastOrderSystem.request.AnnouceRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.security.user.FoodUserDetails;
import com.example.BE_PBL6_FastOrderSystem.service.IAnnouceService;
import com.example.BE_PBL6_FastOrderSystem.service.IOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/owner/announce")
@RequiredArgsConstructor
public class OwnerAnnounceController {
    @Autowired
    private IAnnouceService iAnnouceService;
    private Long getCurrentUserId() {
        return FoodUserDetails.getCurrentUserId();
    }
    @GetMapping()
    public ResponseEntity<APIRespone> getAllAnnouce() {
        Long userId = getCurrentUserId();
        return iAnnouceService.getbyuserId(userId);
    }
    @PostMapping("/add")
    public ResponseEntity<APIRespone> addAnnouce(@RequestBody AnnouceRequest request) {
        return iAnnouceService.addnewannounce(request.getUserid(), request.getTitle(), request.getContent());
    }
    
}