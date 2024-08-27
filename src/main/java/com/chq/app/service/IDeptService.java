package com.chq.app.service;

import com.chq.app.pojo.Dept;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* <p>
* 部门 服务类
* </p>
*
* @author chq
* @since 2024-08-27
*/
public interface IDeptService extends IService<Dept> {

    List<Dept> getList(Dept dept);

    Dept getDeptById(Long id);

    void addDept(Dept dept);

    void editDept(Dept dept);

    void deleteDeptByIds(Long[] ids);
}
