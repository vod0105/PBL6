package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.request.CartRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import org.springframework.http.ResponseEntity;

public interface ICartService {
    ResponseEntity<APIRespone> addToCart(Long userId, CartRequest cartRequest);

    ResponseEntity<APIRespone> getHistoryCart(Long userId);
}