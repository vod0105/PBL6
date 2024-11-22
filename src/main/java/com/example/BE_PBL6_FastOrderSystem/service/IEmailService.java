package com.example.BE_PBL6_FastOrderSystem.service;

import com.example.BE_PBL6_FastOrderSystem.response.APIRespone;
import org.springframework.http.ResponseEntity;

public interface IEmailService {

    void sendEmail(String to, String subject, String content);

    ResponseEntity<APIRespone> receiveEmail(String user, String password, String senderEmail);

    ResponseEntity<APIRespone> receiveAllEmail(String user, String password);

}
