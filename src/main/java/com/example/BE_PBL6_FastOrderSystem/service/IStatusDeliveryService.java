package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import org.springframework.http.ResponseEntity;

public interface IStatusDeliveryService {
    ResponseEntity<APIRespone> getAllStatus();
}
