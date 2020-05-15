package com.tangxi.sharding.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.List;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@Data
@ConfigurationProperties(prefix = "spring.datasource.jdbc2")
public class ShardDataSourceTwo {
    private String driverClassName;
    private String url;
    private String username;
    private String password;
    private String filters;
    private int maxActive;
    private int initialSize;
    private int maxWait;
    private int minIdle;
    private int timeBetweenEvictionRunsMillis;
    private int minEvictableIdleTimeMillis;
    private String validationQuery;
    private boolean testWhileIdle;
    private boolean testOnBorrow;
    private boolean testOnReturn;
    private boolean poolPreparedStatements;
    private int maxPoolPreparedStatementPerConnectionSize;
    private boolean removeAbandoned;
    private int removeAbandonedTimeout;
    private boolean logAbandoned;
    private List<String> connectionInitSqls;
    private String connectionProperties;
}
