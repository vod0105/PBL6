package com.example.BE_PBL6_FastOrderSystem.request;

import lombok.Data;

@Data
public class ShipperRequest {
    private String fullName;
    private String email;
    private String address;
    private String phoneNumber;
    private String password;
    private String code;

    public ShipperRequest(String fullName, String email, String address, String numberPhone, String password, String code) {
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.phoneNumber = numberPhone;
        this.password = password;
        this.code = code;
    }
}
