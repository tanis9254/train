package com.tangxi.security.controller;

import com.tangxi.security.entity.Account;
import com.tangxi.security.service.PptSecurityLoginService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import rxf.springmvc.ResultModel;

import java.util.Map;

/**
 * @author: tang.xi
 * @date: 2020/5/9
 * @description:
 */
@RestController
@RequestMapping(value = "/management/security/login")
@ControllerAdvice
@Api(tags = "登录服务", description = "登录接口")
public class SecurityLoginController {

    @Autowired
    private PptSecurityLoginService securityLoginService;

    @ApiOperation("密码登录")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "Account", name = "Account", value = "登录", required = true)
    })
    @PostMapping("/password")
    public ResultModel login(@RequestBody Account account) {
        String token = securityLoginService.login(account);
        return ResultModel.success("登录成功", token);
    }
}