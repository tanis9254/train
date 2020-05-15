package com.tangxi.sharding;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@SpringBootApplication
public class ShardingApplication {
    public static void main(String[] args) {
        SpringApplication.run(ShardingApplication.class);
    }
}
