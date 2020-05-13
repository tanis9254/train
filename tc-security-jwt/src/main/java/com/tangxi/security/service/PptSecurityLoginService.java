package com.tangxi.security.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tangxi.security.entity.Account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public interface PptSecurityLoginService extends IService<Account> {
    /**
     * 密码登录
     *
     * @param account
     * @return
     */
    String login(Account account);

    /**
     * 登出
     * @return
     */
    boolean logout(HttpServletRequest request, HttpServletResponse response);
}
