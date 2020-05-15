package com.tangxi.sharding.datasource;

import com.alibaba.druid.pool.DruidDataSource;
import com.dangdang.ddframe.rdb.sharding.api.ShardingDataSourceFactory;
import com.dangdang.ddframe.rdb.sharding.api.rule.BindingTableRule;
import com.dangdang.ddframe.rdb.sharding.api.rule.DataSourceRule;
import com.dangdang.ddframe.rdb.sharding.api.rule.ShardingRule;
import com.dangdang.ddframe.rdb.sharding.api.rule.TableRule;
import com.dangdang.ddframe.rdb.sharding.api.strategy.database.DatabaseShardingStrategy;
import com.dangdang.ddframe.rdb.sharding.api.strategy.table.TableShardingStrategy;
import com.tangxi.sharding.config.DataBaseShardingAlgorithm;
import com.tangxi.sharding.config.ShardDataSourceOne;
import com.tangxi.sharding.config.ShardDataSourceTwo;
import com.tangxi.sharding.config.TableShardingAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.*;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@Configuration
@EnableTransactionManagement
@ConditionalOnClass(DruidDataSource.class)
@EnableConfigurationProperties({ShardDataSourceOne.class, ShardDataSourceTwo.class})
public class DataSourceConfig {
    @Autowired
    private ShardDataSourceOne dataSource1;
    @Autowired
    private ShardDataSourceTwo dataSource2;

    /**
     * 配置数据源0，数据源的名称最好要有一定的规则，方便配置分库的计算规则
     *
     * @return
     */
    private DataSource db1() throws SQLException {
        return this.getDB1(dataSource1);
    }

    /**
     * 配置数据源1，数据源的名称最好要有一定的规则，方便配置分库的计算规则
     *
     * @return
     */
    private DataSource db2() throws SQLException {
        return this.getDB2(dataSource2);
    }

    /**
     * 配置数据源规则，即将多个数据源交给sharding-jdbc管理，并且可以设置默认的数据源，
     * 当表没有配置分库规则时会使用默认的数据源
     *
     * @return
     */
    @Bean
    public DataSourceRule dataSourceRule() throws SQLException {
        Map<String, DataSource> dataSourceMap = new HashMap<>();
        dataSourceMap.put("dataSource2", this.db2());
        dataSourceMap.put("dataSource1", this.db1());
        return new DataSourceRule(dataSourceMap, "dataSource2");
    }

    /**
     * 配置数据源策略和表策略，具体策略需要自己实现
     *
     * @param dataSourceRule
     * @return
     */
    @Bean
    public ShardingRule shardingRule(@Qualifier("dataSourceRule") DataSourceRule dataSourceRule) {
        //具体分库分表策略
        TableRule orderTableRule = TableRule.builder("t_user")
                .actualTables(Arrays.asList("t_user_0", "t_user_1"))
                .tableShardingStrategy(new TableShardingStrategy("order_id", new TableShardingAlgorithm()))
                .dataSourceRule(dataSourceRule)
                .build();

        //绑定表策略，在查询时会使用主表策略计算路由的数据源，因此需要约定绑定表策略的表的规则需要一致，可以一定程度提高效率
        List<BindingTableRule> bindingTableRuleList = new ArrayList<BindingTableRule>();
        bindingTableRuleList.add(new BindingTableRule(Arrays.asList(orderTableRule)));
        return ShardingRule.builder().dataSourceRule(dataSourceRule)
                .tableRules(Arrays.asList(orderTableRule))
                .bindingTableRules(bindingTableRuleList)
                .databaseShardingStrategy(new DatabaseShardingStrategy("user_id", new DataBaseShardingAlgorithm()))
                .tableShardingStrategy(new TableShardingStrategy("order_id", new TableShardingAlgorithm()))
                .build();
    }

    /**
     * 创建sharding-jdbc的数据源DataSource，MybatisAutoConfiguration会使用此数据源
     *
     * @param shardingRule
     * @return
     * @throws SQLException
     */
    @Bean
    public DataSource shardingDataSource(@Qualifier("shardingRule") ShardingRule shardingRule) throws SQLException {
        return ShardingDataSourceFactory.createDataSource(shardingRule);
    }

