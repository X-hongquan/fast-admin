package ${packageName}.controller;

import ${packageName}.common.domain.R;
import ${packageName}.common.domain.TableInfo;
import ${packageName}.common.annoation.PreAuth;
import ${packageName}.pojo.${className};
import ${packageName}.service.I${className}Service;
import ${packageName}.util.PageUtils;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;
import java.util.List;



/**
 * <p>
 * ${tableInfo.comment} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@RestController
@RequestMapping("/${paramsName}")
public class ${className}Controller {

    @Resource
    private I${className}Service ${paramsName}Service;


    @GetMapping("/list")
    @PreAuth(value="system:${paramsName}:query", description = "查询${tableInfo.comment}权限")
    public TableInfo<List<${className}>> list(${className} ${paramsName}) {
        PageUtils.startPage();
        List<${className}> list =${paramsName}Service.getList(${paramsName});
        return TableInfo.ok(list);
    }

    @GetMapping("/{id}")
    @PreAuth(value="system:${paramsName}:query", description = "查询${tableInfo.comment}权限")
    public R<${className}> get(@PathVariable Long id) {
        ${className} ${paramsName} = ${paramsName}Service.get${className}ById(id);
        return R.ok(${paramsName});
    }

    @PostMapping
    @PreAuth(value="system:${paramsName}:add", description = "新增${tableInfo.comment}权限")
    public R add(@RequestBody ${className} ${paramsName}) {
        ${paramsName}Service.add${className}(${paramsName});
        return R.ok();
    }

    @PutMapping
    @PreAuth(value="system:${paramsName}:edit", description = "编辑${tableInfo.comment}权限")
    public R edit(@RequestBody ${className} ${paramsName}) {
        ${paramsName}Service.edit${className}(${paramsName});
        return R.ok();
    }

    @DeleteMapping("/{ids}")
    @PreAuth(value="system:${paramsName}:remove", description = "删除${tableInfo.comment}权限")
    public R delete(@PathVariable Long[] ids) {
        ${paramsName}Service.delete${className}ByIds(ids);
        return R.ok();
    }
}
