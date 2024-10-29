package com.example.BE_PBL6_FastOrderSystem.response;

import lombok.*;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class APILazyOrders {
        private Boolean success;
        private int page;
        private String message;
        private Object data;
}
