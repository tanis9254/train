package com.tangxi.idempotent.config;

import com.tangxi.idempotent.interceptor.ApiIdempotentInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private ApiIdempotentInterceptor apiIdempotentInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(apiIdempotentInterceptor);
    }
}