package com.tangxi.idempotent.enumapi;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * @author: tang.xi
 * @date: 2020/6/13
 * @description:
 */
public enum ResponseCode {

    ILLEGAL_ARGUMENT(10000, "参数不合法"),
    REPETITIVE_OPERATION(10001, "请勿重复操作"),
    ;

    ResponseCode(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    @Getter
    @Setter
    private Integer code;

    @Getter
    @Setter
    private String msg;

}