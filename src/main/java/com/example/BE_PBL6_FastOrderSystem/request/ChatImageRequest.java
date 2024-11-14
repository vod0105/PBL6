package com.example.BE_PBL6_FastOrderSystem.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatImageRequest {
    private Long sender;
    private Long receiver;
    private String message;
    private String imageBase64;
    private boolean isRead;


}