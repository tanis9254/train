package com.tangxi.sharding.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tangxi.sharding.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {
}
