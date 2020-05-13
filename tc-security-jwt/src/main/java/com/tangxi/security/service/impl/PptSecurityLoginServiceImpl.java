package com.tangxi.security.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tangxi.security.config.JwtUserDetailService;
import com.tangxi.security.config.SecurityUser;
import com.tangxi.security.config.uitl.JwtTokenUtils;
import com.tangxi.security.constant.AccountAdminConstant;
import com.tangxi.security.dao.PptSecurityLoginDao;
import com.tangxi.security.entity.Account;
import com.tangxi.security.service.AccountAdminService;
import com.tangxi.security.service.PptSecurityLoginService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Service;
import rxf.springmvc.exception.BusinessParameterException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author tang.xi
 * @date 2019-05-24
 */
@Service
public class PptSecurityLoginServiceImpl extends ServiceImpl<PptSecurityLoginDao, Account> implements PptSecurityLoginService {

    public static final Logger LOGGER = LoggerFactory.getLogger(PptSecurityLoginServiceImpl.class);

    private static final String PPT_MOBILE_CODE_KEY_PREFIX = "LOGIN:PPT:MOBILE_CODE";
    private static final String PPT_WECHAT_SESSION_KEY = "LOGIN_WECHAT:SESSION_KEY";

    private static final int CODE_EXPIRE = 540;

    private static final String PPT_LOGIN_USERNAME = "username";
    private static final String PPT_LOGIN_PASSWORD = "password";

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private JwtUserDetailService jwtUserDetailService;

    /**
     * 密码登录
     *
     * @param account
     * @return
     */
    @Override
    public String login(Account account) {
        if (StringUtils.isBlank(account.getUsername())) {
            throw new BusinessParameterException("用户名或密码错误");
        }
        if (StringUtils.isBlank(account.getPassword())) {
            throw new BusinessParameterException("用户名或密码错误");
        }
        SecurityUser<Account> userDetails = (SecurityUser<Account>) jwtUserDetailService.loadUserByUsername(account.getUsername());
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if (!passwordEncoder.matches(account.getPassword(), userDetails.getPassword())) {
            throw new BusinessParameterException("密码不正确");
        }

        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        String authCacheKey = AccountAdminConstant.currentAccountTokenKey + userDetails.getAccount().getAccountId();
        // 生成新的token
        Account SecurityAccount = userDetails.getAccount();
        String token = JwtTokenUtils.generateToken(SecurityAccount.getAccountId(), SecurityAccount.getUsername());
        // 过期时间设置早于jwt过期时间10s
        // 直接替换
        redisTemplate.opsForValue().set(authCacheKey, token, JwtTokenUtils.getTtl() - 10 * 1000, TimeUnit.MILLISECONDS);
        return token;
    }

    @Override
    public boolean logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            Long accountId = ((SecurityUser<Account>) auth.getPrincipal()).getAccount().getAccountId();
            new SecurityContextLogoutHandler().logout(request, response, auth);
            redisTemplate.delete(AccountAdminConstant.currentAccountTokenKey + accountId);
            redisTemplate.delete(AccountAdminConstant.currentAccountRoleIdKey + accountId);
            redisTemplate.delete(AccountAdminConstant.currentAccountResourceListKey + accountId);
            redisTemplate.delete(AccountAdminConstant.currentAccountOrgIdKey + accountId);
            redisTemplate.delete(AccountAdminConstant.currentAccountDoctorKey + accountId);
        }
        return true;
    }

}
