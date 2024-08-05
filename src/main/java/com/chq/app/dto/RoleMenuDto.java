package com.chq.app.dto;

import lombok.Data;

@Data
public class RoleMenuDto {
    private Long roleId;
    private Long[] menuIds;
}
