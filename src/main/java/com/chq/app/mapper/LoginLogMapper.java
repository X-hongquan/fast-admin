package com.chq.app.mapper;

import com.chq.app.pojo.LoginLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author ASUS
* @description 针对表【login_log】的数据库操作Mapper
* @createDate 2024-08-26 17:46:39
* @Entity com.chq.app.pojo.LoginLog
*/
public interface LoginLogMapper extends BaseMapper<LoginLog> {

    List<LoginLog> getList(LoginLog loginLog);

}




