package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.entity.DiscountCode;
import com.example.BE_PBL6_FastOrderSystem.repository.DiscountCodeRepository;
import com.example.BE_PBL6_FastOrderSystem.request.DiscountCodeRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.DiscountResponse;
import com.example.BE_PBL6_FastOrderSystem.service.IDiscountCodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DiscountCodeServiceImpl implements IDiscountCodeService {
    private final DiscountCodeRepository discountCodeRepository;

    @Override
    public ResponseEntity<APIRespone> getAllDiscountCode() {
        List<DiscountResponse> discountResponses = discountCodeRepository.findAll().stream()
                .map(discountCode -> new DiscountResponse(
                        discountCode.getDiscountCodeId(),
                        discountCode.getCode(),
                        discountCode.getDiscountPercent(),
                        discountCode.getDescription(),
                        discountCode.getStartDate(),
                        discountCode.getEndDate()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", discountResponses));
    }
    @Override
    public ResponseEntity<APIRespone> getDiscountCodeById(Long discountCodeId) {
        if (discountCodeRepository.findById(discountCodeId).isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount code not found", ""));
        }
        DiscountResponse discountResponse = discountCodeRepository.findById(discountCodeId).map(discountCode -> new DiscountResponse(
                discountCode.getDiscountCodeId(),
                discountCode.getCode(),
                discountCode.getDiscountPercent(),
                discountCode.getDescription(),
                discountCode.getStartDate(),
                discountCode.getEndDate()
        )).get();
        return ResponseEntity.ok(new APIRespone(true, "Success", discountResponse));
    }
    @Override
    public ResponseEntity<APIRespone> getDiscountCodeByCode(String code) {
        if (discountCodeRepository.findByCode(code).isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount code not found", ""));
        }
        DiscountResponse discountResponse = discountCodeRepository.findByCode(code).map(discountCode -> new DiscountResponse(
                discountCode.getDiscountCodeId(),
                discountCode.getCode(),
                discountCode.getDiscountPercent(),
                discountCode.getDescription(),
                discountCode.getStartDate(),
                discountCode.getEndDate()
        )).get();
        return ResponseEntity.ok(new APIRespone(true, "Success", discountResponse));
    }
    @Override
    public ResponseEntity<APIRespone> add(DiscountCodeRequest discountCodeRequest) {
        if (discountCodeRequest.getStartDate().isAfter(discountCodeRequest.getEndDate())) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Start date cannot be after end date", ""));
        }

        String code = generateRandomCode();
        while (discountCodeRepository.findByCode(code).isPresent()) {
            code = generateRandomCode();
        }

        DiscountCode discountCode = new DiscountCode();
        discountCode.setCode(code);
        discountCode.setDiscountPercent(discountCodeRequest.getDiscountPercent());
        discountCode.setDescription(discountCodeRequest.getDescription());
        discountCode.setStartDate(discountCodeRequest.getStartDate());
        discountCode.setEndDate(discountCodeRequest.getEndDate());
        discountCodeRepository.save(discountCode);

        return ResponseEntity.ok(new APIRespone(true, "Discount code added successfully", ""));
    }

    private String generateRandomCode() {
        String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String digits = "0123456789";
        Random random = new Random();
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            code.append(letters.charAt(random.nextInt(letters.length())));
        }
        for (int i = 0; i < 4; i++) {
            int position = random.nextInt(code.length() + 1);
            code.insert(position, digits.charAt(random.nextInt(digits.length())));
        }
        return code.toString();
    }


}
