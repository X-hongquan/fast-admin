package com.chq.app.service;

import com.chq.app.pojo.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 菜单表 服务类
 * </p>
 *
 * @author chq
 * @since 2024-07-30
 */
public interface IMenuService extends IService<Menu> {

  List<Menu> getList(Menu menu);

  Menu getMenuById(Long id);


    List<Menu> initMenu(Menu menu);

   int add(Menu menu);

    int removeMenuByIds(Long[] ids);

    void updateMenu(Menu old,Menu fresh);
}
