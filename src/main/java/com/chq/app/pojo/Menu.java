package com.chq.app.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;

import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;

import java.io.Serializable;

import com.chq.app.common.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 菜单表
 * </p>
 *
 * @author chq
 * @since 2024-08-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("menu")
public class Menu extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 菜单名称
     */
    private String name;

    /**
     * 父菜单id
     */
    private Long parentId;

    /**
     * 组件路径
     */
    private String component;

    /**
     * 路由路径
     */
    private String url;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 菜单标题
     */
    private String title;

    /**
     * 菜单层级
     */
    private Integer level;

    /**
     * 菜单类型 (0目录 1菜单 2其他)
     */
    private Integer type;

    /**
     * 菜单图标
     */
    private String icon;

    /**
     * 状态 (1正常 0禁用)
     */
    private Integer status;


    /**
     * 重定向
     */
    private String redirect;


    /**
     * 是否外链 (0非外链 1外链)
     */
    private Integer link;


}
