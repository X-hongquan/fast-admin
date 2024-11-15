package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.Role;
import com.chq.app.web.system.pojo.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface UserMapper extends BaseMapper<User> {


    LinkedHashSet<Role> getRoleIdsByUserId(Long id);

    Set<String> getPermissionsByRoleIds(Set<Long> roleIds);


    List<User> getUserList(User user);
}
