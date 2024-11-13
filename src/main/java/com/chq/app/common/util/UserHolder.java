package com.chq.app.common.util;


import com.chq.app.common.domain.LoginUser;

public class UserHolder {
    private static final ThreadLocal<LoginUser> tl = new ThreadLocal<>();

    public static void saveUser(LoginUser user){
        tl.set(user);
    }

    public static LoginUser getUser(){
        return tl.get();
    }

    public static void removeUser(){
        tl.remove();
    }





}