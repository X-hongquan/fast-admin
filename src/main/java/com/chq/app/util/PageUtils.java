package com.chq.app.util;


import com.chq.app.common.domain.PageObject;
import com.github.pagehelper.PageHelper;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;

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
        pO.setCondition(request.getParameter("column"));
        pO.setCondition(request.getParameter("condition"));

        PageHelper.startPage(pO.getPageNum(), pO.getPageSize(), pO.getOrderBy());
    }
}
