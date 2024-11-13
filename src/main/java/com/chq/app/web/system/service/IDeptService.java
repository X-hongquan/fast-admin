package com.chq.app.web.system.service;

import com.chq.app.web.system.pojo.Dept;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
/**
* <p>
* 部门 服务类
* </p>
*
* @author chq
* @since 2024-09-29
*/
public interface IDeptService extends IService<Dept> {

    List<Dept> getList(Dept dept);

    Dept getDeptById(Long id);

    void addDept(Dept dept);

    void editDept(Dept dept);

    void deleteDeptByIds(Long[] ids);


        /**
        * 上传接口
        */
      String upload(MultipartFile file);

}
