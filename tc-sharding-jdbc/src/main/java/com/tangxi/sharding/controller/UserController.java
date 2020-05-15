package com.tangxi.sharding.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.tangxi.sharding.entity.User;
import com.tangxi.sharding.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Random;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@RestController
@RequestMapping("/web/user")
public class UserController {
    @Autowired
    IUserService userService;

    @RequestMapping("/save")
    public String save(){
        User user2 = new User();
        for (int i = 0; i < 10; i++) {
            user2.setUserId(IdWorker.getId());
            Random r = new Random();
            user2.setOrderId((long)r.nextInt(100));
            user2.setNickName("owenma"+i);
            user2.setPassWord("password"+i);
            user2.setUserName("userName"+i);
            userService.save(user2);
        }
        return "success";
    }

    @RequestMapping("/findAll")
    public String findAll(){
        List<User> list = userService.list(new QueryWrapper<User>().orderByDesc("order_id"));
        return JSONObject.toJSONString(list);
    }
}