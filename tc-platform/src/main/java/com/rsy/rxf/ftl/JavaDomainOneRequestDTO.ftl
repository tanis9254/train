package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.request;


import java.io.Serializable;
import java.util.Objects;
import ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.${model.name?cap_first}DTO;

/**
 * ${model.displayName}OneRequestDTO
 * 单个${model.displayName} 请求DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}OneRequestDTO implements Serializable{

    /**
	 * 请求参数
	 *
	 */
    private ${model.name?cap_first}DTO searchCondition;

    public ${model.name?cap_first}DTO getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(${model.name?cap_first}DTO searchCondition) {
        this.searchCondition = searchCondition;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}OneRequestDTO)) {
            return false;
        }
        ${model.name?cap_first}OneRequestDTO that = (${model.name?cap_first}OneRequestDTO) o;
        return Objects.equals(searchCondition, that.searchCondition);
    }

    @Override
    public int hashCode() {
        return Objects.hash(searchCondition);
    }

}
