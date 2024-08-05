package com.chq.app.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum PermissionModeEnum {



    CAPITALIST(0, "0 - 资本家模式, 我的附庸可以拥有我全部权力"),

    KING(1, "1 - 封建者模式, 我的附庸只能拥有我创建的权力");

    @EnumValue
    @JsonValue
    private int value;


    private String description;


}
