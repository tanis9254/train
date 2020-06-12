package com.tangxi.rocketmq.business.controller;

/**
 * @author: tang.xi
 * @date: 2020/6/12
 * @description:
 */

import com.rsy.rxf.springmvc.ResultModel;
import com.tangxi.rocketmq.business.constant.RocketConstant;
import com.tangxi.rocketmq.business.entity.PraiseRecord;
import org.apache.rocketmq.spring.core.RocketMQTemplate;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
@RestController
@RequestMapping("/message")
public class MessageController {
    @Resource
    private RocketMQTemplate rocketMQTemplate;

    @PostMapping("/praise")
    public ResultModel praise(@RequestBody PraiseRecord vo) {
        rocketMQTemplate.sendOneWay(RocketConstant.PRAISE_TOPIC, MessageBuilder.withPayload(vo).build());
        return ResultModel.success("success");
    }

    // ......

}
