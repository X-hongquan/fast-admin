package com.chq.app.dto;

import com.chq.app.pojo.RolePermission;
import lombok.Data;

@Data
public class RolePermissionDto {
    private Long roleId;
    private Long[] permissionIds;
}
