package com.chq.app.web.system.pojo;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
* <p>
* 部门
 * </p>
*
* @author chq
* @since 2024-09-29
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dept")
@NoArgsConstructor
@AllArgsConstructor
public class Dept  implements Serializable {

    private static final long serialVersionUID = 1L;

      @TableId(value = "id", type = IdType.ASSIGN_ID)
      private Integer id;

      /**
      * 部门名称 search
      */
      private String name;

      /**
      * 状态 (0:正常,1:禁用)
      */
      private Integer status;

      /**
      * 部门头像
      */
      private String avatar;

      /**
      * 父级部门id
      */
      private Integer parentId;

      /**
      * 排序
      */
      private Integer sort;

      /**
      * 创建人
      */
      private Integer createUser;

      /**
      * 创建时间
      */
      @TableField(fill = FieldFill.INSERT)
      private LocalDateTime createTime;


}
