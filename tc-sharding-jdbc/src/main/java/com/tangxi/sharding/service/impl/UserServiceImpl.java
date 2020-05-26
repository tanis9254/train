package com.tangxi.sharding.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tangxi.sharding.dao.UserMapper;
import com.tangxi.sharding.entity.User;
import com.tangxi.sharding.service.IUserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
}
