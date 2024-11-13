package com.chq.app.dto;

import lombok.Data;

@Data
public class RolePermissionDto {
    private Long roleId;
    private Long[] permissionIds;
}
