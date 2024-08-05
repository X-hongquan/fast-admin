package com.chq.app.mapper;

import com.chq.app.pojo.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * 角色表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface RoleMapper extends BaseMapper<Role> {

    List<Role> getList(Role role);
}
