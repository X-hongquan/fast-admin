package com.chq.app.mapper;

import com.chq.app.pojo.Dept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* <p>
* 部门 Mapper 接口
* </p>
*
* @author chq
* @since 2024-08-27
*/
public interface DeptMapper extends BaseMapper<Dept> {

    List<Dept> getDeptList(Dept dept);

    Dept getDeptById(Long id);

}