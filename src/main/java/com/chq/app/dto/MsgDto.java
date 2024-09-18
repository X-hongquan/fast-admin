package com.chq.app.dto;


import com.chq.app.dto.enums.MsgTypeEnum;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * ws 消息传输对象
 */
@Data
@Accessors(chain = true)
public class MsgDto {
    private Long id;
    private MsgTypeEnum type;
    private Object data;


}