    private DruidDataSource getDB1(ShardDataSourceOne shardDataSource1) throws SQLException {
        DruidDataSource ds = new DruidDataSource();
        ds.setDriverClassName(shardDataSource1.getDriverClassName());
        ds.setUrl(shardDataSource1.getUrl());
        ds.setUsername(shardDataSource1.getUsername());
        ds.setPassword(shardDataSource1.getPassword());
        ds.setFilters(shardDataSource1.getFilters());
        ds.setMaxActive(shardDataSource1.getMaxActive());
        ds.setInitialSize(shardDataSource1.getInitialSize());
        ds.setMaxWait(shardDataSource1.getMaxWait());
        ds.setMinIdle(shardDataSource1.getMinIdle());
        ds.setTimeBetweenEvictionRunsMillis(shardDataSource1.getTimeBetweenEvictionRunsMillis());
        ds.setMinEvictableIdleTimeMillis(shardDataSource1.getMinEvictableIdleTimeMillis());
        ds.setValidationQuery(shardDataSource1.getValidationQuery());
        ds.setTestWhileIdle(shardDataSource1.isTestWhileIdle());
        ds.setTestOnBorrow(shardDataSource1.isTestOnBorrow());
        ds.setTestOnReturn(shardDataSource1.isTestOnReturn());
        ds.setPoolPreparedStatements(shardDataSource1.isPoolPreparedStatements());
        ds.setMaxPoolPreparedStatementPerConnectionSize(
                shardDataSource1.getMaxPoolPreparedStatementPerConnectionSize());
        ds.setRemoveAbandoned(shardDataSource1.isRemoveAbandoned());
        ds.setRemoveAbandonedTimeout(shardDataSource1.getRemoveAbandonedTimeout());
        ds.setLogAbandoned(shardDataSource1.isLogAbandoned());
        ds.setConnectionInitSqls(shardDataSource1.getConnectionInitSqls());
        ds.setConnectionProperties(shardDataSource1.getConnectionProperties());
        return ds;
    }

    private DruidDataSource getDB2(ShardDataSourceTwo shardDataSource2) throws SQLException {
        DruidDataSource ds = new DruidDataSource();
        ds.setDriverClassName(shardDataSource2.getDriverClassName());
        ds.setUrl(shardDataSource2.getUrl());
        ds.setUsername(shardDataSource2.getUsername());
        ds.setPassword(shardDataSource2.getPassword());
        ds.setFilters(shardDataSource2.getFilters());
        ds.setMaxActive(shardDataSource2.getMaxActive());
        ds.setInitialSize(shardDataSource2.getInitialSize());
        ds.setMaxWait(shardDataSource2.getMaxWait());
        ds.setMinIdle(shardDataSource2.getMinIdle());
        ds.setTimeBetweenEvictionRunsMillis(shardDataSource2.getTimeBetweenEvictionRunsMillis());
        ds.setMinEvictableIdleTimeMillis(shardDataSource2.getMinEvictableIdleTimeMillis());
        ds.setValidationQuery(shardDataSource2.getValidationQuery());
        ds.setTestWhileIdle(shardDataSource2.isTestWhileIdle());
        ds.setTestOnBorrow(shardDataSource2.isTestOnBorrow());
        ds.setTestOnReturn(shardDataSource2.isTestOnReturn());
        ds.setPoolPreparedStatements(shardDataSource2.isPoolPreparedStatements());
        ds.setMaxPoolPreparedStatementPerConnectionSize(
                shardDataSource2.getMaxPoolPreparedStatementPerConnectionSize());
        ds.setRemoveAbandoned(shardDataSource2.isRemoveAbandoned());
        ds.setRemoveAbandonedTimeout(shardDataSource2.getRemoveAbandonedTimeout());
        ds.setLogAbandoned(shardDataSource2.isLogAbandoned());
        ds.setConnectionInitSqls(shardDataSource2.getConnectionInitSqls());
        ds.setConnectionProperties(shardDataSource2.getConnectionProperties());
        return ds;
    }

}