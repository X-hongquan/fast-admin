package com.chq.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * 
 * @TableName login_log
 */
@TableName(value ="login_log")
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
public class LoginLog implements Serializable {


    private static final long serialVersionUID = 1L;
    /**
     * 
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 登录ip
     */
    private String ip;

    /**
     * ip归属地
     */
    private String location;

    /**
     * 登录时间
     */
    private LocalDateTime loginTime;

    /**
     * 登录人
     */
    private String loginUser;

    /**
     * 
     */
    private String token;


    @TableField(exist = false)
    private String startTime;

    @TableField(exist = false)
    private String endTime;

}