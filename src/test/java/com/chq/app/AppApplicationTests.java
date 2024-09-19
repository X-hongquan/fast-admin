package com.chq.app;

import com.chq.app.common.annoation.PreAuth;
import com.chq.app.pojo.Permission;
import com.chq.app.pojo.RolePermission;
import com.chq.app.pojo.User;
import com.chq.app.service.IPermissionService;
import com.chq.app.service.IRolePermissionService;
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
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.time.LocalDateTime;

@SpringBootTest
class AppApplicationTests {

    @Autowired
    private IUserService userService;


    @Resource
    private StringRedisTemplate stringRedisTemplate;


    @Autowired
    private IPermissionService permissionService;


    @Autowired
    private IRolePermissionService rolePermissionService;

    @Test
    void contextLoads() {
        User user = new User();
        userService.save(user.setId(2L).setUsername("huawei").setPassword(new BCryptPasswordEncoder().encode("123456")));
    }




    @Test
    void test1() {
        Cursor<String> scan = stringRedisTemplate.scan(ScanOptions.scanOptions().match("*").build());
        while (scan.hasNext()) {
            System.out.println(scan.next());
        }
    }


    /**
     * 初始化权限
     */
    @Test
    void test2() throws IOException, ClassNotFoundException {
        permissionService.remove(null);
        rolePermissionService.remove(null);
        ClassLoader classLoader = this.getClass().getClassLoader();
        InputStream resourceAsStream = classLoader.getResourceAsStream("generator/controller.txt");
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(resourceAsStream));
        String line;
        new Permission();
        long id=1L;
        while ((line = bufferedReader.readLine()) != null) {
            System.out.println(line);
            Class<?> clazz = Class.forName(line);
            Method[] methods = clazz.getMethods();
            for (Method method : methods) {
                if (method.isAnnotationPresent(PreAuth.class)) {
                    PreAuth annotation = method.getAnnotation(PreAuth.class);
                    Permission permission = new Permission().setId(id)
                            .setCode(annotation.value())
                            .setDescription(annotation.description());
                    permission.setCreateBy("admin");
                    permission.setUpdateBy("admin");
                    permission.setCreateTime(LocalDateTime.now());
                    permission.setUpdateTime(LocalDateTime.now());
                    try {
                        permissionService.save(permission);
                        rolePermissionService.save(new RolePermission().setPermissionId(permission.getId()).setRoleId(2L).setId(id));
                        id++;
                    } catch (RuntimeException e) {

                    }
                }
            }
        }
    }

}
