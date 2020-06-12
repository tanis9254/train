package ${project.basePackage}.business.${domain.name?uncap_first}.dao;


import ${project.basePackage}.po.business.${domain.name?uncap_first}.${model.name?cap_first};

import com.rsy.rxf.datasource.mybatis.BaseDao;
import org.apache.ibatis.annotations.Mapper;


/**
 * ${model.displayName} 数据操作层
 *
 * Created by Recloud
 */
@Mapper
public interface ${model.name?cap_first}Dao extends BaseDao<${model.name?cap_first}> {

}
