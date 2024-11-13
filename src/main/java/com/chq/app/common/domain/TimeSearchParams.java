package com.chq.app.common.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TimeSearchParams {

    @TableField(exist = false)
    private String startTime;

    @TableField(exist = false)
    private String endTime;
}
