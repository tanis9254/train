package com.tangxi.security.config;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.tangxi.security.entity.Account;
import com.tangxi.security.service.AccountAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import rxf.springmvc.exception.BusinessDataNotExistException;

import java.util.HashSet;
import java.util.Set;

/**
 * @author: fei.yao
 * @date: 2019-08-06
 * @modified by:
 */
@Component
public class JwtUserDetailService implements UserDetailsService {

    @Autowired
    private AccountAdminService accountAdminService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_CUSTOM"));
        Account account = accountAdminService.getOne(new QueryWrapper<Account>().eq("username", username));
        if (account == null) {
            throw new BusinessDataNotExistException("当前用户不存在");
        }
        System.out.println(grantedAuthorities);
        return new SecurityUser<>(account.getAccountId() + "", username, account.getPassword(), account, grantedAuthorities);
    }
}
