package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.LoginLog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.chq.app.web.system.pojo.User;

import java.util.List;

/**
 * @author ASUS
 * @description 针对表【login_log】的数据库操作Service
 * @createDate 2024-08-26 17:46:39
 */
public interface ILoginLogService extends IService<LoginLog> {


    public void recordLoginLog(User user, String token,String ip);

    List<LoginLog> getList(LoginLog loginLog);



}
