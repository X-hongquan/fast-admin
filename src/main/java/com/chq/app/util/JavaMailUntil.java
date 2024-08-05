package com.chq.app.util;


import com.chq.app.dto.MessageDto;
import lombok.extern.slf4j.Slf4j;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Slf4j
public final class JavaMailUntil {


    private static final Session smtpSession;


    private static final String username = "chq1340@qq.com";
    private static final String password = "lmdhejswritkjjif";


    static {


        //	创建一个配置文件，并保存
        Properties props = new Properties();

        //	SMTP服务器连接信息
        //  126——smtp.126.com
        //  163——smtp.163.com
        //  qq-smtp.qq.com"
        props.put("mail.smtp.host", "smtp.qq.com");//	SMTP主机名

        //  126——25
        //  163——645
        props.put("mail.smtp.port", "25");//	主机端口号
        props.put("mail.smtp.auth", "true");//	是否需要用户认证
        props.put("mail.smtp.starttls.enale", "true");//	启用TlS加密
        smtpSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(username, password);
            }
        });

    }

    public static boolean sendMail(MessageDto messageDto) {
        try {
            MimeMessage message = new MimeMessage(smtpSession);
            message.setSubject(messageDto.getTheme());
            message.setText(messageDto.getContent());
            message.setFrom(new InternetAddress(username));
            message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(messageDto.getTo()));
            Transport.send(message);
            return true;
        } catch (Exception e) {
            log.error("发送邮件失败", e);
            return false;
        }
    }
}