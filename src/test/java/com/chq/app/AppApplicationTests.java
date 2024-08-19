package com.chq.app;

import com.chq.app.pojo.User;
import com.chq.app.service.IUserService;
import com.chq.app.util.JavaMailUntil;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@SpringBootTest
class AppApplicationTests {

    @Autowired
    private IUserService userService;

    @Autowired
    private Session smtpSession;

    @Resource
    private StringRedisTemplate stringRedisTemplate;
    @Test
    void contextLoads() {
        User user = new User();
        userService.save(user.setId(2L).setUsername("huawei").setPassword(new BCryptPasswordEncoder().encode("123456")));
    }

    @Test
    void test() throws MessagingException {
        //	创建Session会话


//	创建邮件对象
        MimeMessage message = new MimeMessage(smtpSession);
        message.setSubject("主题");
        message.setText("文本信息");
        message.setFrom(new InternetAddress("1097274644@qq.com"));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress("1097274644@qq.com"));

//	发
        Transport.send(message);
    }


    @Test
    void test1() {
        Cursor<String> scan = stringRedisTemplate.scan(ScanOptions.scanOptions().match("*").build());
        while (scan.hasNext()) {
            System.out.println(scan.next());
        }
    }

}
