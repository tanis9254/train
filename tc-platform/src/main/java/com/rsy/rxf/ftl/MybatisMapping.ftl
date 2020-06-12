<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${project.basePackage}.business.${model.domain.name?uncap_first}.dao.${model.name?cap_first}Dao">

    <sql id="allColumns">
        id,
<#list model.attribute as pro>
    <#if pro.persist>
        <#if pro.type == 'Reference'>
        ${improvedNamingStrategy(pro.name?cap_first)}_id,
        <#else>
        ${improvedNamingStrategy(pro.name?cap_first)},
        </#if>
    </#if>
</#list>
        create_time,update_time,creator,updator
    </sql>

</mapper>
