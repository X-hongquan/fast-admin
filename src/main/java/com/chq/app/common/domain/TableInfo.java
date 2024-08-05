package com.chq.app.common.domain;

import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TableInfo<T> {

    private Integer code;
    private T data;
    private String msg;
    private Long total;


    public static <T> TableInfo<List<T>> ok(List<T> data) {
        PageInfo page = new PageInfo(data);
        return new TableInfo<>(200, data,null, page.getTotal());
    }

    public static <T> TableInfo<List<T>> ok(List<T> data,Long total) {
        return new TableInfo<>(200, data,null, total);
    }


    public static <T> R<T> fail(String msg) {
        return new R<>(500, msg, null);
    }
}
