package com.tangxi.sharding.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

import java.io.Serializable;

/**
 * @author: tang.xi
 * @date: 2020/5/15
 * @description:
 */
@Data
@TableName("t_user")
public class User extends Model<User> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private Long id;
    /**
     * 顺序编号
     */
    @TableField("order_id")
    private Long orderId;
    /**
     * 用户编号
     */
    @TableField("user_id")
    private Long userId;
    /**
     * 用户名
     */
    @TableField("user_name")
    private String userName;
    /**
     * 密码
     */
    @TableField("pass_word")
    private String passWord;
    /**
     * 倪名
     */
    @TableField("nick_name")
    private String nickName;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", userId=" + userId +
                ", userName=" + userName +
                ", passWord=" + passWord +
                ", nickName=" + nickName +
                "}";
    }
}
