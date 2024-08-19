package com.chq.app.common.domain;

import com.chq.app.common.exception.AuthException;
import com.chq.app.pojo.Role;
import com.chq.app.pojo.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Data
public class LoginUser {


    private static final Role role = new Role(1L, "系统管理员");

    private User user;
    private String token;
    private Set<String> permissions;
    private Set<Role> roles;

    private Set<Long> roleKeys;



    public boolean isAdmin() {
        return roles.contains(role);
    }


    public String getUsername() {
        return user.getUsername();
    }

    public void checkHasControl(String createBy) {
        if (isAdmin()) return;
        if (!getUsername().equals(createBy)) {
            throw new AuthException();
        }
    }

    public Set<Long> getRoleKeys() {
        if (roleKeys == null) {
            roleKeys = roles.stream().map(Role::getId).collect(Collectors.toSet());
        }
        return roleKeys;
    }

    public boolean containRole(Long key) {
       return getRoleKeys().contains(key);
    }
}
