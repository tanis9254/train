package com.tangxi.security.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tangxi.security.dao.AccountDao;
import com.tangxi.security.entity.Account;
import com.tangxi.security.service.AccountAdminService;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * @author: tang.xi
 * @date: 2020/5/9
 * @description:
 */
@Service
public class AccountAdminServiceImpl extends ServiceImpl<AccountDao, Account> implements AccountAdminService {

    public static final String DEFAULT_PASSWORD = "123456";

    @Override
    public Boolean create(Account account, String password) {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        account.setPassword(bCryptPasswordEncoder.encode(DEFAULT_PASSWORD));
        if (this.baseMapper.insert(account) > 0) {
            return Boolean.TRUE;
        }
        return Boolean.FALSE;
    }
}
