package ${packageName}.service.impl;



import ${packageName}.pojo.${className};
import ${packageName}.mapper.${className}Mapper;
import ${packageName}.service.I${className}Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import java.util.Arrays;
import java.util.List;
<#list columns as c>
    <#if c.img== 'y'>
import org.springframework.web.multipart.MultipartFile;
import com.chq.app.web.system.service.IFileService;
import org.springframework.beans.factory.annotation.Autowired;
    </#if>
</#list>
/**
 * <p>
 * ${tableInfo.tableName} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Service
public class ${className}ServiceImpl extends ServiceImpl<${className}Mapper, ${className}> implements I${className}Service {
  <#list columns as c>
    <#if c.img == 'y'>
    @Autowired
    private IFileService fileService;
    </#if>
  </#list>

    @Override
    public List<${className}> getList(${className} ${paramsName}) {
        List<${className}> list = baseMapper.get${className}List(${paramsName});
        return list;
    }

    @Override
    public ${className} get${className}ById(Long id) {
        return baseMapper.get${className}ById(id);
    }

    @Override
    public void add${className}(${className} ${paramsName}) {
        baseMapper.insert(${paramsName});
    }

    @Override
    public void edit${className}(${className} ${paramsName}) {
        baseMapper.updateById(${paramsName});
    }

    @Override
    public void delete${className}ByIds(Long[] ids) {
        baseMapper.deleteBatchIds(Arrays.asList(ids));
    }


<#list columns as c>
    <#if c.img== 'y'>
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
    </#if>
</#list>
}
