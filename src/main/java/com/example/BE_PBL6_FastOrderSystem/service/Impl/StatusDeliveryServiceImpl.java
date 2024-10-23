package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.repository.StatusDeliveryRepository;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.StatusOrderResponse;
import com.example.BE_PBL6_FastOrderSystem.service.IStatusDeliveryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StatusDeliveryServiceImpl implements IStatusDeliveryService {
    private final StatusDeliveryRepository statusDeliveryRepository;
    @Override
    public ResponseEntity<APIRespone> getAllStatus() {
        if (statusDeliveryRepository.findAll().isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "No size found", ""));
        }
        List<StatusOrderResponse> statusResponses = statusDeliveryRepository.findAll().stream()
                .map(statusOrder -> new StatusOrderResponse(statusOrder.getStatusId(), statusOrder.getStatusName()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", statusResponses));
    }
    }

