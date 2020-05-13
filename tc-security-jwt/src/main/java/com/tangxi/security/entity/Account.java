package com.tangxi.security.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @author: tang.xi
 * @date: 2020/5/9
 * @description:
 */
@Data
@TableName("sys_account")
public class Account {
    @TableId
    private Long accountId;
    @TableField("name")
    private String name;
    @TableField("username")
    private String username;
    @TableField("password")
    private String password;
}
