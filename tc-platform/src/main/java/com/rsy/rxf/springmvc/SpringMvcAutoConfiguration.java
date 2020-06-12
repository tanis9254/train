package com.rsy.rxf.springmvc;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rsy.rxf.util.RxfUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

@Configuration
public class SpringMvcAutoConfiguration {

    @Bean
    public ObjectMapper objectMapper() {
        return RxfUtils.objectMapper;
    }

    @Bean
    public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter() {
        return new MappingJackson2HttpMessageConverter(objectMapper());
    }
}
