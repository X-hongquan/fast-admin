package com.chq.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import com.chq.app.common.domain.BaseEntity;
import com.chq.app.schedule.Cron;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 定时任务信息表
 *
 * @TableName job_info
 */
@TableName(value = "job_info")
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public class JobInfo extends BaseEntity implements Serializable {


    private static final long serialVersionUID = 1L;
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     *
     */
    private String jobName;

    /**
     *
     */
    private String jobDesc;

    /**
     * 1:fixed_rate :cron
     */
    private Integer jobType;

    /**
     * 下次执行时间
     */
    private Long jobNextTime;

    /**
     * 周期单位（ms）
     */
    private Long jobRate;

    /**
     * cron表达式
     */
    private String jobCron;

    /**
     * 触发状态,1正常运行 0停止
     */
    private Integer triggerStatus;

    /**
     * 上次调度时间
     */
    private LocalDateTime triggerLastTime;

    /**
     * 备注
     */
    private String remark;

    @TableField(exist = false)
    public Method method;


    @TableField(exist = false)
    private Cron cron;






}