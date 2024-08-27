package ${packageName}.mapper;

import ${packageName}.pojo.${className};
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* <p>
* ${tableInfo.comment} Mapper 接口
* </p>
*
* @author ${author}
* @since ${date}
*/
public interface ${className}Mapper extends BaseMapper<${className}> {

    List<${className}> get${className}List(${className} ${paramsName});

    ${className} get${className}ById(Long id);

}