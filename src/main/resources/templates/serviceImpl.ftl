package ${packageName}.service.impl;



import ${packageName}.pojo.${className};
import ${packageName}.mapper.${className}Mapper;
import ${packageName}.service.I${className}Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import java.util.Arrays;
import java.util.List;

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
}
