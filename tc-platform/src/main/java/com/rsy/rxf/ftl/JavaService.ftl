package ${project.basePackage}.business.${domain.name?uncap_first}.service;

import ${project.basePackage}.po.business.${domain.name?uncap_first}.${model.name?cap_first};
import ${project.basePackage}.vo.business.${domain.name?uncap_first}.${model.name?cap_first}VO;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;

/**
 * ${model.displayName}业务服务层
 *
 * Created by Recloud
 */
public interface ${model.name?cap_first}Service extends IService<${model.name?cap_first}>{

    /**
     * 分页查询${model.displayName}列表
     *
     * @param ${model.name?uncap_first}Page
     * @param ${model.name?uncap_first}VOCondition
     * @return
     */
	Page<${model.name?cap_first}> findPage(Page<${model.name?cap_first}> ${model.name?uncap_first}Page,${model.name?cap_first}VO ${model.name?uncap_first}VOCondition);


}
