package com.chq.app.controller;

import com.chq.app.common.domain.R;
import com.chq.app.dto.CacheDto;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;


import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/cache")
public class CacheController {

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping("/list")
    public R<List<String>> list() {
        Cursor<String> scan = stringRedisTemplate.scan(ScanOptions.scanOptions().build());
        List<String> list = scan.stream().toList();
        return R.ok(list);
    }

    @GetMapping("/info/{key}")
    public R<CacheDto> info(@PathVariable("key") String key) {
        String value = stringRedisTemplate.opsForValue().get(key);
        Long expire = stringRedisTemplate.getExpire(key);
        CacheDto obj = new CacheDto(key, value, expire / 1000);
        return R.ok(obj);
    }

    @PostMapping
    public R<String> add(@RequestBody CacheDto dto) {
        stringRedisTemplate.opsForValue().set(dto.getKey(), dto.getValue(), dto.getExpire(), TimeUnit.SECONDS);
        return R.ok();
    }

    @DeleteMapping("/{key}")
    public R<String> del(@PathVariable("key") String key) {
        stringRedisTemplate.delete(key);
        return R.ok();
    }
}
