package com.chq.app.service.impl;



import com.chq.app.pojo.Dept;
import com.chq.app.mapper.DeptMapper;
import com.chq.app.service.IDeptService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * dept 前端控制器
 * </p>
 *
 * @author chq
 * @since 2024-08-27
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements IDeptService {

  

    @Override
    public List<Dept> getList(Dept dept) {
        List<Dept> list = baseMapper.getDeptList(dept);
        return list;
    }

    @Override
    public Dept getDeptById(Long id) {
        return baseMapper.getDeptById(id);
    }

    @Override
    public void addDept(Dept dept) {
        baseMapper.insert(dept);
    }

    @Override
    public void editDept(Dept dept) {
        baseMapper.updateById(dept);
    }

    @Override
    public void deleteDeptByIds(Long[] ids) {
        baseMapper.deleteBatchIds(Arrays.asList(ids));
    }
}
