package com.tangxi.rocketmq.business.entity;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @author: tang.xi
 * @date: 2020/6/12
 * @description:
 */
@Data
public class PraiseRecord implements Serializable {
    private Long id;
    private Long uid;
    private Long liveId;
    private LocalDateTime createTime;
}
