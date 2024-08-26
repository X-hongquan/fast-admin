package com.chq.app.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.chq.app.pojo.LoginLog;
import com.chq.app.service.ILoginLogService;
import com.chq.app.mapper.LoginLogMapper;
import org.springframework.stereotype.Service;

/**
* @author ASUS
* @description 针对表【login_log】的数据库操作Service实现
* @createDate 2024-08-26 17:46:39
*/
@Service
public class LoginLogServiceImpl extends ServiceImpl<LoginLogMapper, LoginLog> implements ILoginLogService {

}




