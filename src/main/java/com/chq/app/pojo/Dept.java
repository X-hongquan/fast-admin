package com.chq.app.pojo;

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
* 部门
 * </p>
*
* @author chq
* @since 2024-08-27
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
      private Long id;

      /**
      * 部门名称
      */
      private String name;

      /**
      * 状态
      */
      private Integer status;


}
