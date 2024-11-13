package com.chq.app.web.system.controller;

import com.chq.app.common.annoation.PreAuth;
import com.chq.app.common.domain.R;
import com.chq.app.dto.CacheDto;
import com.chq.app.dto.CacheKeyDto;

import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/cache")
public class CacheController {

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping("/list")
    @PreAuth(value = "system:cache:query",description = "缓存查询权限")
    public R<List<CacheKeyDto>> list() {
        Cursor<String> scan = stringRedisTemplate.scan(ScanOptions.scanOptions().build());
        List<CacheKeyDto> list = new ArrayList<>();
        Map<String, CacheKeyDto> map = new HashMap<>();
        while (scan.hasNext()) {
            String next = scan.next();
            String prefix = StringUtils.substringBeforeLast(next, ":");
            if (next.length() == prefix.length()) {
                CacheKeyDto cacheKeyDto = new CacheKeyDto()
                        .setKey(next)
                        .setAllKey(next);
                list.add(cacheKeyDto);
            } else {
                CacheKeyDto lastKey = new CacheKeyDto()
                        .setKey(StringUtils.substringAfterLast(next, ":"))
                        .setAllKey(next);
                transKey(prefix, lastKey, map, list);
            }

        }
        return R.ok(list);
    }

    private void transKey(String prefix, CacheKeyDto lastKey, Map<String, CacheKeyDto> map, List<CacheKeyDto> list) {
        if (map.containsKey(prefix)) {
            CacheKeyDto cacheKeyDto = map.get(prefix);
            if (cacheKeyDto.getChildren() == null)
                cacheKeyDto.setChildren(new ArrayList<>());
            cacheKeyDto.getChildren().add(lastKey);
            return;
        }
        CacheKeyDto parent = new CacheKeyDto()
                .setKey(StringUtils.substringAfterLast(prefix, ":"))
                .setAllKey(prefix);
        if (parent.getChildren() == null)
            parent.setChildren(new ArrayList<>());
        map.put(prefix, parent);
        parent.getChildren().add(lastKey);
        if (!prefix.contains(":")) {
            parent.setKey(prefix);
            list.add(parent);
        } else {
            transKey(StringUtils.substringBeforeLast(prefix, ":"), parent, map, list);
        }
    }


    @GetMapping("/info/{key}")
    @PreAuth(value = "system:cache:query",description = "缓存查询权限")
    public R<CacheDto> info(@PathVariable("key") String key) {
        String value = stringRedisTemplate.opsForValue().get(key);
        Long expire = stringRedisTemplate.getExpire(key, TimeUnit.SECONDS);
        CacheDto obj = new CacheDto(value, key, expire);
        return R.ok(obj);
    }

    @PostMapping
    @PreAuth(value = "system:cache:add",description = "缓存添加权限")
    public R<String> add(@RequestBody CacheDto dto) {
        stringRedisTemplate.opsForValue().set(dto.getKey(), dto.getValue(), dto.getExpire(), TimeUnit.SECONDS);
        return R.ok();
    }

    @PostMapping("/del")
    @PreAuth(value = "system:cache:remove",description = "缓存删除权限")
    public R<String> del(@RequestBody CacheKeyDto cacheKeyDto) {
        transDto(cacheKeyDto);
        return R.ok();
    }

    private void transDto(CacheKeyDto cacheKeyDto) {
        if (cacheKeyDto.getChildren() != null) {
            for (CacheKeyDto child : cacheKeyDto.getChildren()) {
                transDto(child);
            }
        }
        stringRedisTemplate.delete(cacheKeyDto.getAllKey());
    }
}
