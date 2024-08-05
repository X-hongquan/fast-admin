//package com.chq.app.util;
//
//
//import com.chq.app.common.domain.LoginUser;
//import com.chq.app.common.domain.TableInfo;
//import com.chq.app.pojo.Role;
//import net.sf.jsqlparser.expression.Alias;
//import net.sf.jsqlparser.expression.Expression;
//import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
//import net.sf.jsqlparser.expression.operators.relational.InExpression;
//import net.sf.jsqlparser.parser.CCJSqlParser;
//import net.sf.jsqlparser.parser.CCJSqlParserUtil;
//import net.sf.jsqlparser.schema.Table;
//import net.sf.jsqlparser.statement.Statement;
//import net.sf.jsqlparser.statement.select.FromItem;
//import net.sf.jsqlparser.statement.select.Join;
//import net.sf.jsqlparser.statement.select.PlainSelect;
//import net.sf.jsqlparser.statement.select.Select;
//import org.apache.ibatis.executor.statement.StatementHandler;
//import org.apache.ibatis.mapping.BoundSql;
//import org.apache.ibatis.mapping.MappedStatement;
//import org.apache.ibatis.plugin.*;
//
//import org.apache.ibatis.reflection.MetaObject;
//import org.apache.ibatis.reflection.SystemMetaObject;
//import org.springframework.stereotype.Component;
//
//
//import java.lang.reflect.Field;
//import java.sql.Connection;
//import java.util.Collection;
//import java.util.List;
//import java.util.Properties;
//import java.util.Set;
//
//
//@Intercepts({
//        @Signature(type = StatementHandler.class, method = "query", args = {Connection.class, Integer.class})
//})
//@Component
//public class DataFilterInterceptor implements Interceptor {
//    @Override
//    public Object intercept(Invocation invocation) throws Throwable {
//        // 获取方法参数
//        LoginUser loginUser = UserHolder.getUser();
//        if (loginUser.isAdmin())
//            return invocation.proceed();
//
//        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
//        BoundSql boundSql = statementHandler.getBoundSql();
//        String sql = boundSql.getSql();
//        Field sqlField = boundSql.getClass().getDeclaredField("sql");
//        sqlField.setAccessible(true);
//        sqlField.set(boundSql, newSql);
//
//        String type = sql.substring(0, 7);
//        if (!"select".equalsIgnoreCase(type)) {
//            return invocation.proceed();
//        }
//
//        PlainSelect plainSelect = (PlainSelect) CCJSqlParserUtil.parse(sql);
//        List<Join> joins = plainSelect.getJoins();
//        String alias = null;
//        String name = null;
//        for (Join join : joins) {
//            Table table = (Table) join.getFromItem();
//            if (name.contains("role_")) {
//                name = table.getName();
//                alias = table.getAlias().getName();
//                Set<Role> roles = loginUser.getRoles();
//                StringBuilder sb = new StringBuilder(alias).append(".").append("role_id").append(" IN (");
//
//                for (Role role : roles) {
//                    sb.append(String.valueOf(role.getId())).append(",");
//                }
//                sb.deleteCharAt(sb.length() - 1).append(")");
//                Expression expression = CCJSqlParserUtil.parseExpression(sb.toString());
//
//                Collection<Expression> onExpressions = join.getOnExpressions();
//                for (Expression onExpression : onExpressions) {
//                    expression = new AndExpression(expression, onExpression);
//                    join.getOnExpressions().clear();
//                    join.addOnExpression(expression);
//                    break;
//                }
//                break;
//            }
//
//        }
//    }
//
//
//}
//
//
//// 简单的 SQL 过滤示例
////    private String filterSql(String sql) {
////        // 这里添加过滤逻辑，比如：
////        // return sql + " WHERE some_column = some_value";
////        return sql; // 这里只是简单返回原 SQL，实际应用中需要根据业务需求实现过滤逻辑
////    }
////
////    // 复制 MappedStatement
////    private MappedStatement copyFromMappedStatement(MappedStatement ms, SqlSource newSqlSource) {
////        MappedStatement.Builder builder = new MappedStatement.Builder(ms.getConfiguration(), ms.getId(), newSqlSource, ms.getSqlCommandType());
////        builder.resource(ms.getResource());
////        builder.fetchSize(ms.getFetchSize());
////        builder.statementType(ms.getStatementType());
////        builder.keyGenerator(ms.getKeyGenerator());
////        if (ms.getKeyProperties() != null && ms.getKeyProperties().length != 0) {
////            StringBuilder keyProperties = new StringBuilder();
////            for (String keyProperty : ms.getKeyProperties()) {
////                keyProperties.append(keyProperty).append(",");
////            }
////            keyProperties.delete(keyProperties.length() - 1, keyProperties.length());
////            builder.keyProperty(keyProperties.toString());
////        }
////        builder.timeout(ms.getTimeout());
////        builder.parameterMap(ms.getParameterMap());
////        builder.resultMaps(ms.getResultMaps());
////        builder.resultSetType(ms.getResultSetType());
////        builder.cache(ms.getCache());
////        builder.flushCacheRequired(ms.isFlushCacheRequired());
////        builder.useCache(ms.isUseCache());
////        return builder.build();
////    }
////
////    @Override
////    public Object plugin(Object target) {
////        return Plugin.wrap(target, this);
////    }
////
////    @Override
////    public void setProperties(Properties properties) {
////        // 可以在这里读取配置文件中的属性
////        System.out.println(properties);
////    }
////
////    // 定义一个内部类来包装新的 BoundSql
////    public static class BoundSqlSqlSource implements SqlSource {
////        private BoundSql boundSql;
////        public BoundSqlSqlSource(BoundSql boundSql) {
////            this.boundSql = boundSql;
////        }
////        @Override
////        public BoundSql getBoundSql(Object parameterObject) {
////            return boundSql;
////        }
////    }
//}
