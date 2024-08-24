package com.chq.app.util;

import com.chq.app.common.exception.ServiceException;
import com.github.pagehelper.dialect.ReplaceSql;

import java.util.Set;
import java.util.regex.Pattern;

public class SqlUtil {

    private static final Pattern SAFE_CHARACTERS = Pattern.compile("^[a-zA-Z0-9_]*$");


    //随意
    private static final Set<String> SQL_KEYWORDS = Set.of(
            "select", "insert", "update", "delete", "truncate", "drop", "create", "alter", "rename",
            "union", "intersect", "except", "join", "on", "in", "like", "between", "and", "or", "not", "is", "null",
            "exists", "distinct", "group", "by", "having", "order", "asc", "desc", "limit", "offset", "for",
            "into", "values", "set", "from", "where", "case", "when", "then", "else", "end", "as", "with", "recursive",
            "table", "view", "index", "primary", "key", "foreign", "references", "check", "default", "unique", "constraint",
            "procedure", "function", "trigger", "event", "database", "schema", "privilege", "grant", "revoke"
    );

    //防止注入关键字
    public static void checkOrderByColumn(String column) {
        if (!SAFE_CHARACTERS.matcher(column).matches() || SQL_KEYWORDS.contains(column.toLowerCase()))
            throw new ServiceException("存在SQL注入风险");
    }

    public static void checkOrderByCondition(String val) {
        if (!"asc".equals(val) && !"desc".equals(val)) {
            throw new ServiceException("存在SQL注入风险");
        }
    }
}
