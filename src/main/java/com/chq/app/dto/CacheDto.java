package com.chq.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor

public class CacheDto {
    private String value;
    private String key;
    private Long expire = 3600L;
}
