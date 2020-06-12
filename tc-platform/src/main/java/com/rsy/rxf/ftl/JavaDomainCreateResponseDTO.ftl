package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.response;


import java.io.Serializable;
import java.util.Objects;
import ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.${model.name?cap_first}DTO;

/**
 * ${model.displayName}CreateResponseDTO
 * 创建${model.displayName} 响应DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}CreateResponseDTO implements Serializable{

    /**
	 * 创建 响应实体
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
        if (!(o instanceof ${model.name?cap_first}CreateResponseDTO)) {
            return false;
        }
        ${model.name?cap_first}CreateResponseDTO that = (${model.name?cap_first}CreateResponseDTO) o;
        return Objects.equals(${model.name?uncap_first}DTO, that.${model.name?uncap_first}DTO);
    }

    @Override
    public int hashCode() {
        return Objects.hash(${model.name?uncap_first}DTO);
    }

}
