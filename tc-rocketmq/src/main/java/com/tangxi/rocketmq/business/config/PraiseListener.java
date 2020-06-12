package com.tangxi.rocketmq.business.config;

import com.tangxi.rocketmq.business.constant.RocketConstant;
import com.tangxi.rocketmq.business.entity.PraiseRecord;
import com.tangxi.rocketmq.business.service.PraiseRecordService;
import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.consumer.DefaultMQPushConsumer;
import org.apache.rocketmq.spring.annotation.RocketMQMessageListener;
import org.apache.rocketmq.spring.core.RocketMQListener;
import org.apache.rocketmq.spring.core.RocketMQPushConsumerLifecycleListener;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author: tang.xi
 * @date: 2020/6/12
 * @description:
 */
@Service
@RocketMQMessageListener(topic = RocketConstant.PRAISE_TOPIC, consumerGroup = RocketConstant.PRAISE_CONSUMER)
@Slf4j
public class PraiseListener implements RocketMQListener<PraiseRecord>, RocketMQPushConsumerLifecycleListener {
    @Resource
    private PraiseRecordService praiseRecordService;

    @Override
    public void onMessage(PraiseRecord vo) {
        praiseRecordService.save(vo);
    }

    @Override
    public void prepareStart(DefaultMQPushConsumer consumer) {
        // 每次拉取的间隔，单位为毫秒
        consumer.setPullInterval(1000);
        // 设置每次从队列中拉取的消息数为16
        consumer.setPullBatchSize(32);
    }

}