package com.tangxi.security.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tangxi.security.entity.Account;

/**
 * @author: tang.xi
 * @date: 2020/5/9
 * @description:
 */
public interface AccountAdminService extends IService<Account> {
    Boolean create(Account account, String password);
}
