package com.tangxi.idempotent.uitl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
@Component
@Slf4j
public class RedisUtil {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 设值
     * @param key
     * @param value
     * @return
     */
    public void set(String key, String value) {
        log.info("set key:{} value:{}", key, value);
        redisTemplate.opsForValue().set(key,value);
    }

    /**
     * 设值
     * @param key
     * @param value
     * @param expireTime 过期时间, 单位: s
     * @return
     */
    public void set(String key, String value, int expireTime) {
        log.info("set key:{} value:{} expireTime:{}", key, value, expireTime);
        redisTemplate.opsForValue().set(key,value, expireTime, TimeUnit.SECONDS);
    }

    /**
     * 取值
     * @param key
     * @return
     */
    public Object get(String key) {
        log.info("get key:{}", key);
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * 删除key
     * @param key
     * @return
     */
    public Boolean del(String key) {
        if (exists(key)) {
            return redisTemplate.delete(key);
        } else {
            log.error("del key:{}", key+" 不存在");
            return false;
        }

    }

    /**
     * 判断key是否存在
     * @param key
     * @return
     */
    public Boolean exists(String key) {
        Boolean exists = redisTemplate.hasKey(key);
        log.info("exists key:{} hasKey:{}", key, exists);
        return exists;
    }
}