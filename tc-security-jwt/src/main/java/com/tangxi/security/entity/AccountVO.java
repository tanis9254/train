package com.tangxi.security.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class AccountVO implements Serializable {

    /**
     * 真实姓名
     */
    private String name;

    /**用户名
     *
     */
    private String username;

    private String password;

}
