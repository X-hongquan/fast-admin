package com.chq.app.dto;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@Accessors(chain = true)
public class CacheKeyDto {

    private String key;
    private String allKey;
    private List<CacheKeyDto> children;

}
