package com.example.BE_PBL6_FastOrderSystem.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class EmailReponse {
    private Integer emailNumber;
    private String subject;
    private String from;
    private String text;
}
