package com.chq.app.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 邮件消息对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageDto {

    private String theme;
    private String content;
    private String to;

}
