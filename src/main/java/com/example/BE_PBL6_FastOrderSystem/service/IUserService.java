package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.exception.UserNotFoundException;
import com.example.BE_PBL6_FastOrderSystem.request.UserRequest;
import com.example.BE_PBL6_FastOrderSystem.request.UserRequestV2;
import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import com.example.BE_PBL6_FastOrderSystem.response.UserResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

public interface IUserService {

    ResponseEntity<APIRespone> getUsers(String role);

    ResponseEntity<APIRespone> getLocations(Long userId);

    ResponseEntity<APIRespone> lockUserAccount(Long userId) throws UserNotFoundException;

    ResponseEntity<APIRespone> getUserProfile(Long userId);

    ResponseEntity<APIRespone> updateUser (Long id, UserRequest userRequest);
    ResponseEntity<APIRespone> updateUserV2 (Long id, UserRequestV2 userRequest);

    ResponseEntity<APIRespone> updateUserV3(Long id, UserRequestV2 userRequest);

    ResponseEntity<APIRespone> unlockUserAccount(Long userId) throws UserNotFoundException;

    UserDetails loadUserByNumberPhone(String numberPhone);

    ResponseEntity<APIRespone> getAllUsers();

    ResponseEntity<APIRespone> addPhone(Long userId, String phone);
    ResponseEntity<APIRespone> searchByName(String name);
    ResponseEntity<APIRespone> getByid(Long id);
    ResponseEntity<APIRespone> countOrderByMonth();
    List<UserResponse> getSearchByPhoneNumber(String phoneNumber);
    ResponseEntity<APIRespone> resetPassword(Long userId, String oldPassword, String newPassword);
}