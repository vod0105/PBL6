package com.example.BE_PBL6_FastOrderSystem.controller.Onwer;

import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.security.user.FoodUserDetails;
import com.example.BE_PBL6_FastOrderSystem.service.IOrderService;
import com.example.BE_PBL6_FastOrderSystem.service.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/owner/display")
@RequiredArgsConstructor
public class OwnerDisplayController {
    private final IOrderService orderService;
    private final IUserService userService;
    @GetMapping("")
    public String display() {
        return "Owner Display";
    }

    @GetMapping("/budget/all")
    public ResponseEntity<APIRespone> budgetAll() {
        Long OwnerId = FoodUserDetails.getCurrentUserId();
        return orderService.getAllTotalAmountOrderStore(OwnerId);
    }

    @GetMapping("/order/month")
    public ResponseEntity<APIRespone> AllOrderMonth() {
        Long OwnerId = FoodUserDetails.getCurrentUserId();
        return orderService.getCountOrderByMonthStore(OwnerId);
    }

    @GetMapping("total/year/{y}")
    public ResponseEntity<APIRespone> totalYear(@PathVariable int y) {
        Long OwnerId = FoodUserDetails.getCurrentUserId();
        return orderService.getTotalAmountByMonthStore(OwnerId,y);
    }

    @GetMapping("total/week")
    public ResponseEntity<APIRespone> totalWeek() {
        Long OwnerId = FoodUserDetails.getCurrentUserId();
        return orderService.getTotalAmountByWeekStore(OwnerId);
    }

    @GetMapping("count/products")
    public ResponseEntity<APIRespone> countProducts(@RequestParam String module) {
        Long OwnerId = FoodUserDetails.getCurrentUserId();
        return orderService.getCountProductSoleStore(OwnerId,module);
    }

}
