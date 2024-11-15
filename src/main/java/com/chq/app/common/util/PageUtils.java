package com.chq.app.common.util;


import com.chq.app.common.domain.PageObject;
import com.github.pagehelper.PageHelper;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;

import java.util.Map;

public class PageUtils {


    public static void startPage() {
        HttpServletRequest request = WebUtils.getRequest();
        PageObject pO = new PageObject();
        if (StringUtils.isNotBlank(request.getParameter("pageNum"))) {
            pO.setPageNum(Integer.valueOf(request.getParameter("pageNum")));
        }
        if (StringUtils.isNotBlank(request.getParameter("pageSize"))) {
            pO.setPageSize(Integer.valueOf(request.getParameter("pageSize")));
        }
        Map<String, String[]> parameterMap = request.getParameterMap();
        String[] columns = parameterMap.get("column");
        String[] conditions = parameterMap.get("condition");
        pO.setColumns(columns);
        pO.setConditions(conditions);
        //防止order by字段sql注入
        PageHelper.startPage(pO.getPageNum(), pO.getPageSize(), pO.getOrderBy());
    }
}
