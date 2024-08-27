package ${packageName}.service;

import ${packageName}.pojo.${className};
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

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
}
