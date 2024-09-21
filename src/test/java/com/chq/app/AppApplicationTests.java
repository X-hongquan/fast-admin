package com.chq.app;

import com.chq.app.common.annoation.PreAuth;
import com.chq.app.pojo.*;
import com.chq.app.service.*;
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
import java.util.List;

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
     *初始化查询权限
     */
    @Test
    void initQuery() {
        rolePermissionService.remove(null);
        Long i=1L;
        List<Permission> list = permissionService.list();
        for (Permission permission : list) {
            if (permission.getCode().contains("query")) {
                rolePermissionService.save(new RolePermission().setPermissionId(permission.getId()).setRoleId(2L).setId(i++));
            }
        }
    }

    @Autowired
    private IRoleMenuService roleMenuService;

    @Autowired
    private IMenuService menuService;
    /**
     * 初始化role——menu
     */
    @Test
    public void initRoleMenu() {
        roleMenuService.remove(null);
        List<Menu> list = menuService.list();
        Long id=1L;
        for (Menu menu : list) {
            roleMenuService.save(new RoleMenu().setMenuId(menu.getId()).setRoleId(2L).setId(id++));
        }
    }





    /**
     * 初始化权限数据表
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
