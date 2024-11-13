package ${packageName}.service;

import ${packageName}.pojo.${className};
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
<#list columns as c>
    <#if c.img== 'y'>
import org.springframework.web.multipart.MultipartFile;
    </#if>
</#list>
/**
* <p>
* ${tableInfo.comment} 服务类
* </p>
*
* @author chq
* @since ${date}
*/
public interface I${className}Service extends IService<${className}> {

    List<${className}> getList(${className} ${paramsName});

    ${className} get${className}ById(Long id);

    void add${className}(${className} ${paramsName});

    void edit${className}(${className} ${paramsName});

    void delete${className}ByIds(Long[] ids);


   <#list columns as c>
    <#if c.img== 'y'>
        /**
        * 上传接口
        */
      String upload(MultipartFile file);
    </#if>
  </#list>

}
