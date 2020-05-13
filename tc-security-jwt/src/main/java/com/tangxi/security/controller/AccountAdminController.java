package com.tangxi.security.controller;

import cn.hutool.json.JSON;
import com.tangxi.security.entity.Account;
import com.tangxi.security.entity.AccountVO;
import com.tangxi.security.service.AccountAdminService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import rxf.springmvc.ResultModel;

import javax.validation.Valid;

/**
 * 账户管理
 *
 * @author Oliver
 * @version 1.0
 * @date 2019/9/23  17:35
 */
@RestController
@RequestMapping("/admin/permission/account")
@Api(tags = "账户管理接口", description = "账户管理相关服务")
public class AccountAdminController {


    private static final Logger LOGGER = LoggerFactory.getLogger(AccountAdminController.class);

    @Autowired
    private AccountAdminService accountAdminService;

    /**
     * 新增账号
     * 系统管理员可以创建二级管理员(可能平台管理员有权限创建二级业务管理员)
     * 二级管理员只可以创建普通账号
     *
     * @param account
     * @return
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @ApiOperation(value = "新增账号", produces = "application/json")
    @ApiImplicitParams({
        @ApiImplicitParam(paramType = "header", dataType = "String", name = "Authorization", value = "oauth2 Token", required = true, defaultValue = "Bearer xxxxxxxxxxx"),
        @ApiImplicitParam(paramType = "body", dataType = "AccountVO", name = "accountVO", value = "账号对象", required = true)
    })
    public ResultModel add(@RequestBody @Valid Account account) {
        if (accountAdminService.create(account,"")) {
            return ResultModel.createSuccess();
        }
        return ResultModel.createFailure();
    }

}
