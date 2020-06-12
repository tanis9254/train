package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.request;


import java.io.Serializable;
import java.util.Objects;
import ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.${model.name?cap_first}DTO;

/**
 * ${model.displayName}UpdateRequestDTO
 * 更新${model.displayName} 请求DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}UpdateRequestDTO implements Serializable{

    /**
	 * 更新 请求实体
	 *
	 */
    private ${model.name?cap_first}DTO ${model.name?uncap_first}DTO;

    public ${model.name?cap_first}DTO get${model.name?cap_first}DTO() {
        return ${model.name?uncap_first}DTO;
    }

    public void set${model.name?cap_first}DTO(${model.name?cap_first}DTO ${model.name?uncap_first}DTO) {
        this.${model.name?uncap_first}DTO = ${model.name?uncap_first}DTO;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}UpdateRequestDTO)) {
            return false;
        }
        ${model.name?cap_first}UpdateRequestDTO that = (${model.name?cap_first}UpdateRequestDTO) o;
        return Objects.equals(${model.name?uncap_first}DTO, that.${model.name?uncap_first}DTO);
    }

    @Override
    public int hashCode() {
        return Objects.hash(${model.name?uncap_first}DTO);
    }

}
