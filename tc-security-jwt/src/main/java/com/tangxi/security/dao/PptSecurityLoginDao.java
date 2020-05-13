package com.tangxi.security.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tangxi.security.entity.Account;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author: tang.xi
 * @date: 2019-05-24
 * @description:
 */
@Mapper
public interface PptSecurityLoginDao extends BaseMapper<Account> {
}
