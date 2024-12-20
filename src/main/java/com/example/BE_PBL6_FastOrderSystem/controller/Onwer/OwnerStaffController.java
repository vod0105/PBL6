package com.example.BE_PBL6_FastOrderSystem.controller.Onwer;

import com.example.BE_PBL6_FastOrderSystem.request.ScheduleRequest;
import com.example.BE_PBL6_FastOrderSystem.request.StaffRequest;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.security.user.FoodUserDetails;
import com.example.BE_PBL6_FastOrderSystem.service.IScheduleService;
import com.example.BE_PBL6_FastOrderSystem.service.IStaffService;
import jakarta.persistence.PostPersist;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
@RestController
@RequestMapping("/api/v1/owner")
@RequiredArgsConstructor
public class OwnerStaffController {
    private final IStaffService staffService;
    private final IScheduleService scheduleService;
    @PostMapping("/staff/create")
    public ResponseEntity<APIRespone> createStaff(@RequestBody StaffRequest request) {
        Long OwerId = FoodUserDetails.getCurrentUserId();
        return staffService.createStaff(OwerId,request);
    }
    @GetMapping("/staff/all")
    public ResponseEntity<APIRespone> getAllStaff() {
        return staffService.getAllStaff();
    }
    @GetMapping("/staff/store")
    public ResponseEntity<APIRespone> getStaffByStoreId() {
        Long OwerId = FoodUserDetails.getCurrentUserId();
        return staffService.getStaffByStoreId(OwerId);
    }
    @GetMapping("/staff/{id}")
    public ResponseEntity<APIRespone> getStaffById(@PathVariable Long id) {
        return staffService.getStaffById(id);
    }
    @GetMapping("/staff/code/{staff_code}")
    public ResponseEntity<APIRespone> getStaffByStaffCode(@PathVariable String staff_code) {
        return staffService.getStaffByStaffCode(staff_code);
    }
    @PutMapping("/staff/update/{id}")
    public ResponseEntity<APIRespone> updateStaff(@PathVariable Long id, @RequestBody StaffRequest request) {
        Long OwerId = FoodUserDetails.getCurrentUserId();
        return staffService.updateStaff(OwerId,id, request);
    }
    @DeleteMapping("/staff/delete/{id}")
    public ResponseEntity<APIRespone> deleteStaff(@PathVariable Long id) {
        return staffService.deleteStaff(id);
    }
    @PostMapping("/schedule/create")
    public ResponseEntity<APIRespone> createSchedule(@RequestBody ScheduleRequest request) {
        return scheduleService.createSchedule(request);
    }
    @GetMapping("/schedule/all")
    public ResponseEntity<APIRespone> getAllSchedule() {
        return scheduleService.getAllSchedule();
    }
    @GetMapping("/schedule/store")
    public ResponseEntity<APIRespone> getScheduleByStoreId() {
        Long OwerId = FoodUserDetails.getCurrentUserId();
        return scheduleService.getScheduleByStoreId(OwerId);
    }
    @GetMapping("/schedule/staff/{staffId}")
    public ResponseEntity<APIRespone> getScheduleByStaffId(@PathVariable Long staffId) {
        return scheduleService.getScheduleByStaffId(staffId);
    }
    @GetMapping("/schedule/{id}")
    public ResponseEntity<APIRespone> getScheduleById(@PathVariable Long id) {
        return scheduleService.getScheduleById(id);
    }
    @GetMapping("/schedule/staff")
    public ResponseEntity<APIRespone> getScheduleByStaffId(@RequestParam String staffName) {
        return scheduleService.getScheduleByEmployeeName(staffName);
    }
    @PutMapping("/schedule/update/{id}")
    public ResponseEntity<APIRespone> updateSchedule(@PathVariable Long id, @RequestBody ScheduleRequest request) {
        return scheduleService.updateSchedule(id, request);
    }
    @DeleteMapping("/schedule/delete/{id}")
    public ResponseEntity<APIRespone> deleteSchedule(@PathVariable Long id) {
        return scheduleService.deleteSchedule(id);
    }

}
