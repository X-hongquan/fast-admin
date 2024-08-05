package com.chq.app.dto;



import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MenuDto {
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
     * 菜单层级 1 一级菜单 2 二级菜单 3 三级菜单
     */
    private Integer level;

    /**
     * 菜单类型 0目录 1菜单 2其他
     */
    private Integer type;

    /**
     * 菜单图标
     */
    private String icon;

    /**
     * 重定向
     */
    private String redirect;

    /**
     * 状态 1正常 0禁用
     */
    private Integer status;

    /**
     * 创建时间
     */

    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    private final List<MenuDto> children = new ArrayList<>();

}
