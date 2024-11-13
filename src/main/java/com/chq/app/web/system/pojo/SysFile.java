package com.chq.app.web.system.pojo;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 文件存储表
 * @TableName sys_file
 */
@TableName(value ="sys_file")
@Data
public class SysFile implements Serializable {


    private static final long serialVersionUID = 1L;
    /**
     * 
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 文件md5
     */
    private String md5;

    /**
     * 文件名
     */
    private String filename;


    /**
     * 资源路径
     */
    private String url;

    /**
     * 上传时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 文件内容
     */
    private byte[] content;


}