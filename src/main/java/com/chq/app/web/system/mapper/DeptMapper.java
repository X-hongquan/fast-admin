package com.chq.app.web.system.mapper;

import com.chq.app.web.system.pojo.Dept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* <p>
* 部门 Mapper 接口
* </p>
*
* @author 神
* @since 2024-09-29
*/
public interface DeptMapper extends BaseMapper<Dept> {

    List<Dept> getDeptList(Dept dept);

    Dept getDeptById(Long id);

}