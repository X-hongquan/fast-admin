<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.${className}Mapper">

    <sql id="base_column">
     <#list columns as c>
       ${c.dbName}<#if c_has_next>,</#if>
   </#list>
    </sql>


    <select id="get${className}List" resultType="${packageName}.pojo.${className}" parameterType="${packageName}.pojo.${className}">
        select
        <include refid="base_column"/>
        from ${tableInfo.tableName}
        where 1=1
        <#list columns as c>
        <#if c.type == 'String'>
        <if test="${c.name} != null and ${c.name} != '' ">
            and ${c.dbName} like concat('%',${jin}{${c.name}}, '%')
        </if>
        <#else>
        <if test="${c.name} != null">
            and ${c.dbName} = ${jin}{${c.name}}
        </if>
        </#if>
        </#list>
    </select>

    <select id="get${className}ById" resultType="${packageName}.pojo.${className}" >
        select
        <include refid="base_column"/>
        from ${tableInfo.tableName}
        where id = ${jin}{id}
    </select>
</mapper>
