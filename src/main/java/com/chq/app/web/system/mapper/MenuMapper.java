package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;


/**
 * <p>
 * 菜单表 Mapper 接口
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface MenuMapper extends BaseMapper<Menu> {


    List<Menu> getMenuList(Menu menu);

    List<Menu> getInitMenu(Menu menu);

    int selectMaxSortBySameParentId(Menu menu);


    int updateMenuAdaptSort(Menu fresh);
}
