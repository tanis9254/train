package com.tangxi.idempotent.controller;

import com.baomidou.mybatisplus.extension.api.R;
import com.tangxi.idempotent.annotation.ApiIdempotent;
import com.tangxi.idempotent.service.ApiIdempotentTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
@RestController
@RequestMapping("/mobile/test")
public class TestController {

    @Autowired
    private ApiIdempotentTokenService apiIdempotentTokenService;

    /**
     * 获取token
     * @return
     */
    @RequestMapping("getToken")
    public R getToken() {
        return apiIdempotentTokenService.createToken();
    }

    /**
     * 测试接口幂等性, 在需要幂等性校验的方法上声明此注解即可
     * @return
     */
    @ApiIdempotent
    @RequestMapping("testIdempotence")
    public R testIdempotence() {
        return R.ok("测试接口幂等性");
    }
}