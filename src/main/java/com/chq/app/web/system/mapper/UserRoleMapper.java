package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.UserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 * 用户角色表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-08-02
 */

public interface UserRoleMapper extends BaseMapper<UserRole> {

    Long getMaxRoleByUserId(Long id);
}
