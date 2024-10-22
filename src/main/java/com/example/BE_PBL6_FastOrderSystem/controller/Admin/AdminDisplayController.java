package com.example.BE_PBL6_FastOrderSystem.controller.Admin;

import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.service.IOrderService;
import com.example.BE_PBL6_FastOrderSystem.service.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/admin/display")
@RequiredArgsConstructor
public class AdminDisplayController {
    private final IOrderService orderService;
    private final IUserService userService;
    @GetMapping("")
    public String display() {
        return "Admin Display";
    }

    @GetMapping("/budget/all")
        public ResponseEntity<APIRespone> budgetAll() {
        return orderService.getAllTotalAmountOrder();
    }

    @GetMapping("/order/month")
    public ResponseEntity<APIRespone> AllOrderMonth() {
        return orderService.getCountOrderByMonth();
    }

    @GetMapping("/user/register/month")
        public ResponseEntity<APIRespone> userRegisterMonth() {
        return userService.countOrderByMonth();
        }

    @GetMapping("total/year/{y}")
    public ResponseEntity<APIRespone> totalYear(@PathVariable int y) {
        return orderService.getTotalAmountByMonth(y);
    }

    @GetMapping("total/week")
    public ResponseEntity<APIRespone> totalWeek() {
        return orderService.getTotalAmountByWeek();
    }

    @GetMapping("count/products")
    public ResponseEntity<APIRespone> countProducts(@RequestParam String module) {
        return orderService.getCountProductSole(module);
    }

//    @GetMapping("total/stores")
//    public ResponseEntity<APIRespone> totalStores(@RequestParam String module) {
//
//    }
}
