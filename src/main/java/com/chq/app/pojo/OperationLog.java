package com.chq.app.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
* <p>
* 操作日志记录
 * </p>
*
* @author chq
* @since 2024-09-19
*/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("operation_log")
@NoArgsConstructor
@AllArgsConstructor
public class OperationLog  implements Serializable {

    private static final long serialVersionUID = 1L;

      @TableId(value = "id", type = IdType.ASSIGN_ID)
      private Long id;

      /**
      * 模块标题
      */
      private String title;

      /**
      * 业务类型 (1其它 2新增 3更改 4删除 5授权 6导出 7导入 8强退)
      */
      private Integer businessType;

      /**
      * 方法名称
      */
      private String method;

      /**
      * 请求方式
      */
      private String requestMethod;

      /**
      * 操作类别 (1后台用户 2其他 3手机端用户)
      */
      private Integer operatorType;

      /**
      * 操作人员
      */
      private String operationName;

      /**
      * 请求参数
      */
      private String operationParam;

      /**
      * 返回参数
      */
      private String jsonResult;

      /**
      * 操作状态 (1正常 0异常)
      */
      private Integer status;

      /**
      * 错误消息
      */
      private String errorMsg;

      /**
      * 操作时间
      */
      private LocalDateTime operationTime;

      /**
      * 消耗时间,单位ms
      */
      private Long costTime;


}
