package com.rsy.rxf.oauth2;

import com.rsy.rxf.oauth2.store.RedisTemplateTokenStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.JwtTokenStore;


/**
 * @author 作者 owen E-mail: 624191343@qq.com
 * @version 创建时间：2018年4月5日 下午19:52:21
 *          类说明
 *          redis存储token
 */
@Configuration
public class TokenStoreConfig {

    @Autowired(required = false)
    private RedisTemplate<String, Object> redisTemplate;


    @Primary
    @Bean
    @ConditionalOnProperty(prefix = "security.oauth2.token.store", name = "type", havingValue = "redis", matchIfMissing = true)
    public RedisTemplateTokenStore redisTokenStore() {
//		return new RedisTokenStore( redisTemplate.getConnectionFactory() ) ; //单台redis服务器

        RedisTemplateTokenStore redisTemplateStore = new RedisTemplateTokenStore();
        redisTemplateStore.setRedisTemplate(redisTemplate);
        return redisTemplateStore;


    }

    //使用jwt替换原有的uuid生成token方式
    @Configuration
    @ConditionalOnProperty(prefix = "security.oauth2.token.store", name = "type", havingValue = "jwt", matchIfMissing = true)
    public static class JWTTokenConfig {
        @Bean
        public JwtTokenStore jwtTokenStore() {
            return new JwtTokenStore(jwtAccessTokenConverter());
        }

        @Bean
        public JwtAccessTokenConverter jwtAccessTokenConverter() {
            JwtAccessTokenConverter accessTokenConverter = new JwtAccessTokenConverter();
            accessTokenConverter.setSigningKey("neusoft");
            return accessTokenConverter;
        }
    }

}
