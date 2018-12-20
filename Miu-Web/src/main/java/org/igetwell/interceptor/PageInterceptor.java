package org.igetwell.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.sql.Connection;
import java.util.Map;
import java.util.Properties;

/**
 * @ClassName: PageInterceptor
 * @ProjectName MiuParent
 * @Description: TODO
 * @Author user
 * @Date 2018/12/20 14:49
 * @Version 1.0
 */
@Slf4j
//@Intercepts({ @Signature(method = "prepare", type = StatementHandler.class, args = { Connection.class }) })
@Intercepts({@Signature(type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class})})
public class PageInterceptor implements Interceptor {

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        //获取StatementHandler，默认是RoutingStatementHandler
        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
        //获取statementHandler包装类
        MetaObject MetaObjectHandler = SystemMetaObject.forObject(statementHandler);

        //获取查询接口映射的相关信息
        MappedStatement mappedStatement = (MappedStatement) MetaObjectHandler.getValue("delegate.mappedStatement");
        String mapId = mappedStatement.getId();
        //拦截以.ByPage结尾的请求，分页功能的统一实现
        if (mapId.matches("getList")) {
            //获取进行数据库操作时管理参数的handler
            ParameterHandler parameterHandler = (ParameterHandler) MetaObjectHandler.getValue("delegate.parameterHandler");
            //获取请求时的参数
            Map<String, Object> paraObject = (Map<String, Object>) parameterHandler.getParameterObject();
            //也可以这样获取
            //paraObject = (Map<String, Object>) statementHandler.getBoundSql().getParameterObject();

            String sql = (String) MetaObjectHandler.getValue("delegate.boundSql.sql");
            //也可以通过statementHandler直接获取
            //sql = statementHandler.getBoundSql().getSql();
            log.info("mybatis intercept sql:{}", sql);

            //将构建完成的分页sql语句赋值个体'delegate.boundSql.sql'，偷天换日
            //MetaObjectHandler.setValue("delegate.boundSql.sql", limitSql);
        }
        //调用原对象的方法，进入责任链的下一级
        return invocation.proceed();
    }

    /**
     * 获取代理对象
     * @param target
     * @return
     */
    @Override
    public Object plugin(Object target) {
        //生成object对象的动态代理对象
        if (target instanceof Executor) {
            return Plugin.wrap(target, this);
        } else {
            return target;
        }
    }

    /**
     * 设置代理对象
     * @param properties
     */
    @Override
    public void setProperties(Properties properties) {
        //如果项目中分页的pageSize是统一的，也可以在这里统一配置和获取，这样就不用每次请求都传递pageSize参数了。参数是在配置拦截器时配置的。
        //String limit = properties.getProperty("limit", "10");
        //this.pageSize = Integer.valueOf(limit);
        String dialect = properties.getProperty("dialect");
        log.info("mybatis intercept dialect:{}", dialect);
        //this.dbType = properties.getProperty("dbType", "mysql");
    }
}
