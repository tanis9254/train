package com.tangxi.security.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tangxi.security.entity.Account;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author: tang.xi
 * @date: 2020/5/9
 * @description:
 */
@Mapper
public interface AccountDao extends BaseMapper<Account> {
}
