package ${packageName}.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
* <p>
* ${tableInfo.comment}
 * </p>
*
* @author chq
* @since ${date}
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("${tableInfo.tableName}")
@NoArgsConstructor
@AllArgsConstructor
public class ${className}  implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list columns as column>
    <#if column.name=='id'>
      @TableId(value = "id", type = IdType.ASSIGN_ID)
      private ${column.type} id;
    </#if>
    <#if column.name!='id'>

      /**
      * ${column.completeComment}
      */<#if column.name=='createTime'>
      @TableField(fill = FieldFill.INSERT)</#if>
      private ${column.type} ${column.name};
    </#if>
</#list>


}
