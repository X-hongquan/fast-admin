package com.chq.app.web.system.service.impl;



import com.chq.app.common.exception.ServiceException;
import com.chq.app.web.system.pojo.Dept;
import com.chq.app.web.system.mapper.DeptMapper;
import com.chq.app.web.system.service.IDeptService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.chq.app.web.system.service.IFileService;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * <p>
 * dept 前端控制器
 * </p>
 *
 * @author 神
 * @since 2024-09-29
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements IDeptService {
    @Autowired
    private IFileService fileService;

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


        /**
        * 上传接口
        */
    public String upload(MultipartFile file) {
          String s = null;
          try {
             s = fileService.uploadImg(file.getContentType(), file.getOriginalFilename(), file.getBytes(), null);
          } catch (IOException e) {
             log.error("文件上传失败", e);
             throw new ServiceException("文件上传失败");
          }
          return s;
     }
}
