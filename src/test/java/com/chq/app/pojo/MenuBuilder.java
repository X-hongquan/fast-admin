package com.chq.app.pojo;

import com.chq.app.common.util.SpringUtils;
import com.chq.app.web.system.mapper.MenuMapper;
import com.chq.app.web.system.pojo.Menu;
import lombok.experimental.Accessors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Accessors(chain = true)
public class MenuBuilder {


    private MenuMapper menuMapper= SpringUtils.getBean(MenuMapper.class);


    private Menu menu;
    private Menu parent;


    public MenuBuilder() {
        menu = new Menu();
        menu.setLink(0)
                .setIcon("User")
                .setCreateBy("admin")
                .setUpdateBy("admin")
                .setUpdateTime(LocalDateTime.now())
                .setCreateTime(LocalDateTime.now());


    }

    public MenuBuilder setParentId(Long parentId) {
        if (parentId != 0L)
            parent = menuMapper.selectById(parentId);
        menu.setParentId(parentId);
        menu.setSort(menuMapper.selectMaxSortBySameParentId(menu) + 1);
        setLevel();
        return this;
    }

    public MenuBuilder setName(String name) {
        menu.setName(name);
        return this;
    }

    public MenuBuilder setUrl(String url) {
        menu.setUrl(url);
        return this;
    }

    public MenuBuilder setComponent(String component) {
        menu.setComponent(component);
        return this;
    }

    public MenuBuilder setTitle(String title) {
        menu.setTitle(title);
        return this;
    }


    public MenuBuilder setRedirect(String url) {
        menu.setRedirect(url);
        return this;
    }

    public MenuBuilder setType(Integer type) {
        menu.setType(type);
        return this;
    }




    private MenuBuilder setLevel() {
        if (parent != null)
            menu.setLevel(parent.getLevel() + 1);
        menu.setLevel(1);
        return this;
    }





       public Menu build() {
        setLevel();
        return menu;
      }
    
}
