package com.example.BE_PBL6_FastOrderSystem.controller.User;

import com.example.BE_PBL6_FastOrderSystem.request.RateRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.security.user.FoodUserDetails;
import com.example.BE_PBL6_FastOrderSystem.security.user.FoodUserDetailsService;
import com.example.BE_PBL6_FastOrderSystem.service.IRateService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/user/product")
@RequiredArgsConstructor
public class UserProductController {
    final private IRateService rateService;
    private Long getCurrentUserId() {
        return FoodUserDetails.getCurrentUserId();
    }

    @PostMapping("/rating")
    public ResponseEntity<APIRespone> RatingProduct(
            @RequestParam("rate") int rate,
            @RequestParam("comment") String comment,
            @RequestParam(value = "productId", required = false) List<Long> productId,
            @RequestParam(value = "comboId", required = false) List<Long> comboId,
            @RequestParam(value = "imageFiles", required = false) List<MultipartFile> imageFiles) {
        RateRequest rateRequest = new RateRequest(rate, comment, imageFiles, productId, comboId);
        return rateService.rateProduct(getCurrentUserId(), rateRequest);
    }
    @GetMapping("/rate/history")
    public ResponseEntity<APIRespone> getRateByUserId() {
        Long userId = FoodUserDetails.getCurrentUserId();
        return rateService.getRateByUserId(userId);
    }
}