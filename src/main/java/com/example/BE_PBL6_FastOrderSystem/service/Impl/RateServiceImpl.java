
package com.example.BE_PBL6_FastOrderSystem.service.Impl;
import com.example.BE_PBL6_FastOrderSystem.entity.*;
import com.example.BE_PBL6_FastOrderSystem.repository.*;
import com.example.BE_PBL6_FastOrderSystem.request.RateRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.RateResponse;
import com.example.BE_PBL6_FastOrderSystem.service.IRateService;
import com.example.BE_PBL6_FastOrderSystem.utils.ImageGeneral;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class RateServiceImpl implements IRateService {
    @Autowired
    private final RateRepository rateRepository;
    @Autowired
    private final ProductRepository productRepository;
    @Autowired
    private final ComboRepository comboRepository;
    @Autowired
    private final UserRepository userRepository;
    @Autowired
    private final OrderRepository orderRepository;

    @Override
    public ResponseEntity<APIRespone> rateProduct(Long userId, RateRequest rateRequest) {
        if ((rateRequest.getProductIds() == null || rateRequest.getProductIds().isEmpty()) &&
                (rateRequest.getComboIds() == null || rateRequest.getComboIds().isEmpty())) {
            return ResponseEntity.ok(new APIRespone(false, " Bạn phải chọn ít nhất một sản phẩm hoặc combo để đánh giá", null));
        }

        StringBuilder responseMessage = new StringBuilder();
        if (rateRequest.getProductIds() != null && !rateRequest.getProductIds().isEmpty()) {
            for (Long productId : rateRequest.getProductIds()) {
                List<Order> orders = orderRepository.findByUserIdAndProductIdOrComboId(userId, productId, null);
                if (orders.isEmpty()) {
                    return ResponseEntity.ok(new APIRespone(false, "Bạn chưa mua sản phẩm này", null));
                }

                Optional<Rate> existingRate = rateRepository.findByUserIdAndProductId(userId, productId);
                Rate rate;
                if (existingRate.isPresent()) {
                    rate = existingRate.get();
                    responseMessage.append(" Cập nhật đánh giá cho sản phẩm ID: ").append(productId);
                } else {
                    rate = new Rate();
                    Product product = productRepository.findById(productId).orElse(null);
                    if (product == null) {
                        return ResponseEntity.ok(new APIRespone(false, "Product not found", null));
                    }
                    rate.setProduct(product);
                    responseMessage.append(" Thêm mới đánh giá cho sản phẩm ID: ").append(productId);
                }

                rate.setRate(rateRequest.getRate());
                rate.setComment(rateRequest.getComment());
                rate.setUserId(userId);

                List<MultipartFile> imageFiles = rateRequest.getImageFiles();
                if (imageFiles != null) {
                    for (MultipartFile imageFile : imageFiles) {
                        try {
                            InputStream imageInputStream = imageFile.getInputStream();
                            String base64Image = ImageGeneral.fileToBase64(imageInputStream);
                            ImageRate imageRating = new ImageRate();
                            imageRating.setImage(base64Image);
                            imageRating.setRate(rate);
                            rate.getImageRatings().add(imageRating);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }

                orders.forEach(order -> {
                    order.setFeedback(true);
                    orderRepository.save(order);
                });

                rateRepository.save(rate);
            }
        }
        if (rateRequest.getComboIds() != null && !rateRequest.getComboIds().isEmpty()) {
            for (Long comboId : rateRequest.getComboIds()) {
                List<Order> orders = orderRepository.findByUserIdAndProductIdOrComboId(userId, null, comboId);
                if (orders.isEmpty()) {
                    return ResponseEntity.ok(new APIRespone(false, "Bạn chưa mua combo này", null));
                }

                Optional<Rate> existingRate = rateRepository.findByUserIdAndComboId(userId, comboId);
                Rate rate;
                if (existingRate.isPresent()) {
                    rate = existingRate.get();
                    responseMessage.append(" Cập nhật đánh giá cho combo ID: ").append(comboId);
                } else {
                    rate = new Rate();
                    Combo combo = comboRepository.findById(comboId).orElse(null);
                    if (combo == null) {
                        return ResponseEntity.ok(new APIRespone(false, "Combo not found", null));
                    }
                    rate.setCombo(combo);
                    responseMessage.append(" Thêm mới đánh giá cho combo ID: ").append(comboId);
                }

                rate.setRate(rateRequest.getRate());
                rate.setComment(rateRequest.getComment());
                rate.setUserId(userId);

                List<MultipartFile> imageFiles = rateRequest.getImageFiles();
                if (imageFiles != null) {
                    for (MultipartFile imageFile : imageFiles) {
                        try {
                            InputStream imageInputStream = imageFile.getInputStream();
                            String base64Image = ImageGeneral.fileToBase64(imageInputStream);
                            ImageRate imageRating = new ImageRate();
                            imageRating.setImage(base64Image);
                            imageRating.setRate(rate);
                            rate.getImageRatings().add(imageRating);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }

                orders.forEach(order -> {
                    order.setFeedback(true);
                    orderRepository.save(order);
                });

                rateRepository.save(rate);
            }
        }
        return ResponseEntity.ok(new APIRespone(true, responseMessage.toString(), null));
    }




    @Override
    public ResponseEntity<APIRespone> getRateByProduct(Long productId) {
        Product product = productRepository.findById(productId).orElse(null);
        if (product == null) {
            return ResponseEntity.ok(new APIRespone(false, "Product not found", null));
        }
        List<RateResponse> rateResponses = rateRepository.findByProductId(productId).stream()
                .map(rate -> new RateResponse(
                        rate.getRateId(),
                        rate.getUserId(),
                        rate.getRate(),
                        rate.getComment(),
                        rate.getCreatedAt(),
                        rate.getUpdatedAt(),
                        rate.getProduct() != null ? rate.getProduct().getProductId() : null,
                        rate.getCombo() != null ? rate.getCombo().getComboId() : null,
                        rate.getImageRatings().stream()
                                .map(ImageRate::getImage)
                                .toList()

                ))
                .toList();
        return ResponseEntity.ok(new APIRespone(true, "Rates retrieved successfully", rateResponses));
    }
    @Override
    public ResponseEntity<APIRespone> getRateByCombo(Long comboId) {
        Combo combo = comboRepository.findById(comboId).orElse(null);
        if (combo == null) {
            return ResponseEntity.ok(new APIRespone(false, "Combo not found", null));
        }
        List<RateResponse> rateResponses = rateRepository.findByComboId(comboId).stream()
                .map(rate -> new RateResponse(
                        rate.getRateId(),
                        rate.getUserId(),
                        rate.getRate(),
                        rate.getComment(),
                        rate.getCreatedAt(),
                        rate.getUpdatedAt(),
                        rate.getProduct() != null ? rate.getProduct().getProductId() : null,
                        rate.getCombo() != null ? rate.getCombo().getComboId() : null,
                        rate.getImageRatings().stream()
                                .map(ImageRate::getImage)
                                .toList()
                ))
                .toList();
        return ResponseEntity.ok(new APIRespone(true, "Rates retrieved successfully", rateResponses));
    }
    @Override
    public ResponseEntity<APIRespone> getRateByUserId(Long userId) {
        List<RateResponse> rateResponses = rateRepository.findByUserId(userId).stream()
                .map(rate -> new RateResponse(
                        rate.getRateId(),
                        rate.getUserId(),
                        rate.getRate(),
                        rate.getComment(),
                        rate.getCreatedAt(),
                        rate.getUpdatedAt(),
                        rate.getProduct() != null ? rate.getProduct().getProductId() : null,
                        rate.getCombo() != null ? rate.getCombo().getComboId() : null,
                        rate.getImageRatings().stream()
                                .map(ImageRate::getImage).toList()
                ))
                .toList();
        return ResponseEntity.ok(new APIRespone(true, "Rates retrieved successfully", rateResponses));
    }
}