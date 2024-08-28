package com.chq.app.controller;

import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.chq.app.common.domain.R;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Base64;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import static com.chq.app.common.constant.RedisConstant.CAPTCHA_TIME;

@RestController
@RequestMapping("/captcha")
public class CaptchaController {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int WIDTH = 100;
    private static final int HEIGHT = 40;
    private static final int FONT_SIZE = 20;
    private static final int NUMBER_OF_CHARACTERS = 4;


    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping
    public R<Map<String, String>> get() {

        // Generate captcha string
        String captcha = generateRandomString(NUMBER_OF_CHARACTERS);

        // Create an image
        BufferedImage bufferedImage = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = bufferedImage.createGraphics();
        // Set background color
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, WIDTH, HEIGHT);

        // Set border
        g2d.setColor(Color.BLACK);
        g2d.drawRect(0, 0, WIDTH - 1, HEIGHT - 1);

        Random random = new Random();
        // Draw captcha string
        g2d.setFont(new Font("Arial", Font.BOLD, FONT_SIZE));
        for (int i = 0; i < captcha.length(); i++) {
            g2d.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
            g2d.drawString(Character.toString(captcha.charAt(i)), i * FONT_SIZE + 10, FONT_SIZE + 10);
        }

        // Dispose the graphics context
        g2d.dispose();
        String key = IdWorker.get32UUID();
        // Save the image
        try (ByteArrayOutputStream os = new ByteArrayOutputStream()) {
            ImageIO.write(bufferedImage, "png", os);
            String s = Base64.getEncoder().encodeToString(os.toByteArray());
            stringRedisTemplate.opsForValue().set(key, captcha, CAPTCHA_TIME, TimeUnit.SECONDS);
            Map<String, String> map = Map.of("key", key, "img", s);
            return R.ok(map);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return R.fail();
    }

    private static String generateRandomString(int length) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }
}
