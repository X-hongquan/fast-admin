package com.chq.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 定时任务日志表
 *
 * @TableName job_log
 */
@TableName(value = "job_log")
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public class JobLog implements Serializable {



    private static final long serialVersionUID = 1L;
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     *
     */
    private Integer jobId;

    /**
     * 触发时间
     */
    private LocalDateTime triggerTime;

    /**
     * 处理时间ms
     */
    private Long handleTime;

    /**
     * 处理状态 (1成功 0失败)
     */
    private Integer handleStatus;

    /**
     * 错误信息
     */
    private String errorMsg;

    /**
     * 触发信息
     */
    private String triggerMsg;

    @TableField(exist = false)
    private String startTime;

    @TableField(exist = false)
    private String endTime;

    @TableField(exist = false)
    private String jobName;


}