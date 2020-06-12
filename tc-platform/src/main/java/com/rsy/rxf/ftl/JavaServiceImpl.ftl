package ${project.basePackage}.business.${domain.name?uncap_first}.service.impl;

import ${project.basePackage}.po.business.${domain.name?uncap_first}.${model.name?cap_first};
import ${project.basePackage}.business.${domain.name?uncap_first}.dao.${model.name?cap_first}Dao;
import ${project.basePackage}.business.${domain.name?uncap_first}.service.${model.name?cap_first}Service;
import ${project.basePackage}.vo.business.${domain.name?uncap_first}.${model.name?cap_first}VO;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.BeanUtils;


/**
 * ${model.displayName}业务服务层实现类
 *
 * Created by Recloud
 */
@Service("${model.name?uncap_first}Service")
@Transactional(rollbackFor = Exception.class)
public class ${model.name?cap_first}ServiceImpl extends ServiceImpl<${model.name?cap_first}Dao,${model.name?cap_first}> implements ${model.name?cap_first}Service{

    /**
     * 分页查询${model.displayName}列表
     *
     * @param ${model.name?uncap_first}Page
     * @param ${model.name?uncap_first}VOCondition
     * @return
     */
    @Override
    public Page<${model.name?cap_first}> findPage(Page<${model.name?cap_first}> ${model.name?uncap_first}Page, ${model.name?cap_first}VO ${model.name?uncap_first}VOCondition) {
        ${model.name?cap_first} search${model.name?cap_first}= new ${model.name?cap_first}();
        BeanUtils.copyProperties(${model.name?uncap_first}VOCondition, search${model.name?cap_first});
        EntityWrapper<${model.name?cap_first}> entityWrapper = new EntityWrapper<>(search${model.name?cap_first});
<#list model.attribute as pro>
    <#if pro.type =='Date' || pro.type =='DateTime' >
        if (null != ${model.name?uncap_first}VOCondition.get${pro.name?cap_first}Start()) {
            entityWrapper.ge("${improvedNamingStrategy(pro.name?cap_first)}",${model.name?uncap_first}VOCondition.get${pro.name?cap_first}Start());
        }
        if (null != ${model.name?uncap_first}VOCondition.get${pro.name?cap_first}End() ) {
            entityWrapper.le("${improvedNamingStrategy(pro.name?cap_first)}",${model.name?uncap_first}VOCondition.get${pro.name?cap_first}End());
        }
    </#if>
</#list>
        return this.selectPage(${model.name?uncap_first}Page, entityWrapper);
    }
}
