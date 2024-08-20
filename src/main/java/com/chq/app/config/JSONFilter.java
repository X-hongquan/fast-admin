package com.chq.app.config;

import com.chq.app.common.filter.PropertyPreExcludeFilter;
import org.apache.commons.lang3.ArrayUtils;

public class JSONFilter {

    public static final String[] EXCLUDE_PROPERTIES = {"password", "oldPassword", "newPassword", "confirmPassword"};

    public static PropertyPreExcludeFilter excludePropertyPreFilter() {
        return new PropertyPreExcludeFilter().addExcludes(EXCLUDE_PROPERTIES);
    }
}
