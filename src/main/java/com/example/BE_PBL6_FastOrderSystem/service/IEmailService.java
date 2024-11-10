package com.example.BE_PBL6_FastOrderSystem.service;

public interface IEmailService {

    void sendEmail(String to, String subject, String content);
}
