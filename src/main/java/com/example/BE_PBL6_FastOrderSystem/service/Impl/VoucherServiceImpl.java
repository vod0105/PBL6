package com.example.BE_PBL6_FastOrderSystem.service.Impl;

import com.example.BE_PBL6_FastOrderSystem.entity.Store;
import com.example.BE_PBL6_FastOrderSystem.entity.User;
import com.example.BE_PBL6_FastOrderSystem.entity.UserVoucher;
import com.example.BE_PBL6_FastOrderSystem.entity.Voucher;
import com.example.BE_PBL6_FastOrderSystem.repository.StoreRepository;
import com.example.BE_PBL6_FastOrderSystem.repository.UserRepository;
import com.example.BE_PBL6_FastOrderSystem.repository.UserVoucherRepository;
import com.example.BE_PBL6_FastOrderSystem.repository.VoucherRepository;
import com.example.BE_PBL6_FastOrderSystem.request.VoucherRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.VoucherResponse;
import com.example.BE_PBL6_FastOrderSystem.response.VoucherUserResponse;
import com.example.BE_PBL6_FastOrderSystem.service.IVoucherService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VoucherServiceImpl implements IVoucherService {
    private final VoucherRepository discountCodeRepository;
    private final UserVoucherRepository userVoucherRepository;
    private final StoreRepository storeRepository;
    private final UserRepository userRepository;

    @Override
    public ResponseEntity<APIRespone> getAllDiscountCode() {
        List<VoucherResponse> voucherRespons = discountCodeRepository.findAll().stream()
                .map(voucher -> new VoucherResponse(
                        voucher.getVoucherId(),
                        voucher.getStores().stream().map(Store::getStoreId).collect(Collectors.toList()),
                        voucher.getCode(),
                        voucher.getDiscountPercent(),
                        voucher.getDescription(),
                        voucher.getStartDate(),
                        voucher.getEndDate()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", voucherRespons));
    }

    @Override
    public ResponseEntity<APIRespone> getDiscountCodeById(Long discountCodeId) {
        if (discountCodeRepository.findById(discountCodeId).isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount code not found", ""));
        }
        VoucherResponse voucherResponse = discountCodeRepository.findById(discountCodeId).map(voucher -> new VoucherResponse(
                voucher.getVoucherId(),
                voucher.getStores().stream().map(Store::getStoreId).collect(Collectors.toList()),
                voucher.getCode(),
                voucher.getDiscountPercent(),
                voucher.getDescription(),
                voucher.getStartDate(),
                voucher.getEndDate()
        )).get();
        return ResponseEntity.ok(new APIRespone(true, "Success", voucherResponse));
    }

    @Override
    public ResponseEntity<APIRespone> getDiscountCodeByCode(String code) {
        if (discountCodeRepository.findByCode(code).isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount code not found", ""));
        }
        VoucherResponse voucherResponse = discountCodeRepository.findByCode(code).map(voucher -> new VoucherResponse(
                voucher.getVoucherId(),
                voucher.getStores().stream().map(Store::getStoreId).collect(Collectors.toList()),
                voucher.getCode(),
                voucher.getDiscountPercent(),
                voucher.getDescription(),
                voucher.getStartDate(),
                voucher.getEndDate()
        )).get();
        return ResponseEntity.ok(new APIRespone(true, "Success", voucherResponse));
    }

    @Override
    public ResponseEntity<APIRespone> getDiscountCodeByStore(Long storeId) {
        Optional<Store> store = storeRepository.findById(storeId);
        if (store.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        List<VoucherResponse> voucherResponses = store.get().getVouchers().stream()
                .map(voucher -> new VoucherResponse(
                        voucher.getVoucherId(),
                        voucher.getStores().stream().map(Store::getStoreId).collect(Collectors.toList()),
                        voucher.getCode(),
                        voucher.getDiscountPercent(),
                        voucher.getDescription(),
                        voucher.getStartDate(),
                        voucher.getEndDate()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", voucherResponses));
    }

    @Override
    public ResponseEntity<APIRespone> add(VoucherRequest voucherRequest) {
        if (voucherRequest.getStartDate().isAfter(voucherRequest.getEndDate())) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Start date cannot be after end date", ""));
        }

        String code = generateRandomCode();
        while (discountCodeRepository.findByCode(code).isPresent()) {
            code = generateRandomCode();
        }
        Voucher voucher = new Voucher();
        voucher.setCode(code);
        voucher.setDiscountPercent(voucherRequest.getDiscountPercent());
        voucher.setDescription(voucherRequest.getDescription());
        voucher.setStartDate(voucherRequest.getStartDate());
        voucher.setEndDate(voucherRequest.getEndDate());
        discountCodeRepository.save(voucher);
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
    public ResponseEntity<APIRespone> delete(Long id) {
        if (discountCodeRepository.findById(id).isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount code not found", ""));
        }
        discountCodeRepository.deleteById(id);
        return ResponseEntity.ok(new APIRespone(true, "Discount code deleted successfully", ""));
    }

    @Override
    public ResponseEntity<APIRespone> applyVouchersToStore(Long storeId, List<Long> voucherIds) {
        Optional<Store> store = storeRepository.findById(storeId);
        if (store.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        Store store1 = store.get();
        List<Voucher> vouchers = discountCodeRepository.findAllById(voucherIds);
        if (vouchers.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount codes not found", ""));
        }
        List<String> alreadyAppliedVouchers = new ArrayList<>();
        int count = 0;
        for (Voucher voucher : vouchers) {
            if (voucher.getStores().contains(store1)) {
                alreadyAppliedVouchers.add(voucher.getCode());
                count++;
            } else {
                voucher.getStores().add(store1);
                store.get().getVouchers().add(voucher);
            }
        }
        if (count == vouchers.size()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "All discount codes are already applied to the store", alreadyAppliedVouchers));
        }
        storeRepository.save(store1);
        discountCodeRepository.saveAll(vouchers);
        return ResponseEntity.ok(new APIRespone(true, "Voucher applied to store successfully", ""));
    }

    @Override
    public ResponseEntity<APIRespone> removeVouchersFromStore(Long storeId, List<Long> voucherIds) {
        Optional<Store> store = storeRepository.findById(storeId);
        if (store.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        Store store1 = store.get();
        List<Voucher> vouchers = discountCodeRepository.findAllById(voucherIds);
        if (vouchers.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount codes not found", ""));
        }
        List<String> notAppliedVouchers = new ArrayList<>();
        int count = 0;
        for (Voucher voucher : vouchers) {
            if (voucher.getStores().contains(store1)) {
                voucher.getStores().remove(store1);
                store.get().getVouchers().remove(voucher);
            } else {
                notAppliedVouchers.add(voucher.getCode());
                count++;
            }
        }
        if (count == vouchers.size()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "All discount codes are not applied to the store", notAppliedVouchers));
        }
        storeRepository.save(store1);
        discountCodeRepository.saveAll(vouchers);
        return ResponseEntity.ok(new APIRespone(true, "Voucher removed from store successfully", ""));
    }

    @Override
    public ResponseEntity<APIRespone> getVouchersByStoreId(Long storeId) {
        Optional<Store> store = storeRepository.findById(storeId);
        if (store.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Store not found", ""));
        }
        List<VoucherResponse> voucherResponses = store.get().getVouchers().stream()
                .map(voucher -> new VoucherResponse(
                        voucher.getVoucherId(),
                        voucher.getStores().stream().map(Store::getStoreId).collect(Collectors.toList()),
                        voucher.getCode(),
                        voucher.getDiscountPercent(),
                        voucher.getDescription(),
                        voucher.getStartDate(),
                        voucher.getEndDate()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", voucherResponses));
    }

    @Override
    public ResponseEntity<APIRespone> applyVoucherToUser(List<Long> voucherIds, Long userId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "User not found", ""));
        }
        User user1 = user.get();
        List<Voucher> vouchers = discountCodeRepository.findAllById(voucherIds);
        if (vouchers.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "Discount codes not found", ""));
        }
        List<String> alreadyAppliedVouchers = new ArrayList<>();
        int count = 0;
        // Create a map of existing UserVoucher objects by voucher ID
        Map<Long, UserVoucher> existingUserVouchers = user1.getVouchers().stream()
                .collect(Collectors.toMap(uv -> uv.getVoucher().getVoucherId(), uv -> uv));

        for (Voucher voucher : vouchers) {
            if (existingUserVouchers.containsKey(voucher.getVoucherId())) {
                alreadyAppliedVouchers.add(voucher.getCode());
                count++;
            } else {
                UserVoucher userVoucher = new UserVoucher();
                userVoucher.setUser(user1);
                userVoucher.setVoucher(voucher);
                userVoucher.setIsUsed(false);
                user1.getVouchers().add(userVoucher);
                userVoucherRepository.save(userVoucher);
            }
        }
        if (count == vouchers.size()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "All discount codes are already applied to the user", alreadyAppliedVouchers));
        }
        userRepository.save(user1);
        return ResponseEntity.ok(new APIRespone(true, "Vouchers applied to user successfully", ""));
    }
    @Override
    public ResponseEntity<APIRespone> getVouchersByUserId(Long userId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isEmpty()) {
            return ResponseEntity.badRequest().body(new APIRespone(false, "User not found", ""));
        }



        List<VoucherUserResponse> voucherResponses = user.get().getVouchers().stream()
                .map(userVoucher -> new VoucherUserResponse(
                        userVoucher.getVoucher().getVoucherId(),
                        userVoucher.getVoucher().getStores().stream().map(Store::getStoreId).collect(Collectors.toList()),
                        userVoucher.getVoucher().getCode(),
                        userVoucher.getVoucher().getDiscountPercent(),
                        userVoucher.getVoucher().getDescription(),
                        userVoucher.getVoucher().getStartDate(),
                        userVoucher.getVoucher().getEndDate(),
                        userVoucher.getIsUsed()
                ))
                .collect(Collectors.toList());
        return ResponseEntity.ok(new APIRespone(true, "Success", voucherResponses));
    }
}


