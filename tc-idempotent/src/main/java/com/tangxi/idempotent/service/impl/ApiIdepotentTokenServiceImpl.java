package com.tangxi.idempotent.service.impl;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.api.R;
import com.rsy.rxf.springmvc.exception.BusinessException;
import com.tangxi.idempotent.constant.Constant;
import com.tangxi.idempotent.enumapi.ResponseCode;
import com.tangxi.idempotent.service.ApiIdempotentTokenService;
import com.tangxi.idempotent.uitl.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
@Service
public class ApiIdepotentTokenServiceImpl implements ApiIdempotentTokenService {
    private static final String API_IDEMPOTENT_TOKEN_NAME = "apiIdempotentToken";

    @Autowired
    private RedisUtil redisUtil;

    @Override
    public R createToken() {
        String str = UUID.randomUUID().toString();
        StringBuilder token = new StringBuilder();
        token.append(Constant.Redis.TOKEN_PREFIX).append(str);
        redisUtil.set(token.toString(), token.toString(), Constant.Redis.EXPIRE_TIME_FIVE_MINUTE);
        return R.ok(token.toString());
    }

    @Override
    public void checkToken(HttpServletRequest request) {
        String token = request.getHeader(API_IDEMPOTENT_TOKEN_NAME);
        // header中不存在token
        if (StringUtils.isBlank(token)) {
            token = request.getParameter(API_IDEMPOTENT_TOKEN_NAME);
            // parameter中也不存在token
            if (StringUtils.isBlank(token)) {
                throw new BusinessException(ResponseCode.ILLEGAL_ARGUMENT.getCode(), ResponseCode.ILLEGAL_ARGUMENT.getMsg());
            }
        }

        if (!redisUtil.exists(token)) {
            throw new BusinessException(ResponseCode.REPETITIVE_OPERATION.getCode(), ResponseCode.REPETITIVE_OPERATION.getMsg());
        }

        Boolean del = redisUtil.del(token);
        if (!del) {
            throw new BusinessException(ResponseCode.REPETITIVE_OPERATION.getCode(), ResponseCode.REPETITIVE_OPERATION.getMsg());
        }
    }
}
