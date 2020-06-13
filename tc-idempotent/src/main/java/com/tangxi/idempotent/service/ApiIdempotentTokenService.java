package com.tangxi.idempotent.service;


import com.baomidou.mybatisplus.extension.api.R;

import javax.servlet.http.HttpServletRequest;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
public interface ApiIdempotentTokenService {
    R createToken();

    void checkToken(HttpServletRequest request);
}
