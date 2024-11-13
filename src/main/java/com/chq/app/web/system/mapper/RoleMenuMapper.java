package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.RoleMenu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.Set;

/**
 * <p>
 * 角色菜单表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface RoleMenuMapper extends BaseMapper<RoleMenu> {

    Set<Long> getMenuIdsByUserId(Long id);
}
