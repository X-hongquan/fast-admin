package com.chq.app.web.system.pojo;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;

import java.io.Serializable;
import java.util.Set;

import com.chq.app.common.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户表
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("user")
public class    User extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 加密后的密码
     */
    private String password;

    /**
     * 手机号码
     */
    private String phone;


    /**
     * 性别 (1男 2女 3其它)
     */
    private Integer gender;


    /**
     * 头像
     */
    private String avatar;

    /**
     * 状态 (1正常 0停用)
     */
    private Integer status;

    /**
     * 邮箱
     */
    private String email;


    /**
     * 昵称
     */
    private String nickName;


    @TableField(exist = false)
    @ExcelIgnore
    private Set<Role> roles;


}
